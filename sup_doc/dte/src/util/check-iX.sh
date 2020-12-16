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
# $Log: check-iX.sh,v $
# Revision 1.1.2.6  1994/06/24  15:49:20  fred
# 	free copyright
# 	[1994/06/24  15:43:52  fred]
#
# Revision 1.1.2.5  1994/06/23  18:42:33  fred
# 	free copyright
# 	[1994/06/22  20:18:02  fred]
# 
# Revision 1.1.2.4  1993/05/18  12:51:26  bowe
# 	Use "nawk" instead of "gawk".
# 	[1993/05/18  12:50:30  bowe]
# 
# Revision 1.1.2.3  1993/04/10  00:17:57  bowe
# 	Add OSF copyright.
# 	[1993/04/10  00:16:42  bowe]
# 
# Revision 1.1.2.2  1992/07/07  13:45:29  bowe
# 	Initial rev.
# 	[1992/07/07  13:44:09  bowe]
# 
# $EndLog$
#
#  $Header: /u1/rcs/dte/util/check-iX.sh,v 1.1.2.6 1994/06/24 15:49:20 fred Exp $
#
#  Program to check validity of index markup for SML.
#  Checks for:
#	Mismatched quotes (", not ').
#	Too many arguments (where each arg is quoted).
#	Uses of .IX instead if .iX
#	Easily lets you check a list of files or all the files in a book (uses
#	    Description file)
#
# ____________________________________________________________________________

verbose=false
do_help=false
cmd=`basename $0`
do_book=false
desc_file=Description
tmp=/tmp/iXchk$$

trap 'rm -f $tmp $tmpf; exit $?' 0 1 2 3 15

# ____________________________________________________________________________

while [ $# -gt 0 ] ; do
    case "$1" in
	-v)		verbose=true	;;
	-book)		do_book=true	;;
	-help)		do_help=true	;;
	-desc*)		shift; desc_file=$1	;;
	-*)		echo "Illegal option: $1.  Ignored."	;;
	*)		files="$files $1"	;;
    esac
    shift
done

if $do_help ; then
    cat << E_O_F
Usage: $cmd [-v] [-help] [-book] [-desc file] [file ...]

The $cmd command will check the validity of SML index markup and
point out problems.

Options:
    -book	Assume the current directory is a book; use Description
		file for list of files to check.
    -desc file	Use <file> as Description file [default is './Description']
    -v		Verbose mode.  Print more messages.
    file	List of files to check.  If omitted and not doing -book,
		stdin is used.
    -help	Print this help message.

E_O_F
    exit 0
fi

# ____________________________________________________________________________

if $do_book ; then
    # get list of files for each piece of book
    if $verbose ; then
	echo "Finding list of files for book pieces from $desc_file."
    fi
    sed -e '/^$/d' -e '/^#/d' -e 's/[ 	][ 	]*/ /g' \
	-e '/[ 	]ptx[ 	]/d' -e '/[ 	]mptx[ 	]/d' \
	-e 's/APPENDIX//' -e 's/UNNUMBERED//' -e 's/PREFACE//' \
	-e 's/FRONT//' -e 's/SGREF//'  $desc_file |
    		while read pname type stuff ; do
	files=`eval echo $stuff`
	echo $pname $files
    done > $tmp
else
    # think of this as a book with one piece - all the files on cmd line
    if [ -z "$files" ] ; then
	files="$tmpf"
	cat - > $tmpf
    fi
    echo fake $files > $tmp
fi

# ____________________________________________________________________________

if $verbose ; then Verbose=1 ; else Verbose=0 ; fi

cat $tmp | while read pname files ; do

    if $verbose ; then if $do_book ; then echo "Piece: $pname" ; fi ; fi
    for f in $files ; do
	if $verbose ; then echo "Checking file: $f" ; fi
	nawk -v file=$FILE -v verbose=$Verbose '
BEGIN {
    n_iX=0
    n_bad_iX=0
}
/^\.iX/ {
    n_iX++
    s=$0
    lev=0
    open=0
    while ( index(s, "\"") ) {
	open=1
	sub("\"", "", s)
	if ( index(s, "\"") ) {
	    sub("\"", "@@CLOSE@@", s)
	    open=0
	}
	lev++
    }
    if (open) {
	n_bad_iX++
	printf "%s: %d: mismatched quotes in iX macro args\n\t%s\n", \
		FILENAME, FNR, $0
    }
    else if (lev > 3) {
	n_bad_iX++
	printf "%s: %d: too many args (%d) to iX macro\n\t%s\n", \
		FILENAME, FNR, lev, $0
    }
    else {
	sub("^\.*@@CLOSE@@ *", "", s)
	n=gsub("[^ 	][^ 	]*", "", s)
	lev+=n
	if (lev > 3) {
	    n_bad_iX++
	    printf "%s: %d: too many args (%d) to iX macro\n\t%s\n", \
		    FILENAME, FNR, lev, $0
	}
    }
}
/^\.IX/ {
    n_bad_iX++
    printf "%s: %d: bad index markup - IX should be iX\n\t%s\n", \
	FILENAME, FNR, $0
}
END {
    if (verbose)
	printf "%s: %d index entries, %d bad\n", \
	    FILENAME, n_iX, n_bad_iX
}

' $f
    done
    if $verbose ; then if $do_book ; then echo "" ; fi ; fi
done

