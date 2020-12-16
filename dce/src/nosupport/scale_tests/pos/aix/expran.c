/** EXPRAN.C *********************************************************/
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
/* * * * * * * * * * * * * * * exp_ran subroutine * * * * * * * * * * * * * */
/* . . generate random number w/exponential distribution  . . . . . . . . . *
 *               -t/ç                                                       *
 * P{Xót} = 1 - e        (where ç = avg. think time = 1 / rate).            *
 *      t = -ç ( ln(1 - P{Xót}) ).                                          *
 * * * * * * * * * * * * * * * * *  * * * * * * * * * * * * * * * * * * * * */
#include <math.h>

long   exp_ran(long avg_val)                 /* ç (avg. think time (msec) ) */
{
 /* * * * * * * * * * * * * * * local variables * * * * * * * * * * * * * * */
 long     think_time;
 double   tmp_dbl=0;
 double   tmp_ln;
 long     tmp_long;

 /* start execution * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

    /* P{Xót} . . . . . . . . . . .uniform from 0 to 1: random number input */
    tmp_long = get_random(32768L) - 1L;          /* uniform from 0 to 32767 */
    if (tmp_long == 32767L) /* avoid ln(0) singularity (max think_time = ì) */
    {
       think_time = avg_val * 15L;              /* use 15x as max multiplier */
    }
    else
    {
       /* 1 - P{Xót}  . . . . . . . . . . . . . . . . . uniform from 1 to 0 */
       tmp_dbl = (double)(32767L-tmp_long)/32767.0;

       /* ln(1 - P{Xót})  . . . . . . . . . . . . . . valid for tmp_dbl > 0 */
       tmp_ln = log(tmp_dbl);

       /* -ç * ( ln(1 - P{Xót}) ) . . . . . . . . . . . . . . . . . . . . . */
       think_time = -(long)((double)avg_val * tmp_ln);
    }

 return(think_time);

} /* end exp_ran */
/***************************************************************************/
