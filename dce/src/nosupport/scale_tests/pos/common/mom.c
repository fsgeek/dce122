/** MOM.C ************************************************************/
/*** IBM Corporation                                               ***/
/*** OS/2-AIX PSP Systems Performance                              ***/
/*** Department 57LS                                               ***/
/*** 11400 Burnet Road                                             ***/
/*** Austin Texas 78759                                            ***/
/*** Bob Russell, ZIP 9151                                         ***/
/*** (512) 838-0454,0844 TL 678-0454,0844                          ***/
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
/*
 * Main program for client, links in POS.C
 */

#ifdef IBMOS2
  #define INCL_DOSPROCESS
  #define INCL_VIO
#endif


#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifdef AIX_PROD
  #include <cur00.h>
  #include <signal.h>
  #include <sys/timeb.h>
  #include <sys/ioctl.h>
  #include <sys/types.h>
#elif IBMOS2
  #include <os2.h>
  #include "os2def.h"
  #include "bse.h"
  #include <process.h>
  #include <sys\timeb.h>
  #include <sys\types.h>
  #include <conio.h>
  #include <io.h>
#endif

#include <fcntl.h>
#include <time.h>

#include <pthread.h>

#include "rpc.h"
#include "dce_error.h"
/*#include "dceerror.h"*/
#include "mom.h"
#include "pos_idl.h"

#ifdef IBMOS2
  char  FillChar[2]={0x20,0x0F};
  char  WIDGET[4]  ="\n";
#elif AIX_PROD
  char  WIDGET[4]  ="\0";
#endif

struct timespec THINK;
time_t      CURTIME;

/* seeds for the random number generator, unique prime numbers */
short prime_nums[]={3 ,79 ,181 ,293 ,73 ,
                    13 ,101 ,199 ,317 ,29 ,
                    113 ,229 ,349 ,43 ,139 ,
                    251 ,373 ,61 ,163 ,271 ,
                    397 ,277 ,5 ,401 ,83 ,
                    191 ,17 ,307 ,103 ,211 ,
                    31 ,331 ,127 ,233 ,47 ,
                    353 ,149 ,257 ,67 ,379 ,
                    167 ,383 ,173 ,7 ,193 ,
                    409 ,89 ,19 ,223 ,107 ,
                    311 ,37 ,239 ,337 ,131 ,
                    53 ,263 ,359 ,151 ,71 ,
                    281 ,157 ,283 ,419 ,11 ,
                    179 ,197 ,313 ,23 ,97 ,
                    227 ,347 ,41 ,109 ,241 ,
                    367 ,59 ,137 ,269 ,389 };
/*** Prototypes **********************************************/
/*
 * Error handling routine:
 * - Check for non-zero return
 * - If error: Print to display
 *             Print to error file
 *             Close error file
 *             Exit program
 */
void perhaps_an_error_2( error_status_t st1);
void CrashRecovery (rpc_binding_handle_t *bind_h );
short         the_server_crashed;

/*
 * Calculation of elapsed time between 2 ftime() values
 */
double howlong(time_t a,time_t b,
               unsigned short c,unsigned short d,
               int * elapsed_sec);
#ifdef AIX_PROD
  int die();
#endif

#ifdef AIX_PROD
 char back_s[2] = "/";
#elif IBMOS2
 char back_s[2] = "\\";
#endif

/* RPC File Transfer Buffers */
ndr_byte namebuf[NAMEMAX];            /* Name of perf data file     */
ndr_byte buffer[SENDMAX];             /* Contents of perf data file */

FILE *fp;
#include <rpcexc.h>

EXCEPTION input_status;

long    interval;                /* Think Time Parmater     */
unsigned short flag_1;
unsigned short flag_2;
unsigned short flag_3;
unsigned short flag_4;
unsigned short flag_5;
unsigned short flag_6;
unsigned short flag_7;
unsigned short flag_8;
unsigned short force_flag_8; /* Do Logins */
short POS_Signal;
int                            pos_scale;


#define THE_USER "cell_admin"
#define THE_PASSWORD "-dce-"

/*
 * Structure for API performance data
 */
typedef
struct _perf_info
{
  double api_resp_time;
  long   api_count;
  char   api_call[40];
} PERF_INFO;

int              perf_array_ptr=16;
PERF_INFO        perf_array[16]={
0.0,0,"Client system(POSLOGIN)",
0.0,0,"rpc_ns_binding_import_begin",
0.0,0,"rpc_ns_mgmt_handle_set_exp_age",
0.0,0,"rpc_ns_binding_import_next",
0.0,0,"rpc_ns_binding_import_done",
0.0,0,"rpc_ep_resolve_binding",
0.0,0,"rpc_binding_to_string_binding",
0.0,0,"rpc_mgmt_is_server_listening",
0.0,0,"rpc_binding_set_auth_info",
0.0,0,"rpc_binding_inq_auth_info",
0.0,0,"rpc_string_binding_compose",
0.0,0,"rpc_binding_from_string_binding",
0.0,0,"rpc_string_free",
0.0,0,"rpc_ss_register_auth_info",
0.0,0,"rpc_binding_free",
0.0,0,""
};





/* Name and Time of APIs   */
/* unsigned short reqnum; */
int Numbytes;
int              NoPrint;
char             error_file_name[NAMEMAX];
unsigned char * pszAuthPrincipal    = "cell_admin";
unsigned32      longAuthLevel;
unsigned32      longAuthnProtocol    = 1;
unsigned32      longAuthzProtocol   = 2;
unsigned32       ComTimeOut;

struct timeb     t2;
struct timeb     t5;

/**************************************************************
 *** MAIN
 **************************************************************/
void main(int argc, char *argv[]);

