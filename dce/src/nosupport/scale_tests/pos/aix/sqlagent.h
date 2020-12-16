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


