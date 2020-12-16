/** POS_SRV.C ********************************************************/
/*** IBM Corporation                                               ***/
/*** OS/2-AIX PSP Systems Performance                              ***/
/*** Department 57LS                                               ***/
/*** 11400 Burnet Road                                             ***/
/*** Austin Texas 78759                                            ***/
/*** Bob Russell, ZIP 9151                                         ***/
/*** (512) 838-0844 TL 678-0844                                    ***/
/*** robert_russell@vnet.ibm.com                                   ***/
/*********************************************************************/
/*****************************************************************************
 * COPYRIGHT:                                                                *
 * ----------                                                                *
 * Copyright (C) International Business Machines Corp., 1993,1994,1995,1996. *
 *                                                                           *
 * DISCLAIMER OF WARRANTIES:                                                 *
 * -------------------------                                                 *
 * The following [enclosed] code is sample code created by IBM               *
 * Corporation.  This sample code is not part of any standard IBM product    *
 * and is provided to you solely for the purpose of assisting you in the     *
 * development of your applications.  The code is provided "AS IS",          *
 * without warranty of any kind.  IBM shall not be liable for any damages    *
 * arising out of your use of the sample code, even if they have been        *
 * advised of the possibility of such damages.                               *
 *****************************************************************************/
/*************************************************************************
 * MODULE NAME:
 *
 *      POS_SRV.C
 *
 *      POS Application Server
 *
 *
 * MODIFICATION HISTORY:
 *
 * 10/16/92 Russell  - Initial Build
 * 11/05/92 Russell  - Add rpc_ns_binding_export
 * 12/01/92 Russell  - Add rpc_ns_binding_unexport to hari_kari routine
 * 12/01/92 Russell  - Clean up Error Handling routine
 * 09/16/93 Russell  - Begin conversion to distributed stubs
 * 09/20/93 Russell  -   Completed PTQ distributed stub
 * 09/21/93 Russell  -   Completed CMR distributed stub
 * 03/09/95 Russell  - Added DB2/2 Agent Process initialization
 * 01/10/96 Russell  - Modify OUT0.DAT format to match changes to MOM.C
 *
 * ABSTRACT:
 *
 *     RPC application server for the POS Benchmark.
 *
 * COMPILE NOTES:
 *
 *     See makefile
 *
 ************************************************************************/


#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>
#include <fcntl.h>

#ifndef IBMOS2
 #include <sys/timeb.h>
 #include <sys/stat.h>
 #include <sys/types.h>
#else
 #define INCL_DOSPROCESS
 #include <process.h>
 #include <os2.h>
 #include <sys\timeb.h>
 #include <sys\stat.h>
 #include <sys\types.h>
 #include <io.h>
 #include "dcedef.h"
#endif

#include "pos_idl.h"
#include "rpc.h"

#include "pos.h"

#ifdef DB22
 #include "sqlagent.h"
#endif

/***************************************************************/

#ifndef POS_STANDALONE
 #include "ptq_idl.h"
 #include "cmr_idl.h"
#endif

#ifdef POS_SECONDARY
 #define MAX_CONCURRENT_CALLS 16
#else
 #define MAX_CONCURRENT_CALLS 64
 #include "pos_idl.h"
#endif



#define THE_USER "cell_admin"
#define THE_PASSWORD "-dce-"

#ifdef IBMOS2
 char back_s[2] = "\\";
#else
 char back_s[2] = "/";
#endif

char            input_file[80];
int             hist_file_handle;
time_t          CURTIME;

unsigned int    server_role = 1; /* 1 = Primary or Standalone */

unsigned char  *POS_NAME[]   ={"",
                               "/.:/PointOfSale",
                               "",
                               "/.:/POS_PTQ",
                               "/.:/POS_CMR",
                               ""
                               };
rpc_if_handle_t POS_SPEC[6];
#ifdef POS_PRIMARY
 rpc_binding_handle_t POS_BINDINGS[6];
#endif
/************************ Prototypes ************************************/
int main(int argc, char *argv[]);

void CrashRecovery (rpc_binding_handle_t *bind_h, int sid );
short         the_server_crashed;

int get_uresp(char *prompt,char *buffer,int num);

#ifndef POS_PRIMARY
 #ifdef NODBM
  void               CloseCMRFiles(void);
  void               OpenCMRFiles(void);
  void               ClosePriceFiles(void);
  void               OpenPriceFiles(void);
 #endif
#endif


#ifndef POS_SECONDARY

 unsigned long      WriteHistory(SAVE_DATA * sendbuf, unsigned short in_len);
 unsigned long      CloseHistoryFile(int hfh);

 void               hari_kari(void);

