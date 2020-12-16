/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1994 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
 * the full copyright text.
 */
/*
 * HISTORY
 * $Log: dacl_debug.c,v $
 * Revision 1.1.436.1  1996/10/02  18:15:16  damon
 * 	Newest DFS from Transarc
 * 	[1996/10/01  18:46:28  damon]
 *
 * Revision 1.1.431.4  1994/08/23  18:58:54  rsarbo
 * 	DFS/delegation changes
 * 	[1994/08/23  16:09:21  rsarbo]
 * 
 * Revision 1.1.431.3  1994/07/13  22:26:04  devsrc
 * 	merged with bl-10
 * 	[1994/06/28  21:10:59  devsrc]
 * 
 * 	Changed #include with double quotes to #include with angle brackets.
 * 	[1994/04/28  16:01:09  mbs]
 * 
 * Revision 1.1.431.2  1994/06/09  14:18:31  annie
 * 	fixed copyright in src/file
 * 	[1994/06/09  13:30:33  annie]
 * 
 * Revision 1.1.431.1  1994/02/04  20:28:21  devsrc
 * 	Merged from 1.0.3a to 1.1
 * 	[1994/02/04  15:17:18  devsrc]
 * 
 * Revision 1.1.429.1  1993/12/07  17:32:34  jaffe
 * 	1.0.3a update from Transarc
 * 	[1993/12/03  16:44:24  jaffe]
 * 
 * Revision 1.1.3.3  1993/01/21  15:16:46  cjd
 * 	embedded copyright notice
 * 	[1993/01/20  15:52:59  cjd]
 * 
 * Revision 1.1.3.2  1992/11/24  18:27:45  bolinger
 * 	Change include file install directory from .../afs to .../dcedfs.
 * 	[1992/11/22  19:20:10  bolinger]
 * 
 * Revision 1.1  1992/01/19  02:52:43  devrcs
 * 	Initial revision
 * 
 * $EndLog$
 */
/*
*/
/*
 *	dacl_debug.c -- the debugging flag for the dacl package
 *
 * Copyright (C) 1991 Transarc Corporation
 * All rights reserved.
 */

#include <dcedfs/param.h>
#include <dcedfs/stds.h>
#include <dcedfs/icl.h>

#ifndef KERNEL
#include <pthread.h>
#endif /* !KERNEL */

#include <dacl_debug.h>

RCSID("$Header: /u0/rcs_trees/dce/rcs/file/security/dacl/dacl_debug.c,v 1.1.436.1 1996/10/02 18:15:16 damon Exp $")

long int dacl_debug_flag = 0x0;

EXPORT struct icl_set *dacl_iclSetp = (struct icl_set *)0;

EXPORT void dacl_LogParamError(routineNameP, paramNameP, logCondition, filenameP, line)
     char *	routineNameP;
     char *	paramNameP;
     int	logCondition;
     char *	filenameP;
     int	line;
{
  if (logCondition != 0) {
    osi_printf("%s: Error: required pointer parameter, %s, has NULL value",
	       (routineNameP != (char *)NULL) ? routineNameP : "(unknown routine)",
	       (paramNameP != (char *)NULL) ? paramNameP : "(unknown parameter)");
    osi_printf("\t%s, %d\n", filenameP, line);
  }
}

EXPORT int dacl_InitTracingPackage()
{
    struct icl_log *logp;
    int code;

#ifdef KERNEL
    code = icl_CreateLog("cmfx", 0, &logp);
#else
    code = icl_CreateLog("common", 0, &logp);
#endif

    if (code == 0) {
	code = icl_CreateSetWithFlags("dacl", logp, (struct icl_log *) 0,
				      ICL_CRSET_FLAG_DEFAULT_OFF,
				      &dacl_iclSetp);
    }

    return code;
}