void main(int argc, char *argv[])
{
   int              i, j;

   FILE             *fp2;                   /* Error and Data file hdl */
   unsigned char    data_file_name[NAMEMAX];
   unsigned char    out_name[80];

   int f_len;                                    /* Used in file transfer   */
   int in_file;                                  /* Used in file transfer   */
   int numread;                                  /* Used in file transfer   */

   short            histogram[208];              /* Response time histogram */
   long             avg_think=0;                 /* Sum of Think Times      */
   double           avg_serv_time=0.0;           /* Sum of Appl times retd  */
   long             appl_time=0L;                /* Format retd from RPC    */
   double           avg_req_time=0.0;            /* Sum of RPC times        */
   double           max_req_time=0.0;            /* Worst RPC time          */
   double           req_time=0.0, srv_time, api_time=0.0;
   double           bind_time=0.0, curr_req=0.0, curr_srv=0.0;
   int              tenths=0;

   double           curr_time;
   short            start_flag;                  /* Used to time the run    */
   double           start_at,stop_at;            /* Begin/End data window   */
   double           in_between=0.0;              /* Iterations in window    */
   long             tx_cnt=0L, sale_cnt=0L;      /* Iterations in whole run */
   double           elapse;                      /* temp variable           */
   long             think_time;                  /* Adjusted think time     */
   double           duration = 0.0;              /* Used for run duration */
   int              NeverPrint = 0;             /* Override noprint option  */
   long             resp_time=0L;                /* RPC out parm            */
   long             dice=0L;
   struct timeb     t1;
   struct timeb     t3;
   struct timeb     t4, t6, t7;
   struct timeb     d1, d2, e1, e2;
   int              Cindy = 0;                   /* Special case */

   unsigned char    *pospath;

   short num_send;
   short num_sent;
   short num_recv = 1;
   unsigned int     seed;                        /* Local Random Gen seed   */
   int              tranID, TID;                 /* transaction type to run
                                                  * 1=CMR Customer Master Rec
                                                  * 2=SAVe transaction
                                                  * 3=SHQ Sale Hist Query
                                                  * 4=PTQ Price Tbl Query
                                                  * 5=CATalog
                                                  * 9=Kill the Server
                                                  *10=Mixed Workload
                                                  *11=Mixed Workload
                                                  *   connection reestablished
                                                  *   for every iteration
                                                  *12=Mixed Workload-NO PRINT
                                                  */
   int                  tranMode = 0;            /* 0 = dont reestab connect
                                                    1 = do reestab connect */

   char          * env_ptr;

   int rc;
   rpc_binding_handle_t  bind_h;

   SAVE_DATA    save_data;

   EXCEPTION_INIT (input_status);
   /*** End of Local Vars *************************************************/

   /*** init structure ***/
   memset(&save_data,0,sizeof(save_data));

   POS_Signal    = 0;
   interval      = 0;
   flag_1        = 0;       /* Don't Rebind .... */
   flag_2        = 0;       /* POSCntrl active . */
   flag_3        = 0;       /* No Print ........ */
   flag_4        = 0;       /* Refresh Cache ... */
   flag_5        = 0;       /* Collection ON ... */
   flag_6        = 0;
   flag_7        = 0;       /* Kill Clients .... */
   flag_8        = 0;       /* Force DCELogin... */
   force_flag_8  = 0;

/*************************************************************************
 * End of Local VAriables
 *************************************************************************/

   if (argc < 5)
   {
      printf("Number of parms incorrect %d \n\n", argc);
      printf("USAGE:MOM  ReqID  TPH  duration  type [port# [ip_addr]]\n");
      printf("               ReqID  1,2,3,...,n inclusively         \n");
      printf("            duration  in whole minutes                \n");
      printf("                type  1 = CMR Phone Number Lookup     \n");
      printf("                      2 = SAV Sales Slip Processing   \n");
      printf("                      3 = RPC Data Transfer/Exchange  \n");
      printf("                      4 = PTQ Price Inquiry           \n");
      printf("                      5 = CAT Bit Image Transfer      \n");
      printf("                      9 = KILL The Server             \n");
      printf("                     10 = Mixed without rebind        \n");
      printf("                     11 = Mixed with rebind           \n");
      printf("                     12 = Mixed with rebind - Never Print\n");
      printf("                port# Bypass IMPORT and use port#     \n");
      printf("                addr  IP Address of Server            \n");
      exit(0);
   }

   /* clear and initialize screen */
   #ifdef AIX_PROD
     startscr();
     signal( SIGINT, die );
   #elif IBMOS2
     clear_screen();
   #endif

   SetCursorPosition(2,9);

   #ifdef AIX_PROD
     time(&CURTIME);
     strftime(save_data.trans_no.trans_date,9, "%D",localtime(&CURTIME));
     strftime(save_data.trans_no.trans_time,9, "%T",localtime(&CURTIME));
   #elif IBMOS2
     _strdate(save_data.trans_no.trans_date);
     _strtime(save_data.trans_no.trans_time);
   #endif

   /**** Read RunTime Parms *****************************/
   /* reqnum = atol(argv[1]);       */
   save_data.trans_no.reg_no = atol(argv[1]);       /* register number */
   interval        = 3600000L / (atol(argv[2]));    /* transactions per hour */
   duration        = atof(argv[3]) * 60.0;         /* run duration in seconds */
   tranID          = atoi(argv[4]);                 /* transaction type */
   if (tranID == 12) {
        tranID = 11;
        NeverPrint = 1;
   }
   if (tranID == 11) {/* Force POS to connect/disconnect every Sales Activity */
        tranID = 10;
        tranMode = 1;
   }
   TID             = tranID;

   #ifdef DEBUGIT
    fprintf(stderr,"argv[1]=%s\n",argv[1]);
    fprintf(stderr,"argv[2]=%s\n",argv[2]);
    fprintf(stderr,"argv[3]=%s\n",argv[3]);
    fprintf(stderr,"argv[4]=%s\n",argv[4]);
    fprintf(stderr,"interval=<%ld>\n",interval);
    fprintf(stderr,"duration=<%f>\n",duration);
    fprintf(stderr,"tranID=<%d>\n",tranID);
    fprintf(stderr,"TID=<%d>\n",TID);
   #endif

   seed = prime_nums[(short)save_data.trans_no.reg_no-1];  /* randum seed */
   sprintf(save_data.trans_no.dept_no,"%.3d\0",seed);      /* Department Number ! */

   start_at = (duration / 10.0);    /* beginning of collection window */
   if (start_at > 300.0) start_at = 300.0;
   stop_at  = (duration / 1.1);    /* end of collection window */

   (void)sprintf(error_file_name,"OUT%ld.ERR\0",save_data.trans_no.reg_no);
   sprintf(data_file_name,"OUT%ld.DAT\0",save_data.trans_no.reg_no);


   /* copy root path  name */
   if (!(pospath = getenv("POSDIR")))
   {
      strcpy(out_name, pospath);
      strcat(out_name, back_s);
      strcat(out_name, data_file_name);
   }
   else
     strcpy(out_name, data_file_name);

   /* scales down access to databases to take load off of POS server */
   if (!(env_ptr = getenv("POSSCALE")))
     pos_scale=MAX_AREA_CODE;
   else
     pos_scale=atoi(env_ptr);

   if ((env_ptr = getenv("CINDY")))
   {
     Cindy = atoi(env_ptr);          /* For Cindy Corn's MemLeak tests */
     pos_scale=1;
     printf ("Cheating all over the place !\n");
   }
   else
     Cindy = 0;

   if ((env_ptr = getenv("POSTIMEOUT")))
       ComTimeOut = atol(env_ptr);
   else
       ComTimeOut = 5;            /* DCE */


   /* only necessary when POSCNTRL.EXE is not running */
   if ((env_ptr = getenv("POSLOGIN")))
     force_flag_8 = atoi(env_ptr);
   else
     force_flag_8 = 0;


   /* open and truncate the error file */
   fp=fopen(error_file_name,"w");
   if (fp==NULL)
   {
    printf("Couldn't open <%s> error file.\n", error_file_name);
    exit(1);
   }
   fclose(fp);
   /********************************************************
    * Set flag to either (1) Full display of application activity, OR
    * (2) Supress printing to force maximum throughput.
    ********************************************************/

   if ((env_ptr = getenv("NOPRINT")))
     NoPrint = atoi(env_ptr);
   else
     NoPrint = 0;           /* print the results */
   if (NeverPrint) NoPrint=1;


/* setvbuf(stdout, NULL, _IONBF, 0);     work around an OS/2 bug */

clear_screen();

   printf("\n*******************************************\n");
   printf(  "*  (c) IBM PSP Systems Performance        *\n");
   printf(  "*             Bob Russell                 *\n");
   printf(  "*           Department 57LS               *\n");
   printf(  "*             Austin, TX                  *\n");
   printf(  "*******************************************\n");

  /************************************************************************
   * DCE LOGIN
   ************************************************************************/

   if (flag_8 || force_flag_8) Login();

  /************************************************************************
   * Make RPC Connection
   ************************************************************************/
   /* alternate connection method - known port/address */
   if (argc > 5)
   {
     DCE_1(argv[5],                 /* end point */
           argv[6],                 /* network address */
           &bind_h
           );
   }
   else
   {
     DCE_2(&bind_h
           );
   }
   /***********************************************************************/
   printf("DCE/RPC Connection is completed.\n");
   /**********************************************************************/
   if (tranID == 9)
   {
       /*
        * Now that we know where the server is, perhaps our mission
        * is to murder the sucker?
        */

       SetCursorPosition(23,0);
       #ifdef AIX_PROD
         printw("Shooting the Server                                      ");
         refresh();
       #elif IBMOS2
         printf("Shooting the Server                                      \n");
       #endif

       /*
        * suicide is in the RPC IDL
        */
       the_server_crashed = 0;
       TRY
         suicide(bind_h);
       CATCH_ALL
         the_server_crashed = 1;
         SetCursorPosition(22,0);           /* Display the key   */
         printf("DCE RPC Error from Murder Routine\n");
       ENDTRY

       goto NoReport;
   }
   /**********************************************************************/

   if( !NoPrint)
   {
        clear_screen();
        paint_screen(save_data.trans_no.reg_no);
        SetCursorPosition(22,0);
   }
   #ifdef AIX_PROD
     printw("Cash Register <%ld> on line.   ", save_data.trans_no.reg_no);
     refresh();
   #elif IBMOS2
//     printf("Cash Register <%ld> on line.   \n", save_data.trans_no.reg_no);
     printf("Cash Register <%ld> on line.   %s", save_data.trans_no.reg_no
     ,WIDGET);
   #endif
   /**** Initialize some stuff **********************/

   InitRan1(0, seed);                                 /* Seed the Random Gen */

   for (i=0;i<204;i++)
   {
     histogram[i] = 0;                                   /* init array       */
     tx_cnt = get_random(1000000L);                      /* warm it up,
                                                          * takes a couple
                                                          * reps to generate
                                                          * the full range
                                                          * when seeded with
                                                          * teeny seeds.
                                                          */
   }

   if ((env_ptr = getenv("POSPACKET")))
   {
     num_send = atoi(env_ptr);
   }
   else
     num_send = 1;

   if (num_send == 100)
     num_recv = 100;
   else
     num_recv = 1;


   SetCursorPosition(23,0);
   #ifdef AIX_PROD
     printw("Processing has begun ....                                       \n");
     refresh();
   #elif IBMOS2
     printf("Processing has begun ....                                       \n");
   #endif
   /*********************************************************************/


   tx_cnt = 0L;
   in_between = 0.0;
   start_flag=0;
   save_data.trans_header.line_item_cnt = 0L;
   num_sent = num_send;

   /* Start doing real work *********************************/
   ftime(&t5);            /* t5 get a timestamp so i know when to quit */
   ftime(&e1);
   curr_time = 0.0;

   while(curr_time < duration)
   {
       if (flag_2 && !NeverPrint) NoPrint = flag_3;/*signal from POSCNTRL*/

       /*if (start_flag == 0 && curr_time >= start_at)*/
       if ((!flag_2 && start_flag == 0 && curr_time >= start_at) ||
           (flag_2 && flag_5 && start_flag==0) )
       {
                                   /** time to open the collection window **/
         start_flag = 1;
         SetCursorPosition(23,0);
         #ifdef AIX_PROD
           printw("Beginning Data Collection.                                \n");
           refresh();
         #elif IBMOS2
           printf("Beginning Data Collection.                                \n");
         #endif
         ftime(&t3);
       }

       /*
        * If we are running the mixed case, we need to change the
        * tranID in order to achieve the desired mix.
        */
       if (TID == 10)
       {
         switch(tranID)
         {
           case 10:
           {
             tranID = 1;               /* first iteration, do CAT first  */
             save_data.trans_header.line_item_cnt = get_random(4L); /* avg 2.5 item per invoice */
             save_data.trans_header.item_cnt = 0;
             break;
           }
           case 1:
           {
             tranID = 5;   /* next do a CMR */
             break;
           }
           case 5:
           {
             tranID = 4;   /* next do a Line Item PTQ */
             save_data.trans_header.line_item_cnt = get_random(4L); /* avg 2.5 item per invoice */
             save_data.trans_header.item_cnt = 0;
             break;
           }
           case 4:
           {
             if (++save_data.trans_header.item_cnt
                                     == save_data.trans_header.line_item_cnt)
             {
               tranID = 2;                     /* do SAV next  */
             }
             break;
           }
           case 2:
           {
             tranID = 1;   /* start over - do CAT next */
            if (! NoPrint){
             for (i=0;i<=save_data.trans_header.line_item_cnt;i++)
             {
               SetCursorPosition(12+i,3);
               #ifdef AIX_PROD
                 printw (
               #elif IBMOS2
                 printf (
               #endif
 "                                                                            \n"
                         );
             }
             #ifdef AIX_PROD
              refresh();
             #endif
            }
             break;
           }
         }
       }

       /* EXECUTE THE RPC PROCEDURE */
       the_server_crashed = 0;
       switch(tranID)
       {
         case 1:             /* Phone Lookup */
           CustInq(&appl_time,
                NoPrint,
                &d1,
                &d2,
                &save_data,
                bind_h);
           if (the_server_crashed) CrashRecovery(&bind_h);
           break;
         case 2:             /* Sales Check Processing */
           if (!Cindy)
           {
             History(&appl_time,
                          NoPrint,
                          &d1,
                          &d2,
                          &save_data,
                          bind_h);
             if (the_server_crashed) CrashRecovery(&bind_h);
           }

           ftime(&t6);

           if (tranMode == 1)
           {
                if(! flag_1) DCE_4(&bind_h);/* Reconnect to server Stub */

                /* Force DCELOGIN */

           }

           if ((flag_8 || force_flag_8)
                              && (dice = get_random(15L)) == 9L)
           {
             Login();
           }

           ftime(&t7);

           if (start_flag == 1 && (tranMode == 1 || flag_8 || force_flag_8))
           {
              if (curr_time <= stop_at)
              {
                   sale_cnt++;
                   bind_time += howlong(t7.time,t6.time,t7.millitm,t6.millitm,&tenths);
              }
           }

           break;
         case 3:             /* Data Transfer Only */
           if (num_send == 9999)
           {
              num_sent = (short)get_random(8192L);
              if (! NoPrint){
                SetCursorPosition(14,41);
                #ifdef AIX_PROD
                  printw("%4d",num_sent);
                  refresh();
                #elif IBMOS2
                  printf("%4d\n",num_sent);
                #endif
              }
           }
           DataXfer(num_sent,
                    num_recv,
                    &d1,
                    &d2,
                    bind_h);
           if (the_server_crashed) CrashRecovery(&bind_h);
           break;
         case 4:             /* Price Table Query */
           PriceInq(&appl_time,
                NoPrint,
                &d1,
                &d2,
                &save_data,
                bind_h);
           if (the_server_crashed) CrashRecovery(&bind_h);
           break;
         case 5:             /* Catalog Page Transfer */
           Catalog (&appl_time,
                NoPrint,
                &d1,
                &d2 ,
                 bind_h);
           if (the_server_crashed) CrashRecovery(&bind_h);
           break;
         default:
           SetCursorPosition(23,0);
           #ifdef AIX_PROD
             printw("Invalid transaction type <%d> !         ",tranID);
             refresh();
           #elif IBMOS2
             printf("Invalid transaction type <%d> !         \n",tranID);
           #endif
           goto Bailout;

       }


       /*
        * What time is it now ?
        */
       ftime(&t2); /* t2 */
       curr_time =howlong(t2.time,t5.time,t2.millitm,t5.millitm,&tenths);

       /*
        * Now, introduce the think time
        */
       /*
        * This is the RPC response time measured at the client.
        */
       req_time =howlong(d2.time,d1.time,d2.millitm,d1.millitm,&tenths);
       srv_time = (double)appl_time * 0.001;
       curr_req += req_time;
       curr_srv += srv_time;

       if (interval > 10L)
       {
                                               /* think time was specified */
         think_time = exp_ran(interval);       /* Get an exponentially
                                                * distributed random value
                                                */
         if ( (double)think_time  > (req_time * 1000.0) )
         {
           think_time = (long)( (double)think_time - (req_time * 1000.0) );

           THINK.tv_sec=(long)(think_time / 1000);
           THINK.tv_nsec=(long)((think_time % 1000) * 1000000);

           pthread_delay_np(&THINK);
         }
         else
           think_time = 0L;
       }

       if (! NoPrint)
       {
         /*
          * Rather than calculate the TAX and Sales Amount, lets display
          * the Response times in those fields
          */
         SetCursorPosition(18,60);
         #ifdef AIX_PROD
           printw("%8ld  %8.3f", tx_cnt+1, req_time);
         #elif IBMOS2
           printf("%8ld  %8.3f\n", tx_cnt+1, req_time);
         #endif

         /*
          * This is the Application resp time returned from the server stub
          */
         SetCursorPosition(20,70);
         #ifdef AIX_PROD
           printw("%8.3f", srv_time);
           refresh();
         #elif IBMOS2
           printf("%8.3f\n", srv_time);
         #endif
       }

       /** post processing **/
       if (start_flag == 1)
       {
         /* We are in the data collection window? **/
         /*if (curr_time <= stop_at)*/
         if ((curr_time <= stop_at && !flag_2) ||
             (flag_2 && flag_5) )
         {
           if (tenths < 200)
               ++histogram[tenths + 1];          /* times 0.1-19.9 seconds */
           else
               ++histogram[201];                 /* times >= 20.0 seconds  */

           avg_serv_time += srv_time;            /** sum appl times **/
           avg_req_time += req_time;             /** sum RPC times **/

           if (req_time > max_req_time) max_req_time = req_time; /* worst  */

           avg_think += think_time;             /** sum actual think mSec **/

           in_between++;                 /** count transactions in window **/

          /*
           * Rather than calculate the TAX and Sales Amount, lets display
           * the Response times in those fields
           */

           if (! NoPrint)
           {
             SetCursorPosition(19,70);
             #ifdef AIX_PROD
               printw("%8.3f", avg_req_time/(float)in_between);
             #elif IBMOS2
               printf("%8.3f\n", avg_req_time/(float)in_between);
             #endif
             SetCursorPosition(21,70);
             #ifdef AIX_PROD
               printw("%8.3f", avg_serv_time/(float)in_between);
               refresh();
             #elif IBMOS2
               printf("%8.3f\n", avg_serv_time/(float)in_between);
             #endif
           }
         }

         /* And, perhaps we are done **/
         /*if (curr_time >= stop_at)*/
         if ((!flag_2 && start_flag == 1 && curr_time >= stop_at) ||
             (flag_2 && !flag_5 && start_flag==1) )
         {
           ftime(&t4);                                     /* end of window */
           SetCursorPosition(23,0);
           #ifdef AIX_PROD
             printw("Finished Data Collection.                               ");
             refresh();
           #elif IBMOS2
             printf("Finished Data Collection.                               \n");
           #endif
           start_flag=2;
         }
       }

       /** count all transactions **/
       tx_cnt++;

       /*
        * Bail Out of program sorta gracefully.
        */
       #ifdef AIX_PROD
         rc=ioctl(0,FIONREAD,&Numbytes);
       #elif IBMOS2
         if (kbhit()) break;
       #endif

       if(Numbytes >= 1 || flag_7) break;

   } /* end for duration loop */

Bailout:

if (in_between == 0.0) {        /* We pulled out prematurely */
        in_between = 1L;
        sale_cnt = 1L;
}

/******************************************/
/*** Write the DATA file ***/
fp2=fopen(out_name,"w");

if (fp2==NULL)
{
 printf("Can't open <%s> data file.\n",data_file_name);
 goto NoReport;
}
fprintf(fp2,"<%8s> <%8s>         0\n",save_data.trans_no.trans_date,
                                      save_data.trans_no.trans_time);

/***************************************
 * Warning, the data reduction program (CALCPOS.C)
 * is line and column sensitive, don't twiddle with
 * rows count or column format of the following
 * fprintf's.
 ***************************************/

/* window size */
elapse   = howlong(t4.time,t3.time,t4.millitm,t3.millitm,&tenths);

fprintf(fp2,"POS Transaction ID     %8d\n", TID);
fprintf(fp2,"Cash Register Number   %8ld\n", save_data.trans_no.reg_no);
fprintf(fp2,"Transactions in Window %8ld\n", (long)in_between);
fprintf(fp2,"Sales in Window        %8ld\n", (long)sale_cnt);
fprintf(fp2,"Avg Elapsed Time       %8.3f\n", elapse/(float)in_between);
fprintf(fp2,"Avg Response Time      %8.3f\n",
         avg_req_time/(float)in_between);
if (sale_cnt > 0)
        fprintf(fp2,"Avg BINDING IMPORT seq %8.3f\n",
         bind_time/(float)sale_cnt);
else
        fprintf(fp2,"Avg BINDING IMPORT seq %8.3f\n", 0.0);

fprintf(fp2,"Avg Server Appl Time   %8.3f\n",
         avg_serv_time/(float)in_between);
fprintf(fp2,"Maximum Response Time  %8.3f\n", max_req_time);
fprintf(fp2,"Think time parm        %8ld\n", interval);
fprintf(fp2,"Average Think Time     %8.3f\n",
         ((float)avg_think*0.001)/(float)in_between);
if (elapse > 0.0)
  fprintf(fp2,"TPS Rate (Local)       %8.3f\n", in_between/elapse);
else /* don't divide by zero */
  fprintf(fp2,"TPS Rate               %8.3f\n",0.0);
fprintf(fp2,"Total Iterations     = %8ld\n", tx_cnt);
switch(TID)
{
  case 1:
    fprintf(fp2,"Data Packet          = %8d\n",576);
    break;
  case 2:
    fprintf(fp2,"Data Packet          = %8d\n",300);
    break;
  case 3:
    if (num_send == 9999)
      fprintf(fp2,"Data Packet          = %8d\n",4200);
    else
      fprintf(fp2,"Data Packet          = %8d\n",num_send+4);
    break;
  case 4:
    fprintf(fp2,"Data Packet          = %8d\n",180);
    break;
  case 5:
    fprintf(fp2,"Data Packet          = %8d\n",16408);
    break;
  default:
    fprintf(fp2,"Data Packet          = %8d\n",3251);
    break;
}
/*
 * Write out the histogram table
 */
for (j=1;j<201;j++)
{
  fprintf(fp2,"Under %4.1f seconds.    %8d\n",
                (float)j / 10.0, histogram[j]);
}
fprintf(fp2,"Times over 20 sec      %8d\n",
                histogram[201]);

/*
 * Write the API data collected
 */
for (i=0;i<perf_array_ptr;i++)
{
  if (perf_array[i].api_count > 0)
    fprintf(fp2,"%40s %8ld %8.3f\n",
         perf_array[i].api_call,
         perf_array[i].api_count,
         perf_array[i].api_resp_time / (double)perf_array[i].api_count);
}

fprintf(fp2,"End of file.                            \n");

fclose(fp2);

/****** Transfer DATA FILE to the SERVER ******/

   if ((in_file = open(out_name, O_RDONLY)) == -1)
   {
       SetCursorPosition(18, 0);
       printf("Couldn't open data file <%s>\n", data_file_name);
   }
   else
   {


       if ((numread = read(in_file, buffer, SENDMAX)) > 0)
       {
           buffer[numread] = '\0';

           f_len = strlen(data_file_name);
           data_file_name[f_len] = '\0';


           ftime(&t1);
           /*
            * This is an RPC IDL guy
            */
           file_tran(bind_h,
                     f_len,
                     NAMEMAX,
                     data_file_name,
                     numread,
                     SENDMAX,
                     buffer);
           ftime(&t2);
           api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);

           SetCursorPosition(17, 0);
           #ifdef AIX_PROD
             printw("Bytes transfered <%d> Time <%8.2f>\n", numread, api_time);
             refresh();
           #elif IBMOS2
             printf("Bytes transfered <%d> Time <%8.2f>\n", numread, api_time);
           #endif
       }

       close(in_file);
   }


NoReport:

/* Shutdown the RPC connection */
DCE_3(&bind_h);

SetCursorPosition(23,0);
/*
fp=fopen(error_file_name,"a");
fprintf(fp,"Flags= %d %d %d %d %d %d %d %d\n POS_Signal=%d",
flag_1,
flag_2,
flag_3,
flag_4,
flag_5,
flag_6,
flag_7,
flag_8,
POS_Signal
  );
fclose(fp);
*/

#ifdef AIX_PROD
  die();
#endif
} /* End of MAIN */

