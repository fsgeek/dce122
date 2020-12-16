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
# $Log: make-ptx.sh,v $
# Revision 1.1.2.5  1994/06/23  19:49:07  fred
# 	free copyright
# 	[1994/06/23  19:43:43  fred]
#
# Revision 1.1.2.4  1994/06/23  18:37:55  fred
# 	free copyright
# 	[1994/06/22  15:29:58  fred]
# 
# Revision 1.1.2.3  1993/04/10  01:03:25  bowe
# 	Add OSF copyright.
# 	[1993/04/10  01:00:45  bowe]
# 
# Revision 1.1.2.2  1992/07/07  14:52:40  bowe
# 	Initial rev.
# 	[1992/07/07  14:48:52  bowe]
# 
# $EndLog$
#
#  $Header: /u1/rcs/dte/book-format/make-ptx.sh,v 1.1.2.5 1994/06/23 19:49:07 fred Exp $
#
#  make-ptx.sh -- generate permuted indexes from a list of manpages
#
#  Generates output that should be sent to troff with -mptx
#  Depends on defines being passed in environment variable
#  "defines" (set in fmt-piece).

if [ -z "$PTX" ] ; then PTX=ptx ; fi

for i in $* ; do

    # derive the last column of the permuted index (the name(sec#) part)
    # from the TH line, not the filename.

    # the "top" portion - the .TH line and stuff between .SH NAME / .SH whatever
    top="`rmifdef $defines $i | sed -n -e 's/^\.TH/TH/p' -e '/^\.[^S][^H]/d' \
	-e 's/\\\\\*(..//g' -e 's/\\\\\*.//g' \
	-e 's/ *\\\\*-/:/' -e 's/\\\\f.//g' \
	-e '/^\.SH "*NAME"*/,/^\.SH/p'`"

    n=`echo "$top"|sed -n -e 's/\\\&//' -e 's/^\.*TH //p'`
    if echo "$n" | egrep '^"' >/dev/null ; then
	n1=`echo $n | sed -e 's/^"//' -e 's/".*$//'`
	n2=`echo $n | sed -e "s/$n1//" -e 's/""//g' -e 's/ //g' \
		-e 's/^"//' -e 's/".*$//'`
	name="$n1($n2)"
    else
	name=`echo $n | sed -e 's/\([^ ]*\) \([^ ]*\).*/\1(\2)/' -e 's/"//g'`
    fi

    echo "$top" | awk '
		BEGIN { s=""; }
		/^TH/ { next }
		/^\./ { next }
		/REVIEW NOTE/ { next }
		{ s=s" "$0; }
		END { printf "%s\n", s }
	' | $PTX | sed -e "s,\$, \"$name\","
done | sort -f -t\" +4.1

