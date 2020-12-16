/*
 * @OSF_FREE_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1992, 1991, 1990  
 * Open Software Foundation, Inc. 
 *  
 * Permission is hereby granted to use, copy, modify and freely distribute 
 * the software in this file and its documentation for any purpose without 
 * fee, provided that the above copyright notice appears in all copies and 
 * that both the copyright notice and this permission notice appear in 
 * supporting documentation.  Further, provided that the name of Open 
 * Software Foundation, Inc. ("OSF") not be used in advertising or 
 * publicity pertaining to distribution of the software without prior 
 * written permission from OSF.  OSF makes no representations about the 
 * suitability of this software for any purpose.  It is provided "as is" 
 * without express or implied warranty. 
 */
/*
 * HISTORY
 * $Log: lstFindFrom.c,v $
 * Revision 1.2.2.3  1992/12/03  19:06:10  damon
 * 	ODE 2.2 CR 346. Expanded copyright
 * 	[1992/12/03  18:35:46  damon]
 *
 * Revision 1.2.2.2  1992/09/24  19:25:27  gm
 * 	CR286: Major improvements to make internals.
 * 	[1992/09/24  17:57:11  gm]
 * 
 * Revision 1.2  1991/12/05  20:43:37  devrcs
 * 	Changes for Reno make
 * 	[91/03/22  16:04:40  mckeen]
 * 
 * $EndLog$
 */
/*
 * Copyright (c) 1988, 1989, 1990 The Regents of the University of California.
 * All rights reserved.
 *
 * This code is derived from software contributed to Berkeley by
 * Adam de Boor.
 *
 * Redistribution and use in source and binary forms are permitted
 * provided that: (1) source distributions retain this entire copyright
 * notice and comment, and (2) distributions including binaries display
 * the following acknowledgement:  ``This product includes software
 * developed by the University of California, Berkeley and its contributors''
 * in the documentation or other materials provided with the distribution
 * and in all advertising materials mentioning features or use of this
 * software. Neither the name of the University nor the names of its
 * contributors may be used to endorse or promote products derived
 * from this software without specific prior written permission.
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 */

#ifndef lint
static char sccsid[] = "@(#)lstFindFrom.c	5.3 (Berkeley) 6/1/90";
#endif /* not lint */

/*-
 * LstFindFrom.c --
 *	Find a node on a list from a given starting point. Used by Lst_Find.
 */

#include	"lstInt.h"

/*-
 *-----------------------------------------------------------------------
 * Lst_FindFrom --
 *	Search for a node starting and ending with the given one on the
 *	given list using the passed datum and comparison function to
 *	determine when it has been found.
 *
 * Results:
 *	The found node or NILLNODE
 *
 * Side Effects:
 *	None.
 *
 *-----------------------------------------------------------------------
 */
LstNode
Lst_FindFrom (
    Lst		      	l,
    register LstNode    ln,
    register ClientData d,
    register int	(*cProc)(ClientData, ClientData))
{
    register ListNode	tln;
    
    if (Lst_IsEmpty (l))
	return (NILLNODE);
    
    tln = (ListNode)ln;
    while (tln != NilListNode) {
	if ((*cProc) (tln->datum, d) == 0)
	    return(tln);
	tln = tln->nextPtr;
    }
    
    return (NILLNODE);
}