#endif

void perhaps_an_error( error_status_t st,
                       double api_resp_time,
                       unsigned char err_msg[160]);


#ifdef AIX_PROD
 #define DCEAPI
#endif

extern void DCEAPI dce_error_inq_text (
    unsigned long           status_to_convert,
    unsigned char           *error_text,
    int                     *status
);


void GO_EXPORT_BINDING(  unsigned char * IFName,
                          rpc_if_handle_t IFSpec);

#ifdef POS_PRIMARY

 void GO_GET_BINDING(  unsigned char * IFName,
                       rpc_if_handle_t IFSpec,
                       rpc_binding_handle_t *bind_h );


#endif
#ifdef DB22
 #ifndef POS_PRIMARY
   void KillDB22Agents(void);
 #endif
#endif
/*********************************************************************
 *** MAIN
 *********************************************************************/

int main(int argc, char *argv[])
{
  int                  i;
  char                 Date[12], Time[12];
  unsigned char        *env_pntr;
  unsigned char        host_name[12];
  FILE                 *fp;
  unsigned long        rc;
  char                 buffer[2];
  error_status_t       st;

  #ifdef DB22
   #ifndef POS_PRIMARY
    char            * WorkChar            = "            ";
    unsigned char   NameBuf[40]         ="\\SHAREMEM\\POSDATA000";
    unsigned long   SizeBuf             = sizeof(POS_STUFF); // 4096;
    unsigned long   FlagsBuf            = PAG_READ |
                                          PAG_WRITE |
                                          PAG_COMMIT |
                                          PAG_EXECUTE |
                                          OBJ_TILE ;


    /* override priority RPC sets it at 021B */
    DosSetPriority(1,2,0,0);
   #endif
  #endif
  /********* END OF LOCAL VARS *************************************/

  #ifndef POS_SECONDARY
   POS_SPEC[1] = PointOfSale_v0_0_s_ifspec;
  #endif
  #ifdef POS_PRIMARY
   POS_SPEC[3] = POS_PTQ_v0_0_c_ifspec;
   POS_SPEC[4] = POS_CMR_v0_0_c_ifspec;
  #endif
  #ifdef POS_SECONDARY
   POS_SPEC[3] = POS_PTQ_v0_0_s_ifspec;
   POS_SPEC[4] = POS_CMR_v0_0_s_ifspec;
  #endif

  time(&CURTIME);
  strftime(Date, 9, "%D", localtime(&CURTIME));
  strftime(Time, 9, "%T", localtime(&CURTIME));

  #ifndef POS_SECONDARY
   /* copy root path  name */
   if ((env_pntr = getenv("POSDIR")))
   {
      strcpy(input_file, env_pntr);
      strcat(input_file, back_s);
      strcat(input_file, "OUT0.DAT\0");
   }
   else
    strcpy(input_file, "OUT0.DAT\0");

   fp=fopen(input_file,"w");
   fclose(fp);
  #endif

  if (!(env_pntr = getenv("HOSTNAME")))
  {
    printf("Environment variable 'host_name' not found.\n");
    exit(0);
  }
  else
  {
    strcpy(host_name, env_pntr);
    printf("Using host_name <%s>.\n", host_name);
  }

  #ifdef POS_SECONDARY
    if (argc != 2)
    {
      printf("Usage: %s server_role\n", argv[0]);
      printf("          3 PriceTableQuery       Server\n");
      printf("          4 CustomerMasterRecord  Server\n");
      exit(0);
    }
    printf("This is a POS Surrogate Server\n");
    server_role = atoi(argv[1]);
  #else
   #ifdef POS_PRIMARY
    printf("This is a POS Primary Server\n");
   #else
    printf("This is a POS Standalone Server\n");
   #endif
   server_role = 1;
  #endif

 /********************************************************
  * Spawn a POS Database Agent process
  ********************************************************/
  #ifdef DB22
   #ifndef POS_PRIMARY
     for (i=0;i<NUM_AGENTS;i++)
     {
       CreateAgentSem(i);
       CreateServrSem(i);
       /*****************************************************************
        * Allocate some share memory for the POS DB agent converse
        *****************************************************************/
       (void)sprintf(NameBuf,"\\SHAREMEM\\POSDATA%d\0",i);

       if ((rc = DosAllocSharedMem(&ShareBuf[i],NameBuf,SizeBuf,FlagsBuf) ))
         printf("DosAllocSharedMem rc=[%d]\n",rc);

      /********************************************************************
       * Get a handle to the named shared memory allocated by the server
       ********************************************************************/
       if ((rc = DosGetNamedSharedMem(&PosAgentRam[i],
                                       NameBuf,
                                       PAG_READ | PAG_WRITE )))
         printf("DosGetNamedSharedMem rc=[%d]\n",rc);

       /*
        * Init the structure to wait state
        */
       PosAgentRam[i]->tx_code = 7;


       (void)sprintf(WorkChar,"%d \0",i);
       spawnl(P_NOWAIT, "sqlagent.exe", argv[0], WorkChar, NULL);

       /*
        * Initialize the thread lock flags to dispatch the processes
        */

     }

       printf("Shared Memory Allocation Complete.\n");

    /*****************************************************************/
   #endif
  #endif


  /********************************************************
   * If this is the main server then we need to import
   * binding handles for all the stubs
   ********************************************************/

  switch (server_role)
  {
    #ifdef POS_SECONDARY
     case 3:                        /* Price Server */
     {
       #ifdef NODBM
        OpenPriceFiles();
       #endif
       break;
     }
     case 4:                        /* Customer Server */
     {
       #ifdef NODBM
        OpenCMRFiles();
       #endif
       break;
     }
    #endif
    case 1:                        /* Main POS Server */
    {
      #ifndef POS_SECONDARY
       CreateHistorySem();
      #endif

      #ifdef POS_STANDALONE
       #ifdef NODBM
        OpenPriceFiles();
        OpenCMRFiles();
       #endif
      #endif

      #ifdef POS_PRIMARY
       for (i=3; i<5; i++)
       {
         GO_GET_BINDING( POS_NAME[i], POS_SPEC[i], &POS_BINDINGS[i] );
         rc = 1;
         while (rc == 1)
         {
              rc=get_uresp("\nIs the Binding OK? (Y|N)",buffer,1);
              if (rc == 0) continue;
              if ((strncmp(buffer,"N",1) == 0) || (strncmp(buffer,"n",1) == 0))
              {
                rpc_binding_free(&POS_BINDINGS[i],&st);
                GO_GET_BINDING(POS_NAME[i], POS_SPEC[i], &POS_BINDINGS[i]);
                continue;
              }
              break;
         } /* forever loop */
       }
      #endif
      break;
    }
    otherwise:
    {
      printf("Unknown/Unsupported Server Role <%d> !\n", server_role);
      break;
    }
  }

  /********************************************************/


    /********************************************************/

    GO_EXPORT_BINDING( POS_NAME[server_role],
                       POS_SPEC[server_role]);
    /********************************************************/
    #ifndef POS_PRIMARY
      #ifdef DB22
        KillDB22Agents();
      #endif
    #endif

    exit(0);
}
/************************************************************
 * Read response from keyboard
 ************************************************************/
