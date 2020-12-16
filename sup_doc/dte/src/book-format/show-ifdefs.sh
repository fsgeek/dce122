#!/bin/sh
#
# Copyright 1991,1992,1993 Open Software Foundation, Inc.,
# Cambridge, Massachusetts
# All rights reserved.
#
#
# @OSF_FREE_COPYRIGHT@
# 
# HISTORY
# $Log: show-ifdefs.sh,v $
# Revision 1.1.2.5  1994/06/23  19:49:23  fred
# 	free copyright
# 	[1994/06/23  19:44:43  fred]
#
# Revision 1.1.2.4  1994/06/23  18:38:11  fred
# 	free copyright
# 	[1994/06/22  15:30:46  fred]
# 
# Revision 1.1.2.3  1993/04/10  01:03:36  bowe
# 	Add OSF copyright.
# 	[1993/04/10  01:01:03  bowe]
# 
# Revision 1.1.2.2  1992/07/07  14:52:54  bowe
# 	Initial rev.
# 	[1992/07/07  14:49:05  bowe]
# 
# $EndLog$
#
#  $Header: /u1/rcs/dte/book-format/show-ifdefs.sh,v 1.1.2.5 1994/06/23 19:49:23 fred Exp $
#
#  Short program to embolden #ifdef keywords (for troff).
#  Input from stdin, output to stdout.

awk '
BEGIN { p=0 }
/^#if|^#else|^#endif/ {
    printf(".sp .3\n.B \"%s\"\n.sp .3\n",$0);
    p=1
}
{
    if (p==0) print $0;
    p=0
}
'

