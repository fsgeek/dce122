/************** SERVER.C Sample Program Source Code File (.C) ***********
 * PROGRAM NAME: SERVER
 *
 * WHAT THIS PROGRAM DOES:
 *
 * DCE Demo Message Application Server
 *
 *   Common source for the three application server types
 *   - STANDALONE - A single application server
 *   - Distributed Application
 *       - PRIMARY appl server known to the clients (POS_IDL.IDL)
 *       - SECONDARY surrogate appl server to which the PRIMARY
 *         server off-loads some amount of work.
 *
 *   Simulates a message database using an array.
 *
 *   - Query the number of messages waiting for a given HOSTNAME
 *   - Adds a message to the database to a given HOSTNAME
 *   - Retrieves and deletes a message for a given HOSTNAME
 *
 * WHAT YOU NEED TO COMPILE THIS PROGRAM:
 *
 *   - OS/2 2.1 or AIX with appropriate 32 bit C compiler and linker
 *   - DCE 1.0.2 or higher
 *
 * REQUIRED FILES:
 *     SERVER.C              Common server source
 *     CLIENT.C              Client source
 *     HOWDY.IDL             RPC interface between client and server
 *     NESTED.IDL            RPC interface between Primary and Surrogate servers
 *     DATADEF.IDL           Definitions for IDL data structures
 *
 *     MAKEFILE.OS2          Builds OS/2 client and server programs
 *     MAKEFILE.AIX          Builds AIX client and server programs
 *
 *  Copyright (C) 1991 IBM Corporation
 *
 *      DISCLAIMER OF WARRANTIES.  The following [enclosed] code is
 *      sample code created by IBM Corporation. This sample code is not
 *      part of any standard or IBM product and is provided to you solely
 *      for  the purpose of assisting you in the development of your
 *      applications.  The code is provided "AS IS", without
 *      warranty of any kind.  IBM shall not be liable for any damages
 *      arising out of your use of the sample code, even if they have been
 *      advised of the possibility of such damages.                                                    *
 *
 ************************************************************************
 * Developed by:
 * IBM Corporation
 * OS/2 LAN Systems Performance
 * Department 59LS
 * 11400 Burnet Road
 * Austin Texas 78759
 * Bob Russell, ZIP 9151
 * (512) 838-0844 TL 678-0844
 ************************************************************************/


#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>


#ifdef IBMOS2
 #define INCL_DOSPROCESS
 #include <process.h>
 #include <os2.h>
 #include "dcedef.h"
 #include <sys\timeb.h>
 #include <sys\stat.h>
 #include <sys\types.h>
#else
 #include <sys/timeb.h>
 #include <sys/stat.h>
 #include <sys/types.h>
#endif

#ifdef AIX_PROD
 #define DCEAPI
#endif

#include "pos_idl.h"
#include "rpc.h"

#ifdef SECONDARY
 #define MAX_CONCURRENT_CALLS 5
#else
 #define MAX_CONCURRENT_CALLS 50
 #include "pos_idl.h"
#endif

#ifndef STANDALONE
 #include "cmr_idl.h"
#endif

#define THE_USER "cell_admin"

unsigned int          server_role = 0;       /* 0 = PRIMARY or STANDALONE */
                                             /* 1 = SECONDARY */
                                             /* This is used as the index */
                                             /* into the following IF_*   */
                                             /* arrays.                   */
#ifndef SECONDARY
 unsigned char        *IF_NAME[]   ={ "/.:/Howdy",
                                      "/.:/MSG_SLAVE"
                                    };
#else
 unsigned char        *IF_NAME[]   ={ "/.:/MSG_SLAVE",
                                      "/.:/Howdy"
                                    };
#endif

rpc_if_handle_t       IF_SPEC[2];
#ifdef PRIMARY
 rpc_binding_handle_t IF_BINDINGS[2];
#endif

char                  error_file[16];
FILE                 *fp;

/************************************************************************
 * Typically, the application will use a Relational Database to
 * store data. Since this is just a demo, and I want to keep it
 * simple, the following ARRAY will serve as my database
 ************************************************************************/

typedef struct _MY_DATA
{
    char       sender_host[12];
    char       addressee_host[12];
    char       message_text[80];
} MY_DATA;

#define MAX_DB_ROWS 100

MY_DATA        Pretend_Database[MAX_DB_ROWS];
short          num_rows = 0;

/************************ Prototypes ************************************/
int   main(int argc, char *argv[]);