#ifdef POS_PRIMARY
int get_uresp(char *prompt,char *buffer,int num)
{
   char       ch='\0';
   int        i, pos;

   printf("%s\n ",prompt);
   #ifdef IBMOS2
     ch = getche();
     strcpy(buffer,&ch);
   #else
     pos=0;
     buffer[0]='\0';
     while(read(0,&ch,1)>0)
     {
             if(pos == num)
                     return(1);
             if((ch == '\n') || (ch == '\r'))
             {
                     if(pos == 0)
                     {
                             buffer[pos++] = "Y";
                             buffer[pos++] = '\0';
                             return(1);
                     }
                     else
                     {
                             buffer[pos++] = '\0';
                             return(1);
                     }
             }
             else
                     buffer[pos++]=ch;
     }
  #endif
     return(0);
}
#endif
/***********************************************
 * Export Binding Routine
 ***********************************************/
void GO_EXPORT_BINDING(  unsigned char * IFName,
                         rpc_if_handle_t IFSpec)
{
    struct timeb api1, api2;
    double api_time=0.0;
    char   *env_pntr;
    int    i;

    error_status_t st;
    rpc_binding_vector_p_t bvec;
/* unsigned char * pszUuid = "334A2E24-0000-0000-0D00-379834000000"; */

    char  pszProtocolSequence[32]     = "ncadg_ip_udp";

/*  char  pszProtocolSequence[32]     = "ncacn_ip_tcp"; */
/*   unsigned char * pszEndpoint    = "1000";*/   /*"\\pipe\\mypipe"; */
/*    unsigned char * pszOptions          = NULL; */
    unsigned char * pszStringBinding    = NULL;
    idl_char      * auth_principal      = "cell_admin";
    unsigned32      security_level      = 1;

    /**********************************************/

    if (!(env_pntr = getenv("POSPROTOCOL")))
      printf("Environment variable 'POSPROTOCOL' not found.\n");
    else
      strcpy(pszProtocolSequence, env_pntr);

    /* printf("PROTSEQ  = <%s>\n",pszProtocolSequence); */

    /********************************************************/
    ftime(&api1);

    rpc_server_register_if(IFSpec, 0, 0, &st);

    ftime(&api2);
    api_time = ((api2.time * 1000L + api2.millitm)   -
                (api1.time * 1000L + api1.millitm)) * 0.001;
    if (api1.timezone != api2.timezone)
    {
      api_time -= (float)(api2.timezone-api1.timezone)*60.0;
    }

    perhaps_an_error(st, api_time, "rpc_server_register_if\0");

    /***********************************************************************/

    ftime(&api1);

    rpc_server_use_protseq((unsigned char *) pszProtocolSequence, 1, &st);

    ftime(&api2);
    api_time = ((api2.time * 1000L + api2.millitm)   -
                (api1.time * 1000L + api1.millitm)) * 0.001;

    perhaps_an_error(st, api_time, "rpc_server_use_protseq_[ep]\0");

    /***********************************************************************/

    ftime(&api1);

    rpc_server_inq_bindings(&bvec, &st);

    ftime(&api2);
    api_time = ((api2.time * 1000L + api2.millitm)   -
                (api1.time * 1000L + api1.millitm)) * 0.001;

    perhaps_an_error(st, api_time, "rpc_server_inq_bindings\0");

    ftime(&api1);

    rpc_ep_register(IFSpec,
                    bvec,
                    NULL,
                    " ",
                    &st);

    ftime(&api2);
    api_time = ((api2.time * 1000L + api2.millitm)   -
                (api1.time * 1000L + api1.millitm)) * 0.001;

    perhaps_an_error(st, api_time, "rpc_ep_register\0");

    /*****************************************************************/
    if ((env_pntr = getenv("SECLVL")))
      security_level = (unsigned32) atol(env_pntr);
    else
      security_level = 1;            /* unauthenticated */

    printf("* Env Var SECLVL=%ld\n", security_level);

    /*
    printf("* Env Var SECLVL=%ld\n"
             "     0 = rpc_c_authn_none         \n"
             "     1 = rpc_c_authn_dce_secret   \n"
             "     2 = rpc_c_authn_dce_public   \n"
             "     3 = rpc_c_authn_dce_dummy    \n"
             "     4 = rpc_c_authn_dssa_public  \n"
             "    -1 = rpc_c_authn_default      \n" , security_level);
    */
    if (security_level != 0)
    {
    ftime(&api1);

    rpc_server_register_auth_info((unsigned_char_p_t) THE_USER,
                          security_level,
                          NULL,
                          NULL,
                          &st);

    ftime(&api2);
    api_time = ((api2.time * 1000L + api2.millitm)   -
                (api1.time * 1000L + api1.millitm)) * 0.001;

    perhaps_an_error(st, api_time, "rpc_server_register_auth_info\0");

    /*****************************************************************/
      ftime(&api1);

      rpc_mgmt_inq_server_princ_name(NULL,
                                     (unsigned32)rpc_c_authn_default,
                                     &auth_principal,
                                     &st);

      ftime(&api2);
      api_time = ((api2.time * 1000L + api2.millitm)   -
                  (api1.time * 1000L + api1.millitm)) * 0.001;


      perhaps_an_error(st, api_time, "rpc_mgmt_inq_server_princ_name\0");
      /* printf("%s\n", auth_principal); */
    }
    /*****************************************************************/
    ftime(&api1);

    rpc_ns_binding_export(rpc_c_ns_syntax_dce, /*default,*/
                          IFName,              /* "/.:/PointOfSale", */
                          IFSpec,              /* PointOfSale_v0_0_s_ifspec, */
                          bvec,
                          NULL,
                          &st);

    ftime(&api2);
    api_time = ((api2.time * 1000L + api2.millitm)   -
                (api1.time * 1000L + api1.millitm)) * 0.001;


    perhaps_an_error(st, api_time, "rpc_ns_binding_export\0");

    /*****************************************************************/
    ftime(&api1);

    rpc_binding_to_string_binding(bvec->binding_h[0],
                                  &pszStringBinding,
                                  &st);

    ftime(&api2);
    api_time = ((api2.time * 1000L + api2.millitm)   -
                (api1.time * 1000L + api1.millitm)) * 0.001;

    perhaps_an_error(st, api_time, "rpc_binding_to_string_binding\0");

    /*************************************************************/

    printf("%s Listening[%s]...\n", POS_NAME[server_role], pszStringBinding);

    ftime(&api1);

    rpc_string_free(&pszStringBinding, &st);

    ftime(&api2);
    api_time = ((api2.time * 1000L + api2.millitm)   -
                (api1.time * 1000L + api1.millitm)) * 0.001;

    perhaps_an_error(st, api_time, "rpc_string_free\0");

    /*************************************************************/

    ftime(&api1);

    rpc_binding_vector_free(&bvec, &st);

    ftime(&api2);
    api_time = ((api2.time * 1000L + api2.millitm)   -
                (api1.time * 1000L + api1.millitm)) * 0.001;

    perhaps_an_error(st, api_time, "rpc_binding_vector_free\0");

      rpc_server_listen(MAX_CONCURRENT_CALLS, &st);

    perhaps_an_error(st, 0, "rpc_server_listen\0");


    return;
}
/***********************************************
 * Server Suicide RPC Calls (causes compile problems in tpca1.c)
 ***********************************************/
