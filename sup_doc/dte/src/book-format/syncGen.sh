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
# $Log: syncGen.sh,v $
# Revision 1.1.2.6  1994/06/23  19:49:29  fred
# 	free copyright
# 	[1994/06/23  19:45:23  fred]
#
# Revision 1.1.2.5  1994/06/23  18:38:16  fred
# 	free copyright
# 	[1994/06/22  15:31:06  fred]
# 
# Revision 1.1.2.4  1993/04/10  01:03:41  bowe
# 	Add OSF copyright.
# 	[1993/04/10  01:01:11  bowe]
# 
# Revision 1.1.2.3  1992/12/07  16:09:16  bowe
# 	Added leading space to things echo'ed.  This is because osf1's sh (and
# 	hence builtin echo) now does POSIX interpretation of arguments.
# 	[1992/12/07  16:08:42  bowe]
# 
# Revision 1.1.2.2  1992/07/07  14:53:26  bowe
# 	Initial rev.
# 	[1992/07/07  14:49:19  bowe]
# 
# $EndLog$
#
#  $Header: /u1/rcs/dte/book-format/syncGen.sh,v 1.1.2.6 1994/06/23 19:49:29 fred Exp $
#
#  synopsis: syncGen 
#
#  Assumes that the synchronizer macro outputs:
#
#	!SYNC: <page> <h1> <h2> <h3> <h4> <fig> <tab>
#
#  Generates nroff/troff command line register settings to set
#
#	@	page
#	!	H 1
#	#	H 2
#	$	H 3
#	^	H 4
#	_	current figure number
#	=	current table number
#

syncOpts=`tail -1 $1 |
	sed -n 's/^!SYNC: "\(.*\)" "\(.*\)" "\(.*\)" "\(.*\)" "\(.*\)" "\(.*\)" "\(.*\)"$/-r@\1 -r!\2 -r#\3 -r$\4 -r^\5 -r_\6 -r=\7/p'`

if [ "$syncOpts" = "" ]
	then echo " -r@99 -r!99 -r#99 -r$99 -r^99 -r_99 -r=99"
	else echo " $syncOpts"
fi

