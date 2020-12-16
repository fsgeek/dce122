/*********************************************************************/
/*** IBM Corporation                                               ***/
/*** OS/2 LAN Systems Performance                                  ***/
/*** Department 59LS                                               ***/
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
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <os2.h>
#include "os2def.h"
#include "bse.h"

#include <sys\types.h>

#include "rpc.h"
#include "dce_error.h"
/*#include "dceerror.h"*/
/**************************************************************
 *** MAIN
 **************************************************************/

void main(int argc, char *argv[]);
void main(int argc, char *argv[])
{
   error_status_t st;
   unsigned char *messg;
   int           st2;

   /**** Read RunTime Parms ***********************/
   if (argc < 2)
   {
     st = 382312477;
     printf("USAGE:  dcemsg dce_msg_num\n");
     printf("Example: dcemsg 382312477\n");
     printf("\nI'll run the example for you now....\n\n");
   }
   else
     st = atol(argv[1]);
   /***********************************************
    * Error Routine
    ***********************************************/
   dce_error_inq_text(st, messg, &st2);
   printf("Error Status = %ld\n===> %s (rc=%d)\n",
                 st, messg, st2);
   exit(1);
}