void hari_kari(void)
{
    int            i;
    error_status_t st;
    struct timeb   api1, api2;
    double         api_time;

    /* Kill the Server */
    printf("Ahhhh.... I've been shot !!!\n");

    switch (server_role)
    {
      #ifdef POS_SECONDARY
       #ifdef NODBM
        case 3:
        {
           ClosePriceFiles();
           break;
        }
        case 4:
        {
           CloseCMRFiles();
           break;
        }
       #endif
      #endif
      case 1:
      {
         #ifdef POS_PRIMARY
          printf("Shoot the PTQ Server.....\n");
          KILL_PTQ ((handle_t) POS_BINDINGS[3] );   /* RPC to kill PTQ */
          printf("Shoot the CMR Server.....\n");
          KILL_CMR ((handle_t) POS_BINDINGS[4] );   /* RPC to kill CMR */
         #else
          #ifdef NODBM
            ClosePriceFiles();
            CloseCMRFiles();
          #endif
         #endif

         #ifndef POS_SECONDARY
          CloseHistoryFile(hist_file_handle);
         #endif

         break;
      }
      otherwise:
      {
         printf("Oops! Can't commit murder or close files!\n");
         break;
      }
    }

    printf("GASP... Gasp... gasp ... so long!\n");


    ftime(&api1);

    rpc_ns_binding_unexport(rpc_c_ns_syntax_dce,
                         POS_NAME[server_role],
                         POS_SPEC[server_role],
                         NULL,
                         &st);

    ftime(&api2);
    api_time = ((api2.time * 1000L + api2.millitm)   -
                (api1.time * 1000L + api1.millitm)) * 0.001;

    perhaps_an_error(st, api_time, "rpc_ns_binding_unexport\0");

    /************************************************************/

    ftime(&api1);

    rpc_mgmt_stop_server_listening(NULL, &st);

    ftime(&api2);
    api_time = ((api2.time * 1000L + api2.millitm)   -
                (api1.time * 1000L + api1.millitm)) * 0.001;

    perhaps_an_error(st, api_time, "rpc_mgmt_stop_server_listening\0");

    /************************************************************/

    ftime(&api1);

    rpc_server_unregister_if(NULL, NULL, &st);

    ftime(&api2);
    api_time = ((api2.time * 1000L + api2.millitm)   -
                (api1.time * 1000L + api1.millitm)) * 0.001;

    perhaps_an_error(st, api_time, "rpc_server_unregister\0");

    #ifndef POS_PRIMARY
      #ifdef DB22
        KillDB22Agents();
      #endif
    #endif

    if (st) exit(2);
}
#ifdef POS_PRIMARY
/*************************************************************
 * RPC Connect - Lookup application via CDS
 *************************************************************/