void  perhaps_an_error( error_status_t st1);         /* DCE Error Checker */

extern void DCEAPI dce_error_inq_text (
    unsigned long           status_to_convert,
    unsigned char           *error_text,
    int                     *status   );

void GO_EXPORT_BINDING(  unsigned char * IFName,
                          rpc_if_handle_t IFSpec);

#ifdef PRIMARY
 void GO_GET_BINDING(  unsigned char * IFName,
                       rpc_if_handle_t IFSpec,
                       rpc_binding_handle_t *bind_h );
#endif

void hari_kari(void);


/*********************************************************************
 *** MAIN
 *********************************************************************/
int main(int argc, char *argv[])
{
    unsigned char        *env_pntr;


    #ifdef STANDALONE
      IF_SPEC[0] =Howdy_v0_0_s_ifspec;
      strcpy(error_file,"sal_srv.err");
      printf("This is a Standalone Server\n");
      server_role = 0;
    #endif
    #ifdef PRIMARY
      IF_SPEC[0] = Howdy_v0_0_s_ifspec;
      IF_SPEC[1] = MSG_SLAVE_v0_0_c_ifspec;
      strcpy(error_file,"pri_srv.err");
      printf("This is a Primary Server\n");
      server_role = 0;
    #endif
    #ifdef SECONDARY
      IF_SPEC[0] = MSG_SLAVE_v0_0_s_ifspec;
      strcpy(error_file,"sec_srv.err");
      printf("This is a Surrogate Server\n");
      server_role = 1;
    #endif

    /*
     * Open and Truncate the error file
     */
    fp=fopen(error_file,"w");
    if (fp==NULL)
    {
      printf("Couldn't open <%s> error file.\n", error_file);
      exit(0);
    }
    else
      fclose(fp);

    /********************************************************
     * If this is the PRIMARY server then we need to import
     * binding handles for the surrogate Message stub
     ********************************************************/
    #ifdef PRIMARY
      GO_GET_BINDING( IF_NAME[1],
                      IF_SPEC[1],
                      &IF_BINDINGS[1] );
    #endif

    /********************************************************
     * In real-life, I would put the START USING DATABASE
     * call here. Since the OS/2 Database Manager is process
     * oriented, and this application is thread oriented within one
     * process, only need to start the database one time.
     *
     *                 if (!(dbname = getenv("DBNAME")))
     *                 {
     *                    sprintf(database,"MYDATABASE\0");
     *                 }
     *                 else
     *                    sprintf(database,"%s",dbname);
     *
     *                 do
     *                 {
     *                    sqlestrd(database,SQL_USE_SHR,&sqlca);
     *
     *                    if(SQLCODE == SQLE_RC_NOLOGON)
     *                       printf("Logon retry\n");
     *
     *                    if(SQLCODE != 0 && SQLCODE != SQLE_RC_NOLOGON)
     *                       exit(0);
     *                 }  while (SQLCODE == SQLE_RC_NOLOGON);
     *********************************************************/

    /********************************************************
     * Then, we need to export the "Howdy" interface to CDS so
     * the clients can find us.
     ********************************************************/

    GO_EXPORT_BINDING( IF_NAME[0],
                       IF_SPEC[0]);

    /********************************************************
     * The RPC LISTEN is called within the GO_EXPORT_BINDING
     * routine, so when we get back here we are ready to exit.
     ********************************************************/

    exit(0);
}
/* END OF MAIN */
/***********************************************
 * Export Binding Routine
 ***********************************************/