/**************************************************************************/

/******** HOW LONG **********/
static double howlong(time_t a,time_t b,
                      unsigned short c,unsigned short d,
                      int * elapsed_sec)
{
  double e;

  e =((a * 1000L + c) - (b * 1000L + d)) * 0.001;

  *elapsed_sec = (short)((e + 0.029) * 10.0); /* rounded up */
  return(e);
}
/**************************************************************************/
void paint_screen(long reg_no)
{
 char     Date[9], Time[9];

   #ifdef AIX_PROD
     time(&CURTIME);
     strftime(Date,9, "%D",localtime(&CURTIME));
     strftime(Time,9, "%T",localtime(&CURTIME));
   #elif IBMOS2
     _strdate(Date);
     _strtime(Time);
   #endif

 SetCursorPosition(0,0);

 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
   "%s\n",Date);

 SetCursorPosition(0,70);

 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
   "%s\n",Time);

 SetCursorPosition(0,22);

 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
   "DCE Application Benchmark\n");

 SetCursorPosition(1,20);

 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
   "Russell's Nickel & Dime Store\n");

/*0....:....1....:....2....:....3....:....4....:....5....:....6....:....7....:....8 */
 SetCursorPosition(2,0);
 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
 "Acct:___________ CrCard ________________________ TransType ____ Aproval ________\n");
 SetCursorPosition(3,0);
 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
 "Name:________________________________________________ ________________________ _\n");
 SetCursorPosition(4,0);
 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
 "Ship Adr:_______________________________________________________________________\n");
 SetCursorPosition(5,0);
 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
 "Mail Adr:_______________________________________________________________________\n");
 SetCursorPosition(6,0);
 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
 "City:________________________________________________ State __  ZIP _____ - ____\n");
 SetCursorPosition(7,0);
 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
 "Area (___) Ph _______ Extn _______  Drv Lic:________________________ DrvState __\n");
 SetCursorPosition(8,0);
 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
 "Cus Ref:________________________________________________________________________\n");
 SetCursorPosition(9,0);
 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
   "Bytes written to history log: \n");
 SetCursorPosition(10,3);
 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
 "Qty  Item No     Description                              Unit Prc   Amount\n");
 SetCursorPosition(11,3);
 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
 "---- ----------- ---------------------------------------- -------- --------\n");
 SetCursorPosition(12,3);
 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
 "  __ ___________                                              0.00     0.00\n");

 SetCursorPosition(18,3);
 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
 "Department 59LS                  [Sub Total ] Remote Time          _____.__\n");
 SetCursorPosition(19,3);
 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
 "Employee   379834                [Disc Pcnt ] Remote Avg   ___.__  _____.__\n");
 SetCursorPosition(20,3);
 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
 "Register   %3ld                   [Tax Pcnt  ] Appl Time    ___.__  _____.__\n",
   reg_no);
 SetCursorPosition(21,3);
 #ifdef AIX_PROD
   printw (
 #elif IBMOS2
   printf (
 #endif
 "Last Purch MMDDYYYY              [Total     ] Appl Avg             _____.__\n");
 #ifdef AIX_PROD
   refresh();
 #endif


 return;
}
/*************************************************************************/
/*
 * OS/2 Specific call to set cursor position in text mode (RR=0-24, CC=0-79)
    mvcur(LINES/2, COLS/2,RR, CC);
 */