void GO_GET_BINDING(  unsigned char * IFName,
                       rpc_if_handle_t IFSpec,
                       rpc_binding_handle_t *bind_h )
{
  /* RPC variables */
  /*   unsigned char * pszUuid = "334A2E24-0000-0000-0D00-379834000000"; */
  /*   unsigned char * pszOptions          = NULL; */
            char * pszStringBinding;
   error_status_t  st;
   struct timeb    api1, api2;
   double          api_time;
   rpc_ns_handle_t import_h;

   char          * env_ptr;
   unsigned char * pszAuthPrincipal    = "cell_admin";
   unsigned char * pszAuthPrincipalL   = "";
   unsigned32      longAuthLevel       = 3;
   unsigned32      longAuthLevelL      = 0;

   /*
      rpc_c_protect_level_default (0)
      rpc_c_protect_level_none (1)
      rpc_c_protect_level_connect (2)
      rpc_c_protect_level_call (3)
      rpc_c_protect_level_pkt (4)
      rpc_c_protect_level_pkt_integ (5)
      rpc_c_protect_level_pkt_privacy (6)
    */
   unsigned32      longAuthnProtocol    = 1;
   unsigned32      longAuthnProtocolL   = 0;
   /*
      rpc_c_authn_none (0)
      rpc_c_authn_dce_secret (1)
      rpc_c_authn_dce_public (2)
      rpc_c_authn_dce_dummy (3)
      rpc_c_authn_dssa_public (4)
      rpc_c_authn_default (-1)
    */
   unsigned32      longAuthzProtocol    = 2;
   unsigned32      longAuthzProtocolL   = 0;
   /*
      rpc_c_authz_none (0)
      rpc_c_authz_name (1)
      rpc_c_authz_dce (2)
    */

   ftime(&api1);

   rpc_ns_binding_import_begin (rpc_c_ns_syntax_default,
                                IFName, /* "/.:/PointOfSale", */
                                IFSpec, /* PointOfSale_v0_0_c_ifspec, */
                                NULL,
                                &import_h,
                                &st);

   ftime(&api2);
   api_time = ((api2.time * 1000L + api2.millitm)   -
               (api1.time * 1000L + api1.millitm)) * 0.001;

   perhaps_an_error(st, api_time, "rpc_ns_binding_import_begin\0");

   /**********************************************************************/
   /*
    * Force the Client to refresh his local cache
    */

   ftime(&api1);


   rpc_ns_mgmt_handle_set_exp_age(import_h,
                                  0L,
                                  &st);

   ftime(&api2);
   api_time = ((api2.time * 1000L + api2.millitm)   -
               (api1.time * 1000L + api1.millitm)) * 0.001;

   perhaps_an_error(st, api_time, "rpc_ns_mgmt_handle_set_exp_age\0");
   /**********************************************************************/

   ftime(&api1);

   rpc_ns_binding_import_next (import_h,
                               bind_h,
                               &st);


   ftime(&api2);
   api_time = ((api2.time * 1000L + api2.millitm)   -
               (api1.time * 1000L + api1.millitm)) * 0.001;

   perhaps_an_error(st, api_time, "rpc_ns_binding_import_next\0");

   /**********************************************************************/
   ftime(&api1);

   rpc_ns_binding_import_done (&import_h, &st);

   ftime(&api2);
   api_time = ((api2.time * 1000L + api2.millitm)   -
               (api1.time * 1000L + api1.millitm)) * 0.001;

   printf ("%s\n",IFSpec);
   perhaps_an_error(st, api_time, "rpc_ns_binding_import_done\0");

   /**********************************************************************/
   ftime(&api1);

   rpc_ep_resolve_binding (*bind_h, IFSpec, &st);


   ftime(&api2);
   api_time = ((api2.time * 1000L + api2.millitm)   -
               (api1.time * 1000L + api1.millitm)) * 0.001;

   perhaps_an_error(st, api_time, "rpc_ep_resolve_binding\0");

   /**********************************************************************/
   ftime(&api1);

   rpc_binding_to_string_binding (*bind_h, &pszStringBinding, &st);

   ftime(&api2);
   api_time = ((api2.time * 1000L + api2.millitm)   -
               (api1.time * 1000L + api1.millitm)) * 0.001;

   perhaps_an_error(st, api_time, "rpc_binding_to_string_binding\0");

   printf("Binding=<%s>\n", pszStringBinding);

   rpc_string_free(&pszStringBinding, &st);

   /**********************************************************************/

   ftime(&api1);

   rpc_mgmt_is_server_listening (*bind_h, &st);

   ftime(&api2);
   api_time = ((api2.time * 1000L + api2.millitm)   -
               (api1.time * 1000L + api1.millitm)) * 0.001;

   perhaps_an_error(st, api_time, "rpc_mgmt_is_server_listening\0");

   /**********************************************
    * Authentication Stuff
    **********************************************/
   if ((env_ptr = getenv("AUTHP")))
   {
     strcpy(pszAuthPrincipal, env_ptr);
   }
   else
     strcpy(pszAuthPrincipal, "cell_admin");

   /*****************/
   if ((env_ptr = getenv("AUTHL")))
     longAuthLevel = (unsigned32) atol(env_ptr);
   else
     longAuthLevel =  3;           /* call */

   /*****************/
   if ((env_ptr = getenv("AUTHN")))
     longAuthnProtocol = (unsigned32) atol(env_ptr);
   else
     longAuthnProtocol =  1;           /* secret */

   /*****************/
   if ((env_ptr = getenv("AUTHZ")))
     longAuthzProtocol = (unsigned32) atol(env_ptr);
   else
     longAuthzProtocol =  2;            /* DCE */

   /*****************/
   if (longAuthLevel != 0)
   {
     ftime(&api1);

     rpc_binding_set_auth_info(*bind_h,
                               pszAuthPrincipal,
                               longAuthLevel,
                               longAuthnProtocol,
                               NULL,
                               longAuthzProtocol,
                               &st );

     ftime(&api2);
     api_time = ((api2.time * 1000L + api2.millitm)   -
                 (api1.time * 1000L + api1.millitm)) * 0.001;

     perhaps_an_error(st, api_time, "rpc_binding_set_auth_info\0");

     /****************************************************/
     ftime(&api1);

     rpc_binding_inq_auth_info(*bind_h,
                               &pszAuthPrincipalL,
                               &longAuthLevelL,
                               &longAuthnProtocolL,
                               NULL,
                               &longAuthzProtocolL,
                               &st );

     ftime(&api2);
     api_time = ((api2.time * 1000L + api2.millitm)   -
                 (api1.time * 1000L + api1.millitm)) * 0.001;

     perhaps_an_error(st, api_time, "rpc_binding_inq_auth_info\0");

/*
       printf("Confirming Auth Info:  = %s %ld %ld %ld\n",
                                                pszAuthPrincipalL,
                                                longAuthLevelL,
                                                longAuthnProtocolL,
                                                longAuthzProtocolL);
*/
   }
}  /* End of Connect with Import Binding */
#endif
/**********************************************************/
#ifndef POS_SECONDARY
/**************************************************************************
 * Stub for data traansfer test case
 **************************************************************************/
