/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1994, 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
 * the full copyright text.
 * 
 */
/*
 * HISTORY
 * $Log: dirent.h,v $
 * Revision 1.1.6.2  1996/02/18  23:32:16  marty
 * 	Update OSF copyright years
 * 	[1996/02/18  22:19:41  marty]
 *
 * Revision 1.1.6.1  1995/12/08  21:28:25  root
 * 	Submit OSF/DCE 1.2.1
 * 	[1995/12/08  18:00:21  root]
 * 
 * Revision 1.1.4.1  1994/06/09  16:03:20  devsrc
 * 	cr10892 - fix copyright
 * 	[1994/06/09  15:48:53  devsrc]
 * 
 * Revision 1.1.2.1  1993/12/12  01:38:04  rousseau
 * 	Initial 7.3 version.
 * 	[1993/12/12  01:37:46  rousseau]
 * 
 * $EndLog$
 */
/*
 * dirent.h --
 *
 *	This file is a replacement for <dirent.h> in systems that
 *	support the old BSD-style <sys/dir.h> with a "struct direct".
 *
 * Copyright (c) 1991 The Regents of the University of California.
 * All rights reserved.
 *
 * Permission is hereby granted, without written agreement and without
 * license or royalty fees, to use, copy, modify, and distribute this
 * software and its documentation for any purpose, provided that the
 * above copyright notice and the following two paragraphs appear in
 * all copies of this software.
 * 
 * IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
 * OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE UNIVERSITY OF
 * CALIFORNIA HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATION TO
 * PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
 *
 * $Header: /u0/rcs_trees/dce/rcs/admin/tcl7.3/compat/dirent.h,v 1.1.6.2 1996/02/18 23:32:16 marty Exp $ SPRITE (Berkeley)
 */

#ifndef _DIRENT
#define _DIRENT

#include <sys/dir.h>

#define dirent direct

#endif /* _DIRENT */
