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
# $Log: rmboxes.sh,v $
# Revision 1.1.2.5  1994/06/23  19:49:15  fred
# 	free copyright
# 	[1994/06/23  19:44:14  fred]
#
# Revision 1.1.2.4  1994/06/23  18:38:03  fred
# 	free copyright
# 	[1994/06/22  15:30:18  fred]
# 
# Revision 1.1.2.3  1993/04/10  01:03:31  bowe
# 	Add OSF copyright.
# 	[1993/04/10  01:00:54  bowe]
# 
# Revision 1.1.2.2  1992/07/07  14:52:50  bowe
# 	Initial rev.
# 	[1992/07/07  14:49:00  bowe]
# 
# $EndLog$
# 
# $Header: /u1/rcs/dte/book-format/rmboxes.sh,v 1.1.2.5 1994/06/23 19:49:15 fred Exp $
#
#  rmboxes
#
#  This filter removes the tbl options box, doublebox, and allbox from tbl
#  source so tables display better with nroff on a terminal screen.

sed -e '/^\.TS/,/.\./{
s/doublebox//g
s/allbox//g
s/box//g
s/, *, */,/g
s/ *, *;/;/g
s/^ *, *//g
s/|/ /g
}' $*