void char_op
(
   handle_t d1,
   unsigned short in_len,
   unsigned char * sendbuf,
   unsigned short out_len,
   unsigned char * recvbuf
)
{
   int i;
   /*
    * Put a message into the buffer.
    */

   for (i=0; i<out_len-1; i++, recvbuf++)
   {
     *recvbuf = 'Y';
   }
   *recvbuf = '\0';

   recvbuf -= (out_len-1);

}
#endif
/**********************************************************/


/**********************************************************
 * This routine passes the performance data file from
 * the client hardfile to the server hardfile for convience
 * of number crunching.
 **********************************************************/
#ifndef POS_SECONDARY
/*******************************************
 * Stub for file transfer of client data files
 *******************************************/
void file_tran
(
   handle_t hBinding,
   unsigned short lenname,
   unsigned short maxname,
   ndr_byte filename[],
   unsigned short in_len,
   unsigned short sendmax,
   ndr_byte sendbuf[]
)
{
   int           wk_file=0;
   int           num_wrt;
   char          * pos_path;
   unsigned char file_name[80];


   /*******************************************
    * Need to know where to write the data files at the
    * server.
    *******************************************/
   if (!(pos_path = getenv("POSDIR")))
   {

     printf("GetEnv 'POSDIR' Environment variable not set <%ld>.\n");

     /* Default to current directory */
     strcpy(file_name, filename);

   }
   else
   {
     strcpy(file_name,pos_path);
     strcat(file_name,BACK_SLASH);
     strcat(file_name,filename);
   }


   if ((wk_file =
      open(file_name, O_CREAT | O_TRUNC | O_RDWR, S_IWRITE )
       ) == -1)
   {
       printf("Failed to open a working file <%s>.\n", file_name);
   }
   else
   {
       /*
        * Write the data that was sent to the local file.
        */
       num_wrt = write(wk_file, sendbuf, in_len);

       printf("<%6d> Bytes written to <%s>\n",num_wrt, file_name);

       close(wk_file);
   }
}