void GO_EXPORT_BINDING(  unsigned char * IFName,
                         rpc_if_handle_t IFSpec)
{
    char                    *env_pntr;
    error_status_t           st;
    rpc_binding_vector_p_t   bvec;
    char                     pszProtocolSequence[32] = "ncadg_ip_udp";
    unsigned char           *pszStringBinding        = NULL;
    idl_char                *auth_principal          = "cell_admin";
    unsigned32               security_level          = 1;

    /**** end of vars ******************************************/

    /*
     * I've defaulted the RPC protocol sequence to "ncadg_ip_udp", if
     * you want to change to 'tcp', SET MYPROTOCOL=ncacn_ip_tcp in the
     * environment.
     */

    if (!(env_pntr = getenv("MYPROTOCOL")))
      printf("Environment variable 'MYPROTOCOL' not found.");
    else
      strcpy(pszProtocolSequence, env_pntr);

    printf("Using PROTSEQ=<%s>\n",pszProtocolSequence);

    /********************************************************/

    printf("rpc_server_register_if\n");
    rpc_server_register_if(IFSpec, 0, 0, &st);
    perhaps_an_error(st);

    /***********************************************************************/

    printf("rpc_server_use_protseq\n");
    rpc_server_use_protseq((unsigned char *) pszProtocolSequence, 1, &st);
    perhaps_an_error(st);

    /***********************************************************************/

    printf("rpc_server_inq_bindings\n");
    rpc_server_inq_bindings(&bvec, &st);
    perhaps_an_error(st);

    /***********************************************************************/

    printf("rpc_ep_register\n");
    rpc_ep_register(IFSpec, bvec, NULL, " ", &st);
    perhaps_an_error(st);

    /**********************************************************************
     * Allow the server security level to be set in the environment
     *        0 = rpc_c_authn_none
     *        1 = rpc_c_authn_dce_secret    (default)
     *        2 = rpc_c_authn_dce_public
     *        3 = rpc_c_authn_dce_dummy
     *        4 = rpc_c_authn_dssa_public
     *       -1 = rpc_c_authn_default
     **********************************************************************/
    if ((env_pntr = getenv("SECLVL")))
      security_level = (unsigned32) atol(env_pntr);
    else
      security_level = 1;                                /* authenticated */

    printf("Using SECLVL=<%ld>\n", security_level);

    if (security_level != 0)
    {

      printf("rpc_server_register_auth_info\n");
      rpc_server_register_auth_info((unsigned_char_p_t) THE_USER,
                                     security_level,
                                     NULL,
                                     NULL,
                                     &st);
      perhaps_an_error(st);

      /*****************************************************************/

      printf("rpc_mgmt_inq_server_princ_name\n");
      rpc_mgmt_inq_server_princ_name(NULL,
                                     (unsigned32)rpc_c_authn_default,
                                     &auth_principal,
                                     &st);
      perhaps_an_error(st);
    }
    /*****************************************************************/

    printf("rpc_ns_binding_export\n");
    rpc_ns_binding_export(rpc_c_ns_syntax_dce,                 /*dce,*/
                          IFName,                    /* "/.:/Howdy", */
                          IFSpec,            /* Howdy_v0_0_s_ifspec, */
                          bvec,
                          NULL,
                          &st);

    perhaps_an_error(st);

    /*****************************************************************/

    printf("rpc_binding_to_string_binding\n");
    rpc_binding_to_string_binding(bvec->binding_h[0],
                                  &pszStringBinding,
                                  &st);

    perhaps_an_error(st);

    printf("%s BINDING [%s]...\n", IF_NAME[0], pszStringBinding);

    /*************************************************************/

    printf("rpc_string_free\n");
    rpc_string_free(&pszStringBinding, &st);

    perhaps_an_error(st);

    /*************************************************************/

    printf("rpc_binding_vector_free\n");
    rpc_binding_vector_free(&bvec, &st);

    perhaps_an_error(st);

    /*************************************************************/

    printf("rpc_server_listen\n");
    rpc_server_listen(MAX_CONCURRENT_CALLS, &st);

    perhaps_an_error(st);

    return;
}

