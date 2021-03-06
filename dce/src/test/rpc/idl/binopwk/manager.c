/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE in the
 * src directory for the full copyright text.
 */
/*
 * HISTORY
 * $Log: manager.c,v $
 * Revision 1.1.4.2  1996/02/17  23:12:55  marty
 * 	Update OSF copyright year
 * 	[1996/02/17  22:34:00  marty]
 *
 * Revision 1.1.4.1  1995/12/11  19:58:37  root
 * 	Submit OSF/DCE 1.2.1
 * 	[1995/12/11  19:28:58  root]
 * 
 * Revision 1.1.2.2  1993/01/07  19:09:03  bbelch
 * 	Embedding copyright notice
 * 	[1993/01/06  13:28:21  bbelch]
 * 
 * Revision 1.1  1992/01/19  03:29:35  devrcs
 * 	Initial revision
 * 
 * $EndLog$
 */
/*
*/
#include <binopwk.h>
#include <test_common.h>

static void binopwk_add_(h, a, b, c)
handle_t h;
ndr_long_int a, b, *c;
{
    *c = a + b;
}

globaldef binopwk_v0_0_epv_t binopwk_v0_0_m_epv = {binopwk_add_};
