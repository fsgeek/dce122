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
# $Log: add-cutmark.sh,v $
# Revision 1.1.2.5  1994/06/24  15:49:16  fred
# 	free copyright
# 	[1994/06/24  15:43:46  fred]
#
# Revision 1.1.2.4  1994/06/23  18:42:29  fred
# 	free copyright
# 	[1994/06/22  20:17:46  fred]
# 
# Revision 1.1.2.3  1993/04/10  00:17:54  bowe
# 	Add OSF copyright.
# 	[1993/04/10  00:15:31  bowe]
# 
# Revision 1.1.2.2  1992/07/07  19:37:27  bowe
# 	Initial rev.
# 	[1992/07/07  19:36:51  bowe]
# 
# $EndLog$
#
#  $Header: /u1/rcs/dte/util/add-cutmark.sh,v 1.1.2.5 1994/06/24 15:49:16 fred Exp $
#
#  Shell program to scale and add cut marks to PS (EPS) file produced
#  by Elan's troff/eps.  Tries to avoid doing it again if it has already
#  been done to the file.
#
#  J.Bowe, June 1991  (K.Flowers did the original PS part)

scale="0.82"
width="7.97"
height="10.84"
edit=false
verbose=false
help=false
cookie="% CutMarks Added"

files=""

while [ $# -gt 0 ] ; do
    case "$1" in
	-edit)	edit=true		;;
	-scale)	shift ; scale="$1"	;;
	-w)	shift ; width="$1"	;;
	-h)	shift ; height="$1"	;;
	-v)	verbose=true		;;
	-help)	help=true		;;
	*)	files="$files $1"	;;
    esac
    shift
done

if $help ; then
    cmd=`basename $0`
    cat <<E-O-F
Usage: $cmd [ -scale <scale> ] [ file ... ]
    This will scale and add cut marks to PostScript files created with
    Elan's eps program.  This aids in production.  By default, output
    is sent to stdout.

Options:
    -edit	edit the files on the command line.
		[ default is to send to stdout ]
    -scale S	set scale to S  [ default 0.82 ]
    -help	print this help message
Examples:
    $cmd file1.ps file2.ps | lpr
    $cmd -edit *.ps
E-O-F
    exit 0
fi

stmp=/tmp/sed-$$.cut
ptmp=/tmp/ps-$$.cut

trap "rm -f $stmp ; exit $?" 0 1 2 3 4 15

c="$cookie by $USER, `date`"
cat >$stmp <<E-O-F
1a\\
$c
/0.2400 dup scale/{
a\\
$scale $scale scale
n
a\\
% ------------------------\\
300 300 translate\\
/cutmarks {\\
% bottom left\\
-.53 inch .5 inch sub -.53 inch moveto\\
-.53 inch .25 inch sub -.53 inch lineto\\
-.53 inch -.53 inch .5 inch sub moveto\\
-.53 inch -.53 inch .25 inch sub lineto\\
% bottom right\\
$width inch .5 inch add -.53 inch moveto\\
$width inch .25 inch add -.53 inch lineto\\
$width inch -.53 inch .5 inch sub moveto\\
$width inch -.53 inch .25 inch sub lineto\\
% top left\\
-.53 inch .5 inch sub $height inch moveto\\
-.53 inch .25 inch sub $height inch lineto\\
-.53 inch $height inch .5 inch add moveto\\
-.53 inch $height inch .25 inch add lineto\\
% top right\\
$width inch .5 inch add $height inch moveto\\
$width inch .25 inch add $height inch lineto\\
$width inch $height inch .5 inch add moveto\\
$width inch $height inch .25 inch add lineto\\
stroke } def\\
/*showpage /showpage load def\\
/showpage { cutmarks *showpage } def\\
% ------------------------
b done
}
: done
/./{
n
b done
}
E-O-F

if [ -z "$files" -o "$files" = "-" ] ; then
    cat $f | sed -f $stmp
else
    for f in $files ; do
	if $verbose ; then echo "Processing $f" >&2 ; fi
	c=`egrep "$cookie by" $f`
	if [ -n "$c" ] ; then
	    echo "Cutmarks have already been added:"
	    echo "    $c"
	else
	    if $edit ; then
		sed -f $stmp $f > $ptmp
		mv $ptmp $f
	    else
		sed -f $stmp $f
	    fi
	fi
    done
fi