#ifdef PRIMARY
 /*************************************************************
  * RPC Connect - Lookup application via CDS
  *************************************************************/
 void GO_GET_BINDING(  unsigned char * IFName,
                        rpc_if_handle_t IFSpec,
                        rpc_binding_handle_t *bind_h )
 {
   /* RPC variables */
    char           *pszStringBinding;
    error_status_t  st;
    rpc_ns_handle_t import_h;
    unsigned char  *pszAuthPrincipal    = "cell_admin";
    unsigned char  *pszAuthPrincipalL   = "";
    unsigned32      longAuthLevel       = 3;
    unsigned32      longAuthnProtocol   = 1;
    unsigned32      longAuthzProtocol   = 2;

    char           *env_ptr;
    /**** end of vars ******************************************/

    /**********************************************************************
     * Open an import context
     **********************************************************************/

    printf("rpc_ns_binding_import_begin\n");
    rpc_ns_binding_import_begin (rpc_c_ns_syntax_default,
                                 IFName,                  /* "/.:/Howdy", */
                                 IFSpec,          /* Howdy_v0_0_c_ifspec, */
                                 NULL,
                                 &import_h,
                                 &st);

    perhaps_an_error(st);

    /**********************************************************************/

    /* printf("Force a refresh his local CDS cache!\n"); */


    printf("rpc_ns_mgmt_handle_set_exp_age\n");
    rpc_ns_mgmt_handle_set_exp_age(import_h,
                                   0L,              /* max age in seconds */
                                   &st);

    perhaps_an_error(st);
    /**********************************************************************
     * The IMPORT NEXT call randomly returns 1 handle from the vector
     * of handles in the cache. Each NEXT call can, while the import
     * context is open, can import a vector of up to 5 handles; so,
     * if more than 5 handles are expected for a given interface,
     * subsequent NEXT calls should be made until a 'NO MORE BINDINGS'
     * (st=382312629) is returned.
     **********************************************************************/

    printf("rpc_ns_binding_import_next\n");
    rpc_ns_binding_import_next (import_h,
                                bind_h,
                                &st);

    perhaps_an_error(st);


    /**********************************************************************
     * Close the import context
     **********************************************************************/

    printf("rpc_ns_binding_import_done\n");
    rpc_ns_binding_import_done (&import_h, &st);

    perhaps_an_error(st);

    /**********************************************************************/

    printf("rpc_ep_resolve_binding\n");
    rpc_ep_resolve_binding (*bind_h, IFSpec, &st);

    perhaps_an_error(st);

    /**********************************************************************/

    printf("rpc_binding_to_string_binding\n");
    rpc_binding_to_string_binding (*bind_h, &pszStringBinding, &st);

    perhaps_an_error(st);

    printf("Binding to < %s >\n", pszStringBinding);

    printf("rpc_string_free\n");
    rpc_string_free(&pszStringBinding, &st);

    perhaps_an_error(st);
    /**********************************************************************
     * Make sure the server is listening. If the server was ended by
     * a CNTRL-C, the handle will remain in CDS until it is deleted. So,
     * a bad (st=382312470) return from this call might prompt you to go back
     * up and IMPORT a new handle. "cdscp delete object /.:/Howdy" will
     * clean up the CDS namespace. When the server is killed using
     * the "rpc_KILL" routine (below), he removes himself from CDS.
     **********************************************************************/

    printf("rpc_mgmt_is_server_listening\n");
    rpc_mgmt_is_server_listening (*bind_h, &st);


    perhaps_an_error(st);
    /*********************************************************************
     * Next we want to set the DCE Authentication level of the binding.
     * I've defaulted him to CALL level, to use another level set
     * the AUTHL in the environment.
     *
     * 0=rpc_c_protect_level_default (0)
     * 1=rpc_c_protect_level_none (1)
     * 2=rpc_c_protect_level_connect (2)
     * 3=rpc_c_protect_level_call (3)            (default)
     * 4=rpc_c_protect_level_pkt (4)
     * 5=rpc_c_protect_level_pkt_integ (5)
     * 6=rpc_c_protect_level_pkt_privacy (6)
     *********************************************************************/

    if ((env_ptr = getenv("AUTHL")))
      longAuthLevel = (unsigned32) atol(env_ptr);
    else
      longAuthLevel =  3;           /* rpc_c_protect_level_call */

    /*****************/

    printf("rpc_binding_set_auth_info\n");
    rpc_binding_set_auth_info(*bind_h,
                               pszAuthPrincipal,
                               longAuthLevel,
                               longAuthnProtocol,
                               NULL,
                               longAuthzProtocol,
                               &st );

    perhaps_an_error(st);

    /****************************************************/


 }  /* End of Connect with Import Binding */
#endif

#ifdef SECONDARY
 /**********************************************************
  * This RPC call will kill the SURROGATE server.
  * Invoked from the PRIMARY server as he is dying.
  **********************************************************/
 void KILL_MSG
 (
    handle_t d1
 )
 {
    hari_kari();
 }

#else

 /**********************************************************
  * This rpc call will kill the PRIMARY or STANDALONE server.
  * Invoked by a transaction type = 8 from a client.
  **********************************************************/
 void rpc_KILL
 (
    handle_t d1
 )
 {
    hari_kari();
 }

#endif

/***********************************************
 * Server Suicide local routine - called by the rpc stub
 ***********************************************/
