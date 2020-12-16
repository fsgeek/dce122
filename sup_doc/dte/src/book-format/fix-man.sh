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
# $Log: fix-man.sh,v $
# Revision 1.1.2.7  1994/06/23  19:48:36  fred
# 	free copyright
# 	[1994/06/23  19:42:22  fred]
#
# Revision 1.1.2.6  1994/06/23  18:37:28  fred
# 	free copyright
# 	[1994/06/22  15:28:35  fred]
# 
# Revision 1.1.2.5  1993/04/10  01:03:05  bowe
# 	Add OSF copyright.
# 	[1993/04/10  01:00:13  bowe]
# 
# Revision 1.1.2.4  1992/08/10  20:22:52  bowe
# 	Get rid of \*L markup in NAME section.  DTE CR 397.
# 	[1992/08/10  20:22:21  bowe]
# 
# Revision 1.1.2.3  1992/08/07  15:01:01  bowe
# 	Allos quotes around "NAME".
# 	[1992/08/07  15:00:33  bowe]
# 
# Revision 1.1.2.2  1992/07/07  14:51:46  bowe
# 	Initial rev.
# 	[1992/07/07  14:48:23  bowe]
# 
# $EndLog$
#
# $Header: /u1/rcs/dte/book-format/fix-man.sh,v 1.1.2.7 1994/06/23 19:48:36 fred Exp $
# 
#  Fuss with the formatting of certain manpages.

FTMP=/tmp/FxNm$$
trap "rm -f $FTMP /tmp/fix$$; exit $?" 0 1 2 3 4 5 6 7 8 10 12 13 14 15 16 17 19

# _______________________________

#  I could not get all this to work without writing it to a temp file
#  and telling sed to read that file.  - J.Bowe

#sed -f $FIXNAME > /tmp/fix$$
cat > $FTMP << 'END_FIXNAME_SED'
/^\.SH "NAME"/s/"//g
/^\.SH NAME/ {
n
/^\.PP/ {
s/^\.PP$/...\\".PP/
n
}
/^\\f[BP]$/ n
s/\\f[BPRI]//g
s/\\\*L//g
s/\.*$//
s/\(.*\) -- a/.tS "\1"\
.SH PURPOSE\
A/
s/\(.*\) - a/.tS "\1"\
.SH PURPOSE\
A/
s/\(.*\) \\- a/.tS "\1"\
.SH PURPOSE\
A/
s/\(.*\) \\(em a/.tS "\1"\
.SH PURPOSE\
A/
s/\(.*\) -- the/.tS "\1"\
.SH PURPOSE\
The/
s/\(.*\) - the/.tS "\1"\
.SH PURPOSE\
The/
s/\(.*\) \\- the/.tS "\1"\
.SH PURPOSE\
The/
s/\(.*\) \\(em the/.tS "\1"\
.SH PURPOSE\
The/
s/\(.*\) -- /.tS "\1"\
.SH PURPOSE\
/
s/\(.*\) - /.tS "\1"\
.SH PURPOSE\
/
s/\(.*\) \\- /.tS "\1"\
.SH PURPOSE\
/
s/\(.*\) \\(em /.tS "\1"\
.SH PURPOSE\
/
}
s/^Name	Class	Type	Default	Access/_\
Name	Default	Access\
\\ \\ \\ \\ \\ \\ Class	\\ \\ \\ \\ \\ \\ Type\
_/g
/Name	Default	Access/,/^\.TE/{
s/^\([^	]*\)	\([^	]*\)	\([^	]*\)	\([^	]*\)	\([^	]*\)/\1	\4	\5\
\\ \\ \\ \\ \\ \\ \2	\\ \\ \\ \\ \\ \\ \\ \3\
_/g
}
s/^lBp8 lBp8 lBp8 lBp8 lBp8$/lB lB lB\
lB lB lB/g
s/^lp8 lp8 lp8 lp8 lp8/l l l/g
s/^cBp9 ssss$/CB ss/g
s/^center allbox/center box/g
s/^\.tH/\.TE\
\.bp\
\.TS\
center box;\
lB lB lB\
lB lB lB\
l l l\.\
Name	Default	Access\
\\ \\ \\ \\ \\ \\ Class	\\ \\ \\ \\ \\ \\ Type\
_\
_/g
END_FIXNAME_SED
sed -f $FTMP > /tmp/fix$$

# _______________________________

ex - /tmp/fix$$ << E_N_D
g/^Name Default Access$/-7s/^center allbox;/center box;/
g/^\.TE/-2s/^_//
g/^\.TE/-1s/^_//
wq
E_N_D

# _______________________________

sed -e '
/^Name  Default Access$/,/\.TE/{
/^$/d
}' /tmp/fix$$

