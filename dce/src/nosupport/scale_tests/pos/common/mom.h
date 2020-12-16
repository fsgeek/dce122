/** MOM.H ************************************************************/
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
/* Query tests */
#include "pos.h"
#include <stdio.h>

/* Random number generator */
void InitRan1( int ival, int seed);
unsigned long get_random( long);

/* Exponential Distribution routine */
long exp_ran( long);

/* Performance Data file transfer routine */
void reqfile(unsigned char f_name[14], rpc_binding_handle_t bind_h);

/*
 * Routines to display application responses:
 * - Paint the Application Screen
 * - Clear the Screen
 * - Set the Cursor Position
 */
void paint_screen(long reg_no);
void SetCursorPosition(int RR, int CC);
void clear_screen(void);
void Login(void);
void DCE_1(unsigned char * pszEndPoint,
           unsigned char * pszNetworkAddress,
           rpc_binding_handle_t *bind_h );
void DCE_2(rpc_binding_handle_t *bind_h );
void DCE_3(rpc_binding_handle_t *bind_h );
void DCE_4(rpc_binding_handle_t *bind_h );

/*unsigned short max_files(void);*/

long PriceInq(long *appl_time,
              int NoPrint,
              struct timeb *d1,
              struct timeb *d2,
              SAVE_DATA *save_data,
              rpc_binding_handle_t bind_h);

long Catalog( long *appl_time,
              int NoPrint,
              struct timeb *d1,
              struct timeb *d2,
              rpc_binding_handle_t bind_h);

long CustInq( long *appl_time,
              int NoPrint,
              struct timeb *d1,
              struct timeb *d2,
              SAVE_DATA *save_data,
              rpc_binding_handle_t bind_h);

long History( long *appl_time,
              int NoPrint,
              struct timeb *d1,
              struct timeb *d2,
              SAVE_DATA *save_data,
              rpc_binding_handle_t bind_h);

long start_time,stop_time;