void hari_kari(void)
{
    error_status_t st;

    /**** end of vars ******************************************/

    /* Kill the Server */
    printf("Ahhhh.... I've been shot !!!\n");

    #ifdef PRIMARY

      /* first need to kill any surrogates */
      printf("Shooting the SURROGATE Message Server.....\n");

      KILL_MSG ((handle_t) IF_BINDINGS[1] );   /* RPC to kill MSG */

    #endif


    printf("rpc_ns_binding_unexport\n");
    rpc_ns_binding_unexport(rpc_c_ns_syntax_dce,                 /*default,*/
                         IF_NAME[server_role],              /* "/.:/Howdy",*/
                         IF_SPEC[server_role]     , /* Howdy_v0_0_s_ifspec,*/
                         NULL,
                         &st);

    perhaps_an_error(st);

    printf("GASP... Gasp... gasp .....");
    /************************************************************/

    printf("rpc_mgmt_stop_server_listening\n");
    rpc_mgmt_stop_server_listening(NULL, &st);

    perhaps_an_error(st);

    printf("dust to dust .......");
    /************************************************************/

    printf("rpc_server_unregister_if\n");
    rpc_server_unregister_if(NULL, NULL, &st);

    perhaps_an_error(st);

    printf("ashes to ashes....\nGoodbye.\n");

    if (st) exit(2);

}
/***********************************************
 * Error Routine
 ***********************************************/
 void perhaps_an_error( error_status_t st1)
 {
     int           st2=0;
     unsigned char msgstring[160];

     if (st1 != error_status_ok)
     {
         printf("Error: %ld\n", st1);
         fp=fopen(error_file,"a");
         fprintf(fp,"Error: %ld\n", st1);
         fclose(fp);

         dce_error_inq_text(st1, (unsigned char *)msgstring, &st2);

         if (st2 == error_status_ok)
         {
             printf("<%s>\n", msgstring);
             fp=fopen(error_file,"a");
             fprintf(fp,"<%s>\n", msgstring);
             fclose(fp);
         }
         exit(0);
     }

     return;
 }

/*****************************************************/

#ifdef PRIMARY

 /*****************************************************************
  ** Query Message Application server stub code called by
  ** rpc_QUERY_MSG.
  *****************************************************************
  * This routine is only used when the distributed app is running on
  * a PRIMARY server. This call merely passes the parameter list
  * to a nested RPC call (QUERY_STUB) to the surrogate server.
  *****************************************************************/
 void rpc_QUERY_MSG
 (
    handle_t                       hBinding,
    unsigned short                *qmsg_buf_len,
    MESSG_QUERY_IDL               *qmsg_buf
 )
 {
     printf("Passing <%s> thru to surrogate in rpc_QUERY_MSG\n",
                                                   qmsg_buf->sender_host );

     /*
      * Make the nested RPC call to the surrogate distributed stub
      */
     QUERY_STUB
     ( (handle_t) IF_BINDINGS[1],
       qmsg_buf_len,
       qmsg_buf
     );


 }

 /*****************************************************************
  ** Query Message Application server stub code called by
  ** rpc_MESSAGE.
  *****************************************************************
  * This routine is only used when the distributed app is running on
  * a PRIMARY server. This call merely passes the parameter list
  * to a nested RPC (MESSAGE_STUB) call to the surrogate server.
  *****************************************************************/
 void rpc_MESSAGE
 (
    handle_t                       hBinding,
    unsigned short                *msg_buf_len,
    MESSG_DATA_IDL                *msg_buf
 )
 {
     printf("Passing <%s> thru to surrogate in rpc_MESSAGE\n",
                                                   msg_buf->sender_host );
     /*
      * Make the nested RPC call to the surrogate distributed stub
      */
     MESSAGE_STUB
     ( (handle_t) IF_BINDINGS[1],
       msg_buf_len,
       msg_buf
     );


 }
#endif
 /*****************************************************************
  ** CUSTOMER MASTER RECORD - DISTRIBUTED STUB
  *****************************************************************/
#ifndef PRIMARY
 #ifdef STANDALONE
  void rpc_QUERY_MSG
 #else
  void QUERY_STUB
 #endif
 (
    handle_t                       hBinding,
    unsigned short                *qmsg_buf_len,
    MESSG_QUERY_IDL               *qmsg_buf
 )
 {
    short                          i;
    /**************************************************************
     * EXEC SQL
     *   SELECT COUNT(*) FROM messages WHERE addressee_host
                                           = :qmsg_buf->sender_host
     **************************************************************/
    qmsg_buf->message_count = 0;

    for(i=1;i<=num_rows;i++)
    {
       if ( (strcmp(qmsg_buf->sender_host,
                     Pretend_Database[i].addressee_host)) == 0 )
           qmsg_buf->message_count++;

    }

    printf("Query by HOSTNAME = %s Count = %ld\n", qmsg_buf->sender_host,
                                                   qmsg_buf->message_count);

 }  /* end of rpc_QUERY_MSG */
