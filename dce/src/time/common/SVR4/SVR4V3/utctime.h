/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1994, 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
 * the full copyright text.
 */
/*
 * @SNI_COPYRIGHT@
 */
/*
 *(c) Copyright 1991,1992 Siemens-Nixdorf Information Systems,Burlington,MA,USA.
 * All Rights Reserved
 */
/*
 * HISTORY
 * $Log: utctime.h,v $
 * Revision 1.1.6.2  1996/02/18  23:11:09  marty
 * 	Update OSF copyright years
 * 	[1996/02/18  22:36:03  marty]
 *
 * Revision 1.1.6.1  1995/12/08  18:05:35  root
 * 	Submit OSF/DCE 1.2.1
 * 	[1995/12/08  17:23:36  root]
 * 
 * Revision 1.1.4.1  1994/06/10  20:51:50  devsrc
 * 	cr10872 - fixed copyright
 * 	[1994/06/10  16:48:41  devsrc]
 * 
 * Revision 1.1.2.2  1993/02/01  20:18:21  hinman
 * 	[hinman] - Check in SNI revision 1.1.2.2
 * 	[1993/01/08  14:10:33  hinman]
 * 
 * Revision 1.1.2.2  92/11/02  17:57:56  steveg
 * 	New file to support SVR4V3 TARGET_OS_PLATFORM
 * 	[92/11/02  16:38:16  steveg]
 * 
 * $EndLog$
 */
/*	@(#)utctime.h	1.0	(ULTRIX)	4/23/90	*/

#ifndef _UTCTIME_H
#define _UTCTIME_H	"@(#)utctime.h	1.0	(ULTRIX)	4/23/90"

/************************************************************************
 *									*
 *			Copyright (c) 1990 by				*
 *		Digital Equipment Corporation, Maynard, MA		*
 *			All rights reserved.				*
 *									*
 *   This software is furnished under a license and may be used and	*
 *   copied  only  in accordance with the terms of such license and	*
 *   with the  inclusion  of  the  above  copyright  notice.   This	*
 *   software  or  any  other copies thereof may not be provided or	*
 *   otherwise made available to any other person.  No title to and	*
 *   ownership of the software is hereby transferred.			*
 *									*
 *   The information in this software is subject to change  without	*
 *   notice  and should not be construed as a commitment by Digital	*
 *   Equipment Corporation.						*
 *									*
 *   Digital assumes no responsibility for the use  or  reliability	*
 *   of its software on equipment which is not supplied by Digital.	*
 *									*
 ************************************************************************/

#include "int64.h"

#ifdef KERNEL

#define K_UTC_VERSION	(1 << 12)
#define K_100NS_PER_SEC (10000000)
#define K_US_PER_SEC    (1000000)
#define K_NS_PER_SEC    (1000000000)

#endif

/*
 * Structure definitions for utctime used by DECdts
 */

#ifndef _UTC_T_
#define _UTC_T_	 
typedef struct utc {
	struct int64	time;
	long int	inacclo;
	short int	inacchi;
	short tdf;
} utc_t;
#endif

enum adjmode {
	settime,  	/* Set time */
	adjusttime,	/* Adjust time */
	endadjust,	/* End adjust time */
	getresolution,  /* Get resolution of clock */
	getdrift,       /* Get drift reciprocal */
	setfreq,	/* Set (tweek) the clock frequency */
	getfreq,	/* Get the clock frequency */
	lastmode	/* Used as limit test */
};

#ifndef _TIMESPEC_T_
#define _TIMESPEC_T_	 
typedef struct timespec
{
    unsigned long tv_sec;
    long tv_nsec;
} timespec_t;
#endif

#ifndef _RELTIMESPEC_T_
#define _RELTIMESPEC_T_	 
typedef struct reltimespec {
    long tv_sec;
    long tv_nsec;
} reltimespec_t;
#endif

union adjunion {
    struct adjargs {
	struct reltimespec a_adjustment; /* Amount to adjust or change */
	struct timespec	a_comptime;	/* Time which corresponds to base
					   inaccuracy */
	struct int64	a_baseinacc;	/* Base inaccuracy */
	struct int64	a_leaptime;	/* Time of next potential leap
					   second */
	long int	a_adjrate;	/* Rate at which to adjust
						1000 = .1% (.0768% on PMAX)
						100 = 1% (.999% on PMAX)
						10 = 10%, etc.
					   Ignored for set time */
	long int	a_curtdf;	/* Current timezone */
	long int	a_nextdf;	/* Next timezone (eg. Daylight time) */
	long int	a_tdftime;	/* Time of next timezone change */
    } adjargs;				/* Adustment args */
    long int		resolution;	/* Resolution of clock in nanosecs */
    unsigned long int	maxdrift;	/* Maximun drift rate of clock */
    struct trimargs {
	long int	t_frequency;	/* New frequency trim of clock */
	long int	t_maxdrift;	/* New maximun drift rate of clock */
    } trimargs;
    long int		frequency;	/* Current frequency trim of clock */
};

#endif /* _UTCTIME_H */
