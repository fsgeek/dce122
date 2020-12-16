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
# $Log: sync-h1-mm.sh,v $
# Revision 1.1.2.5  1994/06/23  19:49:27  fred
# 	free copyright
# 	[1994/06/23  19:45:18  fred]
#
# Revision 1.1.2.4  1994/06/23  18:38:14  fred
# 	free copyright
# 	[1994/06/22  15:31:01  fred]
# 
# Revision 1.1.2.3  1993/04/10  01:03:38  bowe
# 	Add OSF copyright.
# 	[1993/04/10  01:01:08  bowe]
# 
# Revision 1.1.2.2  1992/07/07  14:53:14  bowe
# 	Initial rev.
# 	[1992/07/07  14:49:15  bowe]
# 
# $EndLog$
#
#  $Header: /u1/rcs/dte/book-format/sync-h1-mm.sh,v 1.1.2.5 1994/06/23 19:49:27 fred Exp $
#
#  sync-h1-mm sync-file new-header-file
#
#  Generates a new-header-file containing a PH for the last H 1 from sync-file.
#

echo '...\"	-mm page specific header info'
echo '...\"'

grep '^!H1:' |
	tail -1 |
		sed -n 's/^!H1: "/.ds !!/p' |
			sed -n 's/"$//p'
