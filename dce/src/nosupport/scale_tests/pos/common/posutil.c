/** POSUTIL.C ********************************************************/
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
 * MODIFICATION HISTORY:
 *
 *    10-16-92  Bob Russell Created for POS Benchmark
 ************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <pthread.h>


#ifdef IBMOS2
 #include <io.h>
 #include <os2.h>
 #include <os2def.h>
 #include <sys\stat.h>
 #include <sys\types.h>
#else
 #include <sys/stat.h>
 #include <sys/types.h>
#endif

#include "pos_idl.h"
#include "pos.h"

#ifdef DB22
 #include "sqlagent.h"
#endif

int           history_file_handle=-1;


/********************************************************************/
int CreateHistorySem(void)
{
   char          *sav_path;
   unsigned char file_name[80];

   /******** Open History File ***********/
   sav_path = getenv("POSSAVE");
   if (! sav_path)
   {

     printf("GetEnv POSSAVE Environment variable not set.\n");

     /* Default to current directory */
     strcpy(file_name, "POSHIST.ORY");

   }
   else
   {
     strcpy(file_name,sav_path);
     strcat(file_name,BACK_SLASH);
     strcat(file_name,"POSHIST.ORY");
   }

   #ifdef DEBUGIT
   printf("Opening POS HISTORY FILE <%s>\n",file_name);
   #endif

   if ((history_file_handle =
/*        open(file_name, O_CREAT | O_APPEND | O_BINARY | O_RDWR , S_IWRITE) */
        open(file_name, O_CREAT | O_TRUNC | O_RDWR, S_IWRITE )
       ) == -1)
   {
     printf("Open <%s> Failed\n", file_name);
   }

   printf("Opening POS HISTORY FILE <%s> rc=%d\n",file_name,history_file_handle);

 return(history_file_handle);
}
/********************************************************************/
unsigned long WriteHistory(SAVE_DATA * sendbuf, unsigned short in_len)
{
   int           num_wrt;
   unsigned long rc;

   /*****************************************************/

   if  ((rc =
         write(history_file_handle, sendbuf, in_len)
        ) == -1 )

   {
     printf("Write HISTORY File Failed %d Handle %d\n",
              rc, history_file_handle);
   }
   #ifdef DEBUGIT
   printf("<%6d> Bytes written to  History File\n",rc);
   #endif

   /*****************************************************/

   return(rc);
}
/*****************************************************/
unsigned long CloseHistoryFile(int hfh)
{
   int        ret_code;

   if ((ret_code =
        close(hfh)
       ))
     printf("Close HISTORY File Failed %d Handle %d\n", ret_code, hfh);
   else
     printf("HISTORY File has been closed.\n");

   return(ret_code);
}
/*********************************************************************/
/* the following added for DB2/2 support                             */
/********************************************************************/
#ifdef DB22
int CreateAgentSem(int agent_id)
{
   APIRET        ret_code;
   BOOL32   price_state = 1;
   unsigned long fattrib = 0L;
   unsigned char sem_name[40];
   HEV           agent_sem=0;

   (void)sprintf(sem_name,"\\SEM32\\AGENT_SEM%d\0",agent_id);

   if ((ret_code = DosCreateEventSem(sem_name,       // "\\SEM32\\AGENT_SEM",
                                       &agent_sem, fattrib, price_state)) != 0)
   {
     printf("DosCreateEventSem (AGENT_SEM) Failed %ld\n", ret_code);
   }
// SetAgentSem(agent_id);

   return(ret_code);
}

/********************************************************************/
int SetAgentSem(int agent_id)
{
   unsigned long post_cnt = 0L;
   APIRET        ret_code;
   unsigned char sem_name[40];
   HEV           agent_sem=0;

   (void)sprintf(sem_name,"\\SEM32\\AGENT_SEM%d\0",agent_id);

     if ((ret_code = DosOpenEventSem(sem_name,  //     "\\SEM32\\AGENT_SEM",
                                     &agent_sem)) != 0)
     {
       printf("DosOpenEventSem Failed %ld\n", ret_code);
     }

     if ((ret_code = DosResetEventSem (agent_sem, &post_cnt)) == 300)
     {
       if ((ret_code = DosWaitEventSem (agent_sem, (long) -1)) != 0)
         printf("DosWaitEventSem Failed %ld\n", ret_code);
     }
     else
     {
       if (ret_code != 0)
         printf("DosResetEventSem RC=%ld\n", ret_code);
     }
  return(ret_code);
}

/********************************************************************/
int ClearAgentSem(int agent_id)
{
   unsigned long post_cnt = 0L;
   APIRET        ret_code;
   unsigned char sem_name[40];
   HEV           agent_sem=0;

   (void)sprintf(sem_name,"\\SEM32\\AGENT_SEM%d\0",agent_id);

     if ((ret_code = DosOpenEventSem(sem_name,  //     "\\SEM32\\AGENT_SEM",
                                     &agent_sem)) != 0)
     {
       printf("DosOpenEventSem Failed %ld\n", ret_code);
     }

     if ((ret_code = DosPostEventSem(agent_sem)) != 0)
       printf("DosPostEventSem Failed  %ld\n", ret_code);

  return(ret_code);
}

