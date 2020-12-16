#!/bin/sh
#
# Copyright 1991,1992,1993 Open Software Foundation, Inc.,
# Cambridge, Massachusetts
# All rights reserved.
#
# @OSF_FREE_COPYRIGHT@
#
# 
# HISTORY
# $Log: print-eps.sh,v $
# Revision 1.1.2.5  1994/06/24  15:49:32  fred
# 	free copyright
# 	[1994/06/24  15:44:11  fred]
#
# Revision 1.1.2.4  1994/06/23  18:42:45  fred
# 	free copyright
# 	[1994/06/22  20:18:50  fred]
# 
# Revision 1.1.2.3  1993/04/10  00:18:05  bowe
# 	Add OSF copyright.
# 	[1993/04/10  00:17:08  bowe]
# 
# Revision 1.1.2.2  1992/07/07  19:37:32  bowe
# 	Initial rev.
# 	[1992/07/07  19:36:55  bowe]
# 
# $EndLog$
# 
# $Header: /u1/rcs/dte/util/print-eps.sh,v 1.1.2.5 1994/06/24 15:49:32 fred Exp $
#
#  This make an EPS file "printable" - moves it away from the lower-left
#  corner and adds the file name.  The results are sent to stdout.
#  Often the EPS file will be the output of some window dump program,
#  such as "xwd | whatever2ps"; these are lower-left oriented.
#
#  Puts the following text after %%EndProlog:
#	gsave
#	  /Times-Roman findfont 12 scalefont setfont
#	  72 72 moveto (<filename>) show
#	grestore
#	72 144 translate
#

help=false
files=""
xoff="1"
yoff="1"

while [ $# -gt 0 ] ; do
    case "$1" in
	-xoff*)		shift ; xoff="$1"		;;
	-yoff*)		shift ; yoff="$1"		;;
	-off*)		shift ; xoff="$1"; yoff="$1"	;;
	-help)		help=true			;;
	*)		files="$files $1"		;;
    esac
    shift
done

if $help ; then
    cmd=`basename $0`
    cat << E-O-F
Usage: $cmd file ...
    This make an EPS figure "printable" - it moves the figure away from
    the corner and adds the file name.  Useful for window dumps.  The
    results are sent to stdout.  Multiple input files will be sent to
    the output stream.  Use "-" for file name to read stdin.
Options:
    -xoff X	offset in X direction by X inches [ default 1 inch ]
    -yoff Y	offset in Y direction by Y inches [ default 1 inch ]
    -help	print this help message
Examples:
    $cmd file1.ps file2.ps > /tmp/PS-files
    $cmd figures/*.ps | lpr
E-O-F
    exit 0
fi

for file in $files ; do

    cat $file | sed "
    /%%EndComments/a\\
    gsave\\
    /Times-Roman findfont 12 scalefont setfont\\
    $xoff 72 mul $yoff 72 mul moveto ($file) show\\
    grestore\\
    $xoff 72 mul $yoff .5 add 72 mul translate"

done