void SetCursorPosition(int RR, int CC)
{
   #ifdef AIX_PROD
    move(RR, CC);
   #elif IBMOS2
    VioSetCurPos(RR, CC, 0);
   #endif
   return;
}
/*************************************************************************/
#ifdef AIX_PROD
 startscr(void)
 {
   initscr();
   noecho();
   leaveok(stdscr,TRUE);
   scrollok(stdscr,FALSE);
   return;
 }
 die(void)
 {
   signal( SIGINT, SIG_IGN);
 /*
   mvcur(LINES/2, COLS/2,0, 0);
   wclear(curscr);
   wrefresh(curscr);
 */
   endwin();
   exit (0);
 }
#endif
void clear_screen(void)
{
   #ifdef AIX_PROD
    wclear(curscr);
    wrefresh(curscr);
   #elif IBMOS2
    VioScrollUp(0,0,-1,-1,-1,(char *)FillChar,0);
   #endif
   return;
}
/************************************************************************/
/**********************************
 * DCELOGIN cell_admin -dce-
 **********************************/
void Login(void)
{
   char             execbuf[50];

   static char      template[40];
   static char      process_arg[32];
   static char      space[2]="  ";
   unsigned         execflags=2;
   int      rc1, rc2;
   struct timeb     t1;
   struct timeb     t2;
   double           api_time=0.0;
   int              tenths=0;
   char             * env_ptr;
   /*
   long             dice;
   char             wrk[12];
   */

    SetCursorPosition(17,0);
    #ifdef IBMOS2
      printf("Principal is Logged Off. \n");
    #elif AIX_PROD
      printw("Principal is Logged Off. ");
      refresh();
    #endif

    strcpy(process_arg, "poslogin  ");

    if(!(env_ptr = getenv("HOSTNAME")))
    {
        strcat(process_arg, THE_USER);
        strcat(process_arg, space);
        strcat(process_arg, THE_PASSWORD);
    }
    else
    {
      /* The regular way */
        strcat(process_arg, env_ptr);
        strcat(process_arg, space);
        if(!(env_ptr = getenv("POSPASSWORD")))
           strcat(process_arg, "agape");
        else
           strcat(process_arg, env_ptr);

      /* added for login stress test */
      /*
        dice=get_random(999L)+1000L;
        (void)sprintf(wrk,"usr%4ld\0",dice);
        strcat(process_arg, wrk);
        strcat(process_arg, " ");
        strcat(process_arg, "please");
       */
    }

    #ifdef IBMOS2
     process_arg[10]= '\0';
    #endif

    sprintf(execbuf,"%s %s", template, process_arg);

    ftime(&t1);
    system(execbuf);
    ftime(&t2);

    api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);
    if (t1.timezone != t2.timezone)
    {
      api_time -= (float)(t2.timezone-t1.timezone)*60.0;
    }

    perf_array[0].api_resp_time += api_time;
    perf_array[0].api_count ++;

   /*
    * end DCELOGIN
    */

    SetCursorPosition(17,0);
    #ifdef IBMOS2
      printf("Principal back on line. \n");
    #elif AIX_PROD
      printw("Principal back on line. ");
      refresh();
    #endif
}
/*************************************************************
 * RPC Connect with known address/port
 *************************************************************/
