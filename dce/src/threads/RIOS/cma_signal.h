/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1994, 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
 * the full copyright text.
 *
 * (c) Copyright 1991, 1992 Siemens-Nixdorf Information Systems
 * Burlington, MA, USA
 */
/*
 * HISTORY
 * $Log: cma_signal.h,v $
 * Revision 1.1.4.2  1996/02/18  23:08:41  marty
 * 	Update OSF copyright years
 * 	[1996/02/18  22:32:10  marty]
 *
 * Revision 1.1.4.1  1995/12/07  21:50:57  root
 * 	Submit OSF/DCE 1.2.1
 * 	[1995/12/07  21:01:00  root]
 * 
 * Revision 1.1.2.2  1994/06/09  13:35:40  devsrc
 * 	 CR10892 - fix copyright in file
 * 	[1994/06/09  13:26:10  devsrc]
 * 
 * Revision 1.1.2.1  1994/04/01  20:14:16  jd
 * 	Moved from src/threads to here
 * 	[1994/04/01  17:52:56  jd]
 * 
 * Revision 1.1.2.5  1992/12/15  22:30:44  alan
 * 	Insert copyright notices
 * 	[1992/12/07  19:41:27  alan]
 * 
 * Revision 1.1.2.4  1992/10/28  21:30:57  jd
 * 	Fixed a typo. cma_reinitsignal was spelled cma_reinit_sigal in its
 * 	prototype resulting in compiler warnings.
 * 	[1992/10/28  21:30:28  jd]
 * 
 * Revision 1.1.2.3  1992/09/29  20:15:31  devsrc
 * 	[OT 5373]    SNI/SVR4 merge.
 * 	[1992/09/17  20:51:20  sekhar]
 * 
 * Revision 1.1.2.2  1992/09/03  14:40:02  bolinger
 * 	Replace current source file with equivalent from DEC BL10+
 * 	source base, as originally integrated in the
 * 	nosupport/threads_bl10 tree.  (See OT defect 5300.)
 * 	[1992/09/02  14:06:05  bolinger]
 * 
 * Revision 1.1.2.2  1992/05/08  23:51:52  bolinger
 * 	BL10 CMA sources from DEC.
 * 	[1992/05/08  23:51:39  bolinger]
 * 
 * Revision 1.1  1992/01/19  14:39:26  devrcs
 * 	Initial revision
 * 
 * $EndLog$
 */
/*
 *	%W%	(ULTRIX/OSF)	%G%
 */
/*
 *  Copyright (c) 1991 by
 *  Digital Equipment Corporation, Maynard Massachusetts.
 *  All rights reserved.
 *
 *  This software is furnished under a license and may be used and  copied
 *  only  in  accordance  with  the  terms  of  such  license and with the
 *  inclusion of the above copyright notice.  This software or  any  other
 *  copies  thereof may not be provided or otherwise made available to any
 *  other person.  No title to and ownership of  the  software  is  hereby
 *  transferred.
 *
 *  The information in this software is subject to change  without  notice
 *  and  should  not  be  construed  as  a commitment by DIGITAL Equipment
 *  Corporation.
 *
 *  DIGITAL assumes no responsibility for the use or  reliability  of  its
 *  software on equipment which is not supplied by DIGITAL.
 */

/*
 *  FACILITY:
 *
 *	CMA services
 *
 *  ABSTRACT:
 *
 *	Header file for signal operations
 *
 *  AUTHORS:
 *
 *	Dave Butenhof
 *
 *  CREATION DATE:
 *
 *	23 May 1991
 *
 *  MODIFICATION HISTORY:
 *
 *	001	Paul Curtin	3 June 1991
 *		Added a prototype for new reinit routine.
 *	002	Webb Scales	7 April 1991
 *		Set up for building on VMS.
 */

#ifndef CMA_SIGNAL
#define CMA_SIGNAL

/*
 *  INCLUDE FILES
 */

#include <cma_tcb_defs.h>

/*
 * CONSTANTS AND MACROS
 */

/*
 *  TYPE DEFINITIONS
 */

/*
 *  GLOBAL DATA
 */

/*
 * EXTERNAL INTERFACES
 */

extern void cma__abort_process  (cma_t_integer);

extern int cma_sigaction (int,struct sigaction *,struct sigaction *);

extern void cma__init_signal  (void);

extern void cma__reinit_signal  (cma_t_integer);

extern cma_t_boolean cma__sig_deliver (int,int,	struct sigcontext *);

#endif
/*  DEC/CMS REPLACEMENT HISTORY, Element CMA_SIGNAL.H */
/*  *6    16-APR-1992 18:11:05 SCALES "Set up for building on VMS" */
/*  *5    10-JUN-1991 19:56:14 SCALES "Convert to stream format for ULTRIX build" */
/*  *4    10-JUN-1991 19:21:37 BUTENHOF "Fix the sccs headers" */
/*  *3    10-JUN-1991 18:23:38 SCALES "Add sccs headers for Ultrix" */
/*  *2     5-JUN-1991 16:14:28 CURTIN "fork work" */
/*  *1    29-MAY-1991 17:51:27 BUTENHOF "signals" */
/*  DEC/CMS REPLACEMENT HISTORY, Element CMA_SIGNAL.H */
