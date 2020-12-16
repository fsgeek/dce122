/* ______________________________________________________________________ */
/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1993, 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE in the
 * src directory for the full copyright text.
 */
/*
 * HISTORY
 * $Log: bt_stack.c,v $
 * Revision 1.1.4.2  1996/02/18  19:20:51  marty
 * 	Update OSF copyright years
 * 	[1996/02/18  18:06:06  marty]
 *
 * Revision 1.1.4.1  1995/12/08  17:37:36  root
 * 	Submit OSF/DCE 1.2.1
 * 	[1995/12/08  17:17:24  root]
 * 
 * Revision 1.1.2.1  1993/12/01  22:30:09  bowe
 * 	Initial checkin.
 * 	[1993/12/01  16:54:39  bowe]
 * 
 * $EndLog$
 */
/* ______________________________________________________________________ */

/*-
 * Copyright (c) 1990, 1993
 *	The Regents of the University of California.  All rights reserved.
 *
 * This code is derived from software contributed to Berkeley by
 * Mike Olson.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *	This product includes software developed by the University of
 *	California, Berkeley and its contributors.
 * 4. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

#if defined(LIBC_SCCS) && !defined(lint)
static char sccsid[] = "@(#)bt_stack.c	8.1 (Berkeley) 6/4/93";
#endif /* LIBC_SCCS and not lint */

#include <sys/types.h>

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>

#include <db.h>
#include "btree.h"

/*
 * When a page splits, a new record has to be inserted into its parent page.
 * This page may have to split as well, all the way up to the root.  Since
 * parent pointers in each page would be expensive, we maintain a stack of
 * parent pages as we descend the tree.
 *
 * XXX
 * This is a concurrency problem -- if user a builds a stack, then user b
 * splits the tree, then user a tries to split the tree, there's a new level
 * in the tree that user a doesn't know about.
 */

/*
 * __BT_PUSH -- Push parent page info onto the stack (LIFO).
 *
 * Parameters:
 *	t:	tree
 *	pgno:	page
 *	index:	page index
 *
 * Returns:
 * 	RET_ERROR, RET_SUCCESS
 */
int
__bt_push(t, pgno, index)
	BTREE *t;
	pgno_t pgno;
	int index;
{
	if (t->bt_sp == t->bt_maxstack) {
		t->bt_maxstack += 50;
		if ((t->bt_stack = realloc(t->bt_stack,
		    t->bt_maxstack * sizeof(EPGNO))) == NULL) {
			t->bt_maxstack -= 50;
			return (RET_ERROR);
		}
	}

	t->bt_stack[t->bt_sp].pgno = pgno;
	t->bt_stack[t->bt_sp].index = index;
	++t->bt_sp;
	return (RET_SUCCESS);
}