void
DCE_1(unsigned char * pszEndPoint,
      unsigned char * pszNetworkAddress,
      rpc_binding_handle_t *bind_h )
{
  /* RPC variables */
   unsigned char * pszUuid             = "334A2E24-0000-0000-0D00-379834040000";
   unsigned char * pszProtocolSequence = "ncadg_ip_udp";
   unsigned char * pszOptions          = NULL;
            char * pszStringBinding;
   error_status_t   st;
   struct timeb     t1;
   struct timeb     t2;
   double           api_time=0.0;
   int              tenths=0;
   char             * env_ptr;

  /*
   * Method 1: Connect to a known destination. Requires
   * Port Number and IP Address
   */

   SetCursorPosition(1,0);
   printf("Override 'rpc_ns_binding_import' using <%s><%s>\n",
                                          pszEndPoint, pszNetworkAddress);

   if (!(env_ptr = getenv("POSPROTOCOL")))
     printf("Environment variable 'POSPROTOCOL' not found.\n");
   else
     strcpy(pszProtocolSequence, env_ptr);

   printf("PROTSEQ  = <%s>\n",pszProtocolSequence);

  /*
   * Compose String Binding
   */

   ftime(&t1);

   rpc_string_binding_compose(pszUuid,
                              pszProtocolSequence,
                              pszNetworkAddress,
                              pszEndPoint,
                              pszOptions,
                              &pszStringBinding,
                              &st);

   ftime(&t2);

   api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);

  /*
   * Glitch work_around. On the first RPC API call, the local time
   * zone may get adjusted. Bug or Feature?
   */
  if (t1.timezone != t2.timezone)
  {
    api_time -= (float)(t2.timezone-t1.timezone)*60.0;
  }

  perf_array[10].api_resp_time += api_time;
  perf_array[10].api_count ++;
  perhaps_an_error_2(st);

  /*
   ***** Bind it
   */

  ftime(&t1);

  rpc_binding_from_string_binding(pszStringBinding, bind_h ,&st);

  ftime(&t2);
  api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);

  perf_array[11].api_resp_time += api_time;
  perf_array[11].api_count ++;
  perhaps_an_error_2(st);

  printf("Bound to %s[%s]\n",pszNetworkAddress,
                                pszEndPoint);

  ftime(&t1);
  rpc_string_free(&pszStringBinding, &st);
  ftime(&t2);
  api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);

  perf_array[12].api_resp_time += api_time;
  perf_array[12].api_count ++;
  perhaps_an_error_2(st);

  printf("RpcStringFree returned %ld\n", st);

} /* End of Connect with Known Address */

