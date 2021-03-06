/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE in the
 * src directory for the full copyright text.
 */
/*
 * HISTORY
 * $Log: nidltest.h,v $
 * Revision 1.1.4.2  1996/02/18  23:06:27  marty
 * 	Update OSF copyright years
 * 	[1996/02/18  22:26:44  marty]
 *
 * Revision 1.1.4.1  1995/12/11  20:06:44  root
 * 	Submit OSF/DCE 1.2.1
 * 	[1995/12/11  19:43:48  root]
 * 
 * Revision 1.1.2.3  1993/01/25  18:05:50  bbelch
 * 	Fix duplicate log
 * 	[1993/01/25  17:38:19  bbelch]
 * 
 * Revision 1.1.2.2  1993/01/11  23:36:34  bbelch
 * 	Embedding copyright notice
 * 	[1993/01/06  18:08:47  bbelch]
 * 
 * Revision 1.1  1992/01/19  03:35:44  devrcs
 * 	Initial revision
 * 
 * $EndLog$
 */
/*
#
#
# Copyright (c) 1991 by
#    Hewlett-Packard Company, Palo Alto, Ca.
#
# Permission to use, copy, modify, and distribute this
# software and its documentation for any purpose and without
# fee is hereby granted, provided that the above copyright
# notice appear in all copies and that both that copyright
# notice and this permission notice appear in supporting
# documentation, and that the name of Hewlett-Packard Company not
# be used in advertising or publicity pertaining to distribution
# of the software without specific, written prior permission.
# Hewlett-Packard Company makes no representations about the
# suitability of this software for any purpose.  It is provided
# "as is" without express or implied warranty.
#
#
# DCE API Test
#
*/



#include <dce/nbase.h>

#ifdef vms
#  define index strchr
#endif

#ifdef MSDOS
#   define DISCARD(x) (void)(x)
#else
#   define DISCARD(x) x
#endif

extern char *error_text();

globalref uuid_t uuid_nil;
globalref uuid_t nidltest_type, nidltest_obj;


