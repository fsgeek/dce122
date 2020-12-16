/** SQLAGENT.H *******************************************************/
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
/*******************************************
 * For RPC with multiple child processes
 *******************************************/
// #include "pos.h"

/* #define DEBUGIT */

#ifdef DB22
 typedef struct _POS_STUFF
 {
   long            tx_code;
   long            sql_code;
   CUST_DATA       cust_data;
   long            order_qty;
   ITEM_ROW        item_row;
 }  * POS_STUFF;

 #ifdef SQLAGENT
   POS_STUFF     PosAgentRam;
 #else
   #define       NUM_AGENTS 8
   PVOID         ShareBuf[NUM_AGENTS];
   POS_STUFF     PosAgentRam[NUM_AGENTS];
   short         SyncLocks[NUM_AGENTS];
 #endif

 #ifndef POS_PRIMARY
  int  PosDispatcher(void);
  void PosDispatchFree(int MyAgent);
  int CreateAgentSem(int agent_id);
  int SetAgentSem(int agent_id);
  int ClearAgentSem(int agent_id);
  int WaitAgentSem(int agent_id);
  int CreateServrSem(int servr_id);
  int SetServrSem(int servr_id);
  int ClearServrSem(int servr_id);
  int WaitServrSem(int servr_id);
/*  int CloseAgentSems(void);*/
 #endif
#endif