/*************************************************************
 * RPC Connect - Lookup application via CDS
 *************************************************************/
void
DCE_2( rpc_binding_handle_t *bind_h )
{
  /* RPC variables */
   unsigned char * pszUuid             = "334A2E24-0000-0000-0D00-379834040000";
   unsigned char * pszProtocolSequence = "ncadg_ip_udp";
   unsigned char * pszOptions          = NULL;
            char * pszStringBinding;
   error_status_t  st;
   struct timeb    t1;
   struct timeb    t2;
   double          api_time=0.0;
   int              tenths=0;
   rpc_ns_handle_t import_h;

   char          * env_ptr;
   unsigned char * pszAuthPrincipalL   = "";
/*
   unsigned char * pszAuthPrincipal    = "cell_admin";
   unsigned char * pszAuthPrincipalL   = "";
   unsigned32      longAuthLevel       = 3;
*/
   unsigned32      longAuthLevelL      = 0;
   /*
      rpc_c_protect_level_default (0)
      rpc_c_protect_level_none (1)
      rpc_c_protect_level_connect (2)
      rpc_c_protect_level_call (3)
      rpc_c_protect_level_pkt (4)
      rpc_c_protect_level_pkt_integ (5)
      rpc_c_protect_level_pkt_privacy (6)

   unsigned32      longAuthnProtocol    = 1;
    */
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


   /*
    * User did not specify an endpoint, so we gotta
    * IMPORT it from CDS
    */

   ftime(&t1);

   rpc_ns_binding_import_begin (rpc_c_ns_syntax_default,
                                "/.:/PointOfSale",
                                PointOfSale_v0_0_c_ifspec,
                                NULL,
                                &import_h,
                                &st);

   ftime(&t2);
   api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);
   if (t1.timezone != t2.timezone)
   {
     api_time -= (float)(t2.timezone-t1.timezone)*60.0;
   }

   perf_array[1].api_resp_time += api_time;
   perf_array[1].api_count ++;
   perhaps_an_error_2(st);

   /**********************************************************************/
   /*
    * Force the Client to refresh his local cache
    */

   printf("Force the Client to refresh his local cache!\n");

   ftime(&t1);


   rpc_ns_mgmt_handle_set_exp_age(import_h,
                                  0L,
                                  &st);
   ftime(&t2);
   api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);


   perf_array[2].api_resp_time += api_time;
   perf_array[2].api_count ++;
   perhaps_an_error_2(st);

   /**********************************************************************/

   ftime(&t1);

   rpc_ns_binding_import_next (import_h,
                               bind_h,
                               &st);

   ftime(&t2);
   api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);

   perf_array[3].api_resp_time += api_time;
   perf_array[3].api_count ++;
   perhaps_an_error_2(st);

   /**********************************************************************/
   ftime(&t1);

   rpc_ns_binding_import_done (&import_h, &st);

   ftime(&t2);
   api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);

   perf_array[4].api_resp_time += api_time;
   perf_array[4].api_count ++;
   perhaps_an_error_2(st);

   /**********************************************************************/
   ftime(&t1);

   rpc_ep_resolve_binding (*bind_h, PointOfSale_v0_0_c_ifspec, &st);

   ftime(&t2);
   api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);

   perf_array[5].api_resp_time += api_time;
   perf_array[5].api_count ++;
   perhaps_an_error_2(st);

   /**********************************************************************/
   ftime(&t1);

   rpc_binding_to_string_binding (*bind_h, &pszStringBinding, &st);

   ftime(&t2);
   api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);

   printf("Binding=<%s>\n", pszStringBinding);

   perf_array[6].api_resp_time += api_time;
   perf_array[6].api_count ++;
   perhaps_an_error_2(st);

   ftime(&t1);
   rpc_string_free(&pszStringBinding, &st);
   ftime(&t2);
   api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);
   printf("RpcStringFree returned %ld\n", st);

   perf_array[12].api_resp_time += api_time;
   perf_array[12].api_count ++;
   perhaps_an_error_2(st);
   /**********************************************************************/

   ftime(&t1);

   rpc_mgmt_is_server_listening (*bind_h, &st);

   ftime(&t2);
   api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);

   perf_array[7].api_resp_time += api_time;
   perf_array[7].api_count ++;
   perhaps_an_error_2(st);

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
     longAuthLevel = atol(env_ptr);
   else
     longAuthLevel = 3;           /* call */

   /*****************/
   if ((env_ptr = getenv("AUTHN")))
     longAuthnProtocol = atol(env_ptr);
   else
     longAuthnProtocol = 1;           /* secret */

   /*****************/
   if ((env_ptr = getenv("AUTHZ")))
     longAuthzProtocol = atol(env_ptr);
   else
     longAuthzProtocol = 2;            /* DCE */


   /*****************/
   if (longAuthLevel != 0)
   {
     ftime(&t1);

     rpc_binding_set_auth_info(*bind_h,
                               pszAuthPrincipal,
                               longAuthLevel,
                               longAuthnProtocol,
                               NULL,
                               longAuthzProtocol,
                               &st );

     ftime(&t2);
     api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);

     perf_array[8].api_resp_time += api_time;
     perf_array[8].api_count ++;
     perhaps_an_error_2(st);

     /****************************************************/
     /*
     ftime(&t1);

     rpc_ss_register_auth_info(*bind_h,
                               pszAuthPrincipal,
                               longAuthLevel,
                               longAuthnProtocol,
                               NULL,
                               longAuthzProtocol,
                               &st );

     ftime(&t2);
     api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);

     perf_array[13].api_resp_time += api_time;
     perf_array[13].api_count ++;
     perhaps_an_error_2(st);
     */
     /****************************************************/
     ftime(&t1);

     rpc_binding_inq_auth_info(*bind_h,
                               &pszAuthPrincipalL,
                               &longAuthLevelL,
                               &longAuthnProtocolL,
                               NULL,
                               &longAuthzProtocolL,
                               &st );

     ftime(&t2);
     api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);


     perf_array[9].api_resp_time += api_time;
     perf_array[9].api_count ++;
     perhaps_an_error_2(st);

     printf("Auth Info: Principal        =%s\n", pszAuthPrincipalL);
     printf("Auth Info: Level            =%ld\n", longAuthLevelL);
     printf("Auth Info: AuthNProtocol    =%ld\n", longAuthnProtocolL);
     printf("Auth Info: AuthZProtocol    =%ld\n", longAuthzProtocolL);
   }
} /* End of Connect with Import Binding */
/****************************************************
 *     End the Connection to the Application Server *
 ****************************************************/