#endif
/*****************************************************************
 ** DCE Demo MESSAGE - DISTRIBUTED STUB
 *****************************************************************/
#ifndef PRIMARY
 #ifdef STANDALONE
  void rpc_MESSAGE
 #else
  void MESSAGE_STUB
 #endif
 (
    handle_t                       hBinding,
    unsigned short                *msg_buf_len,
    MESSG_DATA_IDL                *msg_buf
 )
 {
      short                        i, j;
      short                        first_hit=0;


    /**************************************
     * Send a Message
     **************************************/
    if (msg_buf->transaction_type == 1)
    {

      /*
       * Use DCE thread lock to freeze the "database" state while
       * a row is inserted.
       * In real-life, I'd use something like
       * EXEC SQL
       *   INSERT INTO messages VALUES(:msg_buf->addressee_host,
       *                               :msg_buf->message_text,
       *                               :msg_buf->sender_host)
       */

       if (num_rows < MAX_DB_ROWS)
       {
         pthread_lock_global_np();
         {
            num_rows++;

            strcpy(Pretend_Database[num_rows].addressee_host,
                                              msg_buf->addressee_host);
            strcpy(Pretend_Database[num_rows].message_text,
                                              msg_buf->message_text  );
            strcpy(Pretend_Database[num_rows].sender_host,
                                              msg_buf->sender_host);

            printf("Message to <%s> from <%s>. Database count is now %d\n",
                                msg_buf->addressee_host,
                                msg_buf->sender_host,
                                num_rows);
          }
          pthread_unlock_global_np();
       }
       else
          printf("The database is too full !\n");
    }


    /****************************************
     * Receive a message
     *
     * This is the place for a database select
     *
     * EXEC SQL
     *   SELECT * FROM messages WHERE :sender_host = :msg_buf->sender_host
     *
     ****************************************/
    else if (msg_buf->transaction_type == 2)
    {

      for(i=1;i<=num_rows;i++)
      {


         if ( (strcmp(msg_buf->addressee_host,
                       Pretend_Database[i].addressee_host)) == 0 )
         {
             if (first_hit == 0)
             {
                first_hit = 1;                   /* only fetch one message */

                strcpy( msg_buf->addressee_host,
                        Pretend_Database[i].addressee_host);
                strcpy( msg_buf->message_text,
                        Pretend_Database[i].message_text);
                strcpy( msg_buf->sender_host,
                        Pretend_Database[i].sender_host);

               /*
                * Now, lets delete the message from the database,
                * again, we lock it with a DCE thread lock.
                *
                * (Yes, this is a bit risky to delete the row
                *  before it is delivered. But, this is just a demo.)
                */
                pthread_lock_global_np();
                {
                   for (j=i; j<num_rows && j<MAX_DB_ROWS; j++)
                   {
                   strcpy( Pretend_Database[j  ].addressee_host,
                           Pretend_Database[j+1].addressee_host);
                   strcpy( Pretend_Database[j  ].message_text,
                           Pretend_Database[j+1].message_text);
                   strcpy( Pretend_Database[j  ].sender_host,
                           Pretend_Database[j+1].sender_host);

                   }
                   num_rows--;

                }
                pthread_unlock_global_np();

                printf("Message fetch by <%s>. Database count is now %d\n",
                                                  msg_buf->addressee_host,
                                                  num_rows);
             }
         }
      }

      if (first_hit == 0)                      /* Default message */
      {
         strcpy( msg_buf->message_text,"Sorry, no messages found!");
         strcpy( msg_buf->sender_host,"SERVER");
      }

      /*
       * Count ALL remaining messages for this host
       */

      msg_buf->message_count = 0;

      for(i=1;i<=num_rows;i++)
      {
         if ( (strcmp(msg_buf->addressee_host,
                     Pretend_Database[i].addressee_host)) == 0 )
             msg_buf->message_count++;

      }

    }

 /* debug lines
   for (i=1;i<=num_rows;i++)
        printf("Row %d %s %s %s\n", i,
                          Pretend_Database[i].addressee_host,
                          Pretend_Database[i].message_text,
                          Pretend_Database[i].sender_host);
 */

 }  /* end of rpc_QUERY_MSG  */
 /*******************************************************************/
#endif
