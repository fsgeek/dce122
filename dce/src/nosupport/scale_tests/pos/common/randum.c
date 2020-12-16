/** RANDUM.C *********************************************************/
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
/***************************************************************************
 * C Library call to replace old 32bit random generator                    *
 ***************************************************************************
 *   The C runtime random number generator only provides a 15 bit random   *
 *   number.  This is insufficient for our purposes.  This routine         *
 *   generates a true 32 bit random number.  It returns a value between    *
 *   1 and the maximum value requested.                                    *
 ***************************************************************************/
#include <stdlib.h>

void InitRan1( int ival, int seed)
{
  srand(seed);
}

long get_random(long max)
{
  int  x, y;

  if (max < 32767L)
  {
    return( (long)((rand()) % max) + 1L );
  }
  else
  {
    x = rand();
    y = rand();
    return( (long)((x * y) % max) + 1L );
  }
}

/***************************************************************************/
