/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE in the
 * src directory for the full copyright text.
 */
/*
 * HISTORY
 * $Log: proc3.4.c,v $
 * Revision 1.1.8.1  1996/10/17  18:16:47  damon
 * 	Submitting on behalf of Transarc
 * 	[1996/10/17  16:49:24  damon]
 *
 * Revision 1.1.2.3  1993/01/11  17:37:59  htf
 * 	Embedded copyright notice
 * 	[1993/01/11  16:54:37  htf]
 * 
 * Revision 1.1.2.2  1992/11/24  21:44:33  bolinger
 * 	Change include file install directory from .../afs to .../dcedfs.
 * 	[1992/11/22  19:44:11  bolinger]
 * 
 * Revision 1.1  1992/01/19  03:18:13  devrcs
 * 	Initial revision
 * 
 * $EndLog$
 */
/*
*/
/*
 *  test3.4.c -- A procedure that generates exceptions
 *
 *
 *	Copyright (C) 1991, 1990 Transarc Corporation
 *	All rights reserved.
 */

#include <dcedfs/param.h>
#include <dcedfs/stds.h>

RCSID("$Header: /u0/rcs_trees/dce/rcs/test/file/bos/tests/procs/proc3.4.c,v 1.1.8.1 1996/10/17 18:16:47 damon Exp $")

#include <stdio.h>

  /* Exception raised: Stack overflow */

void stupid()

{
    /* infinitely recursive */
    stupid();

}


int 
main(argc, argv)
     int	argc;
     char *	argv[];
{
    /* Check stack overflow */

    stupid();

}