/********************************************************************/
int WaitAgentSem(int agent_id)
{
   unsigned long post_cnt = 0L;
   APIRET        ret_code;
   unsigned char sem_name[40];
   HEV           agent_sem=0;

   (void)sprintf(sem_name,"\\SEM32\\AGENT_SEM%d\0",agent_id);

     if ((ret_code = DosOpenEventSem(sem_name,  //     "\\SEM32\\AGENT_SEM",
                                     &agent_sem)) != 0)
       printf("DosOpenEventSem Failed %ld\n", ret_code);

     if ((ret_code = DosWaitEventSem (agent_sem, (long) -1)) != 0)
       printf("DosWaitEventSem Failed %ld\n", ret_code);

   return(ret_code);
}
/********************************************************************/
int CreateServrSem(int servr_id)
{
   APIRET        ret_code;
   BOOL32   price_state = 1;
   unsigned long fattrib = 0L;
   unsigned char sem_name[40];
   HEV           servr_sem=0;

   (void)sprintf(sem_name,"\\SEM32\\SERVR_SEM%d\0",servr_id);

   if ((ret_code = DosCreateEventSem(sem_name,       // "\\SEM32\\SERVR_SEM",
                                       &servr_sem, fattrib, price_state)) != 0)
   {
     printf("DosCreateEventSem (SERVR_SEM) Failed %ld\n", ret_code);
   }
// SetServrSem(servr_id);

   return(ret_code);
}

/********************************************************************/
int SetServrSem(int servr_id)
{
   unsigned long post_cnt = 0L;
   APIRET        ret_code;
   unsigned char sem_name[40];
   HEV           servr_sem=0;

   (void)sprintf(sem_name,"\\SEM32\\SERVR_SEM%d\0",servr_id);

     if ((ret_code = DosOpenEventSem(sem_name,  //     "\\SEM32\\SERVR_SEM",
                                     &servr_sem)) != 0)
     {
       printf("DosOpenEventSem Failed %ld\n", ret_code);
     }

     if ((ret_code = DosResetEventSem (servr_sem, &post_cnt)) == 300)
     {
       if ((ret_code = DosWaitEventSem (servr_sem, (long) -1)) != 0)
         printf("DosWaitEventSem Failed %ld\n", ret_code);
     }
     else
     {
       if (ret_code != 0)
         printf("DosResetEventSem RC=%ld\n", ret_code);
     }
  return(ret_code);
}

/********************************************************************/
int ClearServrSem(int servr_id)
{
   unsigned long post_cnt = 0L;
   APIRET        ret_code;
   unsigned char sem_name[40];
   HEV           servr_sem=0;

   (void)sprintf(sem_name,"\\SEM32\\SERVR_SEM%d\0",servr_id);

     if ((ret_code = DosOpenEventSem(sem_name,  //     "\\SEM32\\SERVR_SEM",
                                     &servr_sem)) != 0)
     {
       printf("DosOpenEventSem Failed %ld\n", ret_code);
     }

     if ((ret_code = DosPostEventSem(servr_sem)) != 0)
       printf("DosPostEventSem Failed  %ld\n", ret_code);

  return(ret_code);
}

/********************************************************************/
int WaitServrSem(int servr_id)
{
   unsigned long post_cnt = 0L;
   APIRET        ret_code;
   unsigned char sem_name[40];
   HEV           servr_sem=0;

   (void)sprintf(sem_name,"\\SEM32\\SERVR_SEM%d\0",servr_id);

     if ((ret_code = DosOpenEventSem(sem_name,  //     "\\SEM32\\SERVR_SEM",
                                     &servr_sem)) != 0)
       printf("DosOpenEventSem Failed %ld\n", ret_code);

     if ((ret_code = DosWaitEventSem (servr_sem, (long) -1)) != 0)
       printf("DosWaitEventSem Failed %ld\n", ret_code);

   return(ret_code);
}
#endif /* DB22 */
/********************************************************************/
/********************************************************************/
/*
int CloseAgentSems(void)
{
   APIRET        ret_code;
   unsigned char sem_name[40];
   HEV           servr_sem=0;
   int           i;

   for (i=0;i<NUM_AGENTS;i++)
   {
     (void)sprintf(sem_name,"\\SEM32\\SERVR_SEM%d\0",i);

     if ((ret_code = DosOpenEventSem(sem_name,
                                     &servr_sem)) != 0)
       printf("DosOpenEventSem Failed %ld\n", ret_code);

     if ((ret_code = DosCloseEventSem (servr_sem)) != 0)
       printf("DosCloseEventSem Failed %ld\n", ret_code);

     (void)sprintf(sem_name,"\\SEM32\\AGENT_SEM%d\0",i);

     if ((ret_code = DosOpenEventSem(sem_name,
                                     &servr_sem)) != 0)
       printf("DosOpenEventSem Failed %ld\n", ret_code);

     if ((ret_code = DosCloseEventSem (servr_sem)) != 0)
       printf("DosCloseEventSem Failed %ld\n", ret_code);
   }

   return(ret_code);
}
*/
/********************************************************************/
