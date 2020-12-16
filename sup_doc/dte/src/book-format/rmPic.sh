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
# $Log: rmPic.sh,v $
# Revision 1.1.2.5  1994/06/23  19:49:13  fred
# 	free copyright
# 	[1994/06/23  19:44:09  fred]
#
# Revision 1.1.2.4  1994/06/23  18:38:01  fred
# 	free copyright
# 	[1994/06/22  15:30:13  fred]
# 
# Revision 1.1.2.3  1993/04/10  01:03:29  bowe
# 	Add OSF copyright.
# 	[1993/04/10  01:00:52  bowe]
# 
# Revision 1.1.2.2  1992/07/07  14:52:45  bowe
# 	Initial rev.
# 	[1992/07/07  14:48:56  bowe]
# 
# $EndLog$
#
#  $Header: /u1/rcs/dte/book-format/rmPic.sh,v 1.1.2.5 1994/06/23 19:49:13 fred Exp $
#
#  Remove PS...PE sequences from files formatted with nroff.
#  This is because pic does not work well with nroff.


sed "/^\.PS/,/^\.PE/c\\
.sp 1\\
.ce 1\\
***** PIC image removed here *****\\
.sp 1"