void DCE_3(rpc_binding_handle_t *bind_h )
{
     error_status_t  st;

     rpc_binding_free(bind_h, &st);
     SetCursorPosition(20, 0);
     printf("RpcBindingFree returned %ld\n", st);

     SetCursorPosition(22,0);
     printf("Register Signed Off.                                             \n");

}

/*************************************************************
 * RPC Connect - Lookup application via CDS
 * QUICK PATH
 *************************************************************/
void DCE_4(rpc_binding_handle_t *bind_h )
{
  /* RPC variables */
   error_status_t  st;
   rpc_ns_handle_t import_h;
   char          * pszStringBinding;
   struct timeb    t1;
   struct timeb    t2;
   double          api_time=0.0;
   int             tenths=0;


   /* Release the Binding */
   ftime(&t1);
   rpc_binding_free(bind_h, &st);
   ftime(&t2);
   api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);
   perf_array[14].api_resp_time += api_time;
   perf_array[14].api_count ++;

   perhaps_an_error_2(st);

   /* Import a new Binding */
   ftime(&t1);
   rpc_ns_binding_import_begin (rpc_c_ns_syntax_default,
                                "/.:/PointOfSale",
                                PointOfSale_v0_0_c_ifspec,
                                NULL,
                                &import_h,
                                &st);

   ftime(&t2);
   api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);
   perf_array[1].api_resp_time += api_time;
   perf_array[1].api_count ++;

   perhaps_an_error_2(st);

   if (flag_4) /* signal from POSCNTRL */
   {
     ftime(&t1);
     rpc_ns_mgmt_handle_set_exp_age(import_h,
                                  0L,
                                  &st);
     ftime(&t2);
     api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);
     perf_array[2].api_resp_time += api_time;
     perf_array[2].api_count ++;

     perhaps_an_error_2(st);
   }

   ftime(&t1);
   rpc_ns_binding_import_next (import_h,
                               bind_h,
                               &st);

   ftime(&t2);
   api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);
   perf_array[3].api_resp_time += api_time;
   perf_array[3].api_count ++;

   perhaps_an_error_2(st);

   ftime(&t1);
   rpc_ns_binding_import_done (&import_h, &st);

   ftime(&t2);
   api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);
   perf_array[4].api_resp_time += api_time;
   perf_array[4].api_count ++;

   perhaps_an_error_2(st);

   ftime(&t1);
   rpc_ep_resolve_binding (*bind_h, PointOfSale_v0_0_c_ifspec, &st);

   ftime(&t2);
   api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);
   perf_array[5].api_resp_time += api_time;
   perf_array[5].api_count ++;

   perhaps_an_error_2(st);

   ftime(&t1);
   rpc_binding_to_string_binding (*bind_h, &pszStringBinding, &st);

   ftime(&t2);
   api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);
   perf_array[6].api_resp_time += api_time;
   perf_array[6].api_count ++;

   perhaps_an_error_2(st);

   if (! NoPrint)
   {
     SetCursorPosition(5,9);
     #ifdef AIX_PROD
       printw ("%s",pszStringBinding);
       refresh();
     #elif IBMOS2
       printf ("%s\n",pszStringBinding);
     #endif

   }

   /* Change# 2 4/4/94 added call to insure space is freed */
   ftime(&t1);
   rpc_string_free(&pszStringBinding, &st);
   ftime(&t2);
   api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);
   perf_array[12].api_resp_time += api_time;
   perf_array[12].api_count ++;


   /**********************************************
    * Authentication Stuff
    **********************************************/
     rpc_binding_set_auth_info(*bind_h,
                               pszAuthPrincipal,
                               longAuthLevel,
                               longAuthnProtocol,
                               NULL,
                               longAuthzProtocol,
                               &st );

   ftime(&t2);
   api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);
   perf_array[8].api_resp_time += api_time;
   perf_array[8].api_count ++;

   perhaps_an_error_2(st);

   if (longAuthLevel==6)
   {
     ftime(&t1);

     rpc_mgmt_is_server_listening (*bind_h, &st);

     ftime(&t2);
     api_time =howlong(t2.time,t1.time,t2.millitm,t1.millitm,&tenths);
     perf_array[7].api_resp_time += api_time;
     perf_array[7].api_count ++;
     perhaps_an_error_2(st);
   }

} /* End of Connect with Import Binding */
/***************************************************
 * Quick version of error handler
 ***************************************************/
 void perhaps_an_error_2( error_status_t st1 )
 {
     int           st2=0;
     unsigned char msgstring[160];

     if (st1 != error_status_ok)
     {
       fp=fopen(error_file_name,"a");
       fprintf(fp,"Error_Status = %ld\n", st1);
       fclose(fp);

         printf("Error_Status = %ld\n", st1);

         dce_error_inq_text(st1, (unsigned char *)msgstring, &st2);

         if (st2 == error_status_ok)
         {
           fp=fopen(error_file_name,"a");
           fprintf(fp,"Error: %s\n", msgstring);
           fclose(fp);

           printf("<%s>\n", msgstring);
           #ifdef AIX_PROD
             die();
           #endif
         }

     }

     return;
 }
