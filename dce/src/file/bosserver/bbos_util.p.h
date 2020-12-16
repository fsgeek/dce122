/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1994 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
 * the full copyright text.
 */
/*
 * HISTORY
 * $Log: bbos_util.p.h,v $
 * Revision 1.1.10.1  1996/10/02  17:04:18  damon
 * 	Newest DFS from Transarc
 * 	[1996/10/01  18:04:51  damon]
 *
 * Revision 1.1.4.1  1994/06/09  13:52:13  annie
 * 	fixed copyright in src/file
 * 	[1994/06/08  21:25:53  annie]
 * 
 * Revision 1.1.2.5  1993/01/18  19:55:42  cjd
 * 	Embedded copyright notice
 * 	[1993/01/18  19:31:48  cjd]
 * 
 * Revision 1.1.2.4  1992/11/24  15:40:38  bolinger
 * 	Change include file install directory from .../afs to .../dcedfs.
 * 	[1992/11/22  16:08:37  bolinger]
 * 
 * Revision 1.1.2.3  1992/09/25  18:02:24  jaffe
 * 	Transarc delta: bab-ot5033-bos-bosserver-adminlist-wo-names 1.2
 * 	  Selected comments:
 * 	    The bosserver/bos command should allow the creation/deletion of admin
 * 	    lists, even if no names are given as part of the bos command.
 * 	    ot 5033
 * 	    Added symbolic constants and macro tests for "no type" and "no name" that
 * 	    can be used by both the bosserver and the bos command to send RPCs to
 * 	    the bosserver to get admin lists created/deleted w/o also sending real
 * 	    names to the server.
 * 	    In cases in which the createlist/removelist flag is used w/o specifying
 * 	    and principals or groups, the bosserver will return an error if the
 * 	    list already exists/is not empty.
 * 	[1992/09/23  18:33:44  jaffe]
 * 
 * Revision 1.1.2.2  1992/08/31  18:24:28  jaffe
 * 	Transarc delta: bab-ot4386-bosserver-child-signals-not-rcvd 1.2
 * 	  Selected comments:
 * 	    This delta reverses part of delta dstokes-ot2171-remove-cma-calls,
 * 	    since that delta broke the bosserver.  The bosserver was no longer
 * 	    seeing any SIGCHLD signals when sigwait was used in place
 * 	    of cma_sigwait, so the call to cma_sigwait was restored.
 * 	    ot 4386
 * 	    It turns out that the name of this delta is more than a bit of a
 * 	    misnomer, but the symptoms were that killed children were not being
 * 	    restarted.  It turns out that there is some sort of optimizer bug that
 * 	    was tickled by the way the error handling structures were manipulated in
 * 	    bossvr_thread_bnodeTimeout.c.  To work around this, the cleanup structures
 * 	    were changed, as was the way they were used.
 * 	    I also cleaned up some of the copious ifdefs.
 * 	    See above.
 * 	[1992/08/28  20:48:30  jaffe]
 * 
 * Revision 1.1  1992/01/19  02:49:13  devrcs
 * 	Initial revision
 * 
 * $EndLog$
 */
/*
 *  bbos_util.p.h -- declarations and prototypes for utility routines used in
 * bosserver implementation
 *
 *
 *	Copyright (C) 1994, 1991, 1990 Transarc Corporation
 *	All rights reserved.
 */


#ifndef TRANSARC_BOS_BOSUTIL_H
#define TRANSARC_BOS_BOSUTIL_H

#include <dcedfs/param.h>
#include <dcedfs/stds.h>
#include <dce/dce.h>

/* these should move into a global header file */
typedef struct cleanupArg {
  char		threadName[124];
  char 		msg[512];
  int		releaseLockFlag;
} cleanupArg_t;

#define BOSSVR_NO_RELEASE_GLOBAL_LOCK	0
#define BOSSVR_RELEASE_GLOBAL_LOCK	1

IMPORT char * bosutil_DateOf _TAKES((
				     long atime
				   ));

IMPORT long bosutil_GetPartitionID _TAKES((
					   char * name
					 ));
IMPORT char * bosutil_GetPartitionName _TAKES((
					       long partIndex
					     ));
IMPORT char * HostErrorString _TAKES((
				      int	hostError
				    ));
IMPORT char * bosutil_em _TAKES((
				 long	acode
			       ));
IMPORT void bosutil_ComputeDestDir _TAKES((
					   char *	aname,
					   char *	adir,
					   char *	aresult,
					   long		alen
					 ));

#define BBOS_NO_TYPE	((unsigned char *)"")
#define BBOS_NO_NAME	((unsigned char *)"")
#define BBOS_IS_NO_TYPE(typeP) (strcmp((char *)(typeP), (char *)BBOS_NO_TYPE) == 0)
#define BBOS_IS_NO_NAME(nameP) (strcmp((char *)(nameP), (char *)BBOS_NO_NAME) == 0)

#endif /* TRANSARC_BOS_BOSUTIL_H */