#endif

/**********************************************************
 * This call will kill the server.
 * Invoked by a transaction type = 9 from a requester.
 **********************************************************/
void suicide
(
   handle_t d1
)
{
   /*
    * I put this routine in the same C file as the other
    * RPC calls for convienience of compilation.
    */
   hari_kari();
}

/***********************************************
 * Error Routine
 ***********************************************/
 void perhaps_an_error( error_status_t st,
                        double api_resp_time,
                        unsigned char err_msg[160])
 {
     unsigned char messg[160];
     int           st2;
     FILE          *fp;

     if (st != error_status_ok)
     {
         dce_error_inq_text(st, (unsigned char *)messg, &st2);
         printf("Error: %s Status = %ld\n=====> %s (rc=%d)\n",
                 err_msg, st, messg, st2);
         #ifndef POS_SECONDARY
          fp = fopen(input_file,"a");
          fprintf(fp,"Error: %s\nStatus: %ld\n<%s>\n",
                      err_msg, st, messg);
          fprintf(fp,"API dce_error_inq_text    RC=%ld\n", st2);
          fclose(fp);
         #endif
         #ifndef POS_PRIMARY
          #ifdef DB22
           KillDB22Agents();
          #endif
         #endif
         exit(1);
     }
     else
     {
         /***********************************************************
          * By default append API response time to OUT0.DAT
          ***********************************************************/
         printf(" %40s  Time=%8.2f RC=%ld\n", err_msg, api_resp_time, st);

         #ifndef POS_SECONDARY
          fp = fopen(input_file,"a");
          fprintf(fp,"%40s        1 %8.3f\n",err_msg, api_resp_time);
          fclose(fp);
         #endif
     }

     return;
 }