/***************************************************
 * Recovery from disaster
 ***************************************************/
void CrashRecovery (rpc_binding_handle_t *bind_h )
{
   error_status_t  DCEst;


   SetCursorPosition(12,4);printf("     ******************************  \n");
   SetCursorPosition(13,4);printf("     **                          **  \n");
   SetCursorPosition(14,4);printf("     **      PLEASE STANDBY      **  \n");
   SetCursorPosition(15,4);printf("     **                          **  \n");
   SetCursorPosition(16,4);printf("     ******************************  \n");
   SetCursorPosition(23,0);
   printf("YooHoo, POS Server......                        \n");

   rpc_mgmt_set_com_timeout (*bind_h, 0L, &DCEst);

   rpc_mgmt_is_server_listening (*bind_h, &DCEst);

   while (DCEst)
   {
     SetCursorPosition(23,0);
     printf("Anybody else out there....?                    \n", DCEst);

     flag_4 = 1;

     DCE_4(bind_h);

     SetCursorPosition(23,0);
     printf("Are you listening.....?                        \n");

     rpc_mgmt_set_com_timeout (*bind_h, 0L, &DCEst);
     rpc_mgmt_is_server_listening (*bind_h, &DCEst);
   }

   rpc_mgmt_set_com_timeout (*bind_h, ComTimeOut, &DCEst);

   SetCursorPosition(22,0);
   printf("OK, retry was sucessful                     \n");
   SetCursorPosition(23,0);
   printf("                                            \n");
   SetCursorPosition(12,4);printf("                                     \n");
   SetCursorPosition(13,4);printf("                                     \n");
   SetCursorPosition(14,4);printf("                                     \n");
   SetCursorPosition(15,4);printf("                                     \n");
   SetCursorPosition(16,4);printf("                                     \n");
   SetCursorPosition(1,0);
}
