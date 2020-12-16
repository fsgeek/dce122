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
# $Log: sync-h1-man.sh,v $
# Revision 1.1.2.5  1994/06/23  19:49:25  fred
# 	free copyright
# 	[1994/06/23  19:44:49  fred]
#
# Revision 1.1.2.4  1994/06/23  18:38:12  fred
# 	free copyright
# 	[1994/06/22  15:30:53  fred]
# 
# Revision 1.1.2.3  1993/04/10  01:03:37  bowe
# 	Add OSF copyright.
# 	[1993/04/10  01:01:05  bowe]
# 
# Revision 1.1.2.2  1992/07/07  14:53:04  bowe
# 	Initial rev.
# 	[1992/07/07  14:49:12  bowe]
# 
# $EndLog$
#
#  $Header: /u1/rcs/dte/book-format/sync-h1-man.sh,v 1.1.2.5 1994/06/23 19:49:25 fred Exp $
# 
#  sync-h1-man <sync file> <new header file>
#
#  Find the last 1st level heading in the <sync file> and build a -man
#  header file that will make that string be the title of a man page.
#

echo '...\"	-man page specific header info'
echo '...\"'
echo '...\"	get the man page titles right'
echo '...\"'

grep '^!H1:' |
	tail -1 |
		sed -n 's/^!H1:/.ds |D/p' |
			sed -n 's/"$//p'