#ifdef POS_PRIMARY
/***************************************************
 * Attempt Recovery from disaster
 ***************************************************/
void CrashRecovery (rpc_binding_handle_t *bind_h, int sid )
{
   error_status_t  DCEst;
   FILE           *fp;


   printf("YooHoo, Surrogate Server......\n");

   fp=fopen(input_file,"a");
   fprintf(fp,"Beginning crash recovery\n");
   fclose(fp);

   rpc_mgmt_set_com_timeout (*bind_h, 0L, &DCEst);

   fp=fopen(input_file,"a");
   fprintf(fp,"COMM TimeOut set to '0'\n");
   fclose(fp);

   rpc_mgmt_is_server_listening (*bind_h, &DCEst);

   fp=fopen(input_file,"a");
   fprintf(fp,"The server quit listening <%ld>\n",DCEst);
   fclose(fp);

   while (DCEst)
   {
     printf("Anybody else out there....?                    \n", DCEst);

     rpc_binding_free(&POS_BINDINGS[sid],&DCEst);

     fp=fopen(input_file,"a");
     fprintf(fp,"Get a new binding\n");
     fclose(fp);

     GO_GET_BINDING( POS_NAME[sid], POS_SPEC[sid], &POS_BINDINGS[sid] );

     printf("Are you listening.....?                        \n");

     fp=fopen(input_file,"a");
     fprintf(fp,"See if he is listening\n");
     fclose(fp);

     rpc_mgmt_set_com_timeout (*bind_h, 0L, &DCEst);
     rpc_mgmt_is_server_listening (*bind_h, &DCEst);
   }

   rpc_mgmt_set_com_timeout (*bind_h, 5L, &DCEst);

   printf("OK, retry was sucessful                     \n");

   fp=fopen(input_file,"a");
   fprintf(fp,"Back on line\n");
   fclose(fp);
}
#endif
/*****************************************************
 * DB2/2 Dispatcher Routine
 *****************************************************/
#ifdef DB22
int PosDispatcher(void)
{
   int MyAgent = -1;
   int i;

   do
   {
     pthread_lock_global_np();
     {
       for (i=0;i<NUM_AGENTS;i++)
       {
         if (SyncLocks[i] == 0)
         {
           SyncLocks[i] = 1;
           MyAgent = i;
           break;
         }
       }
     }
     /*
      * UnLock the array
      */
     pthread_unlock_global_np();

     if (MyAgent < 0) DosSleep(30L);              /* Give up my timeslice */

   } while (MyAgent < 0);

   #ifdef DEBUGIT
    printf("Assigned to DB AGENT Process <%d>\n", MyAgent);
   #endif

   return(MyAgent);
}
/**********************************************************/
void PosDispatchFree(int MyAgent)
{
   /*
    * Now unlock the Agent so someone else can use it
    */
   pthread_lock_global_np();
   {
     SyncLocks[MyAgent] = 0;
   }
   pthread_unlock_global_np();

}
#endif
/******************************************/
#ifdef DB22
 #ifndef POS_PRIMARY
  void KillDB22Agents(void)
  {
    int     i;
    APIRET  rc;

    printf("Kill the DB2/2 Agents....\n");

    for(i=0;i<NUM_AGENTS;i++)
    {
      PosAgentRam[i]->tx_code = 999;
      if ((rc=ClearAgentSem(i))==0);
      {
        printf("Waiting for demise of SQL Agent%d",i);
        do
        {
          printf(".");
          #ifdef IBMOS2
           DosSleep(500L);
          #endif
        } while(PosAgentRam[i]->tx_code != 99L);
        printf(".\n");
      }

      printf("Free Shared RAM for Agent %d\n",i);
      DosFreeMem(ShareBuf[i]);
    }

  }
 #endif
#endif
/******************************************/
