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
# $Log: check-oSoE.sh,v $
# Revision 1.1.2.6  1994/06/24  15:49:25  fred
# 	free copyright
# 	[1994/06/24  15:43:58  fred]
#
# Revision 1.1.2.5  1994/06/23  18:42:37  fred
# 	free copyright
# 	[1994/06/22  20:18:19  fred]
# 
# Revision 1.1.2.4  1993/05/18  12:51:29  bowe
# 	Use "nawk" instead of "gawk".
# 	[1993/05/18  12:50:43  bowe]
# 
# Revision 1.1.2.3  1993/04/10  00:17:59  bowe
# 	Add OSF copyright.
# 	[1993/04/10  00:16:50  bowe]
# 
# Revision 1.1.2.2  1992/07/07  13:45:38  bowe
# 	Initial rev.
# 	[1992/07/07  13:44:18  bowe]
# 
# $EndLog$
#
#  $Header: /u1/rcs/dte/util/check-oSoE.sh,v 1.1.2.6 1994/06/24 15:49:25 fred Exp $
#
#  Program to check validity of oS/oE regions.  Some features:
#	Checks for lines longer than max length.
#	Checks for too many lines in region.
#	Shows line number of start of offending region.
#	In "verbose" mode, shows you your regions, how many long they are,
#	    where they start (line #), and the length of the longest line.
#	Easily lets you check a list of files or all the files in a book (uses
#	    Description file)
#
# ____________________________________________________________________________

draftmax=72
pubmax=62
draftmax_left=78
pubmax_left=74

do_help=false
verbose=false
cmd=`basename $0`
do_book=false
do_ifdef=false
desc_file=Description
MAXLENGTH=$pubmax
MAXLENGTH_LEFT=$pubmax_left
MAXLINES=100

tmp=/tmp/oSoEchk.$$
tmpf=/tmp/stdin.$$

trap 'rm -f $tmp $tmpf; exit $?' 0 1 2 3 15

while [ $# -gt 0 ] ; do
    case "$1" in
	-v)		verbose=true	;;
	-book)		do_book=true	;;
	-help)		do_help=true	;;
	-desc*)		shift ; desc_file=$1	;;
	-len*)		shift ; MAXLENGTH=$1 ; MAXLENGTH_LEFT=$1	;;
	-line*)		shift ; MAXLINES=$1	;;
	-draft)		MAXLENGTH=$draftmax ; MAXLENGTH_LEFT=$draftmax_left ;;
	-pub*)		MAXLENGTH=$pubmax ; MAXLENGTH_LEFT=$pubmax_left	;;
	-*)		echo "Illegal option: $1.  Ignored."	;;
	*)		files="$files $1"	;;
    esac
    shift
done

if $do_help ; then
    cat << E_O_F
Usage: $cmd [-v] [-help] [-book] [-desc file] [file ...]

The $cmd command will check the validity of oS/oE regions and
point out problems.

Options:
    -v		Verbose mode.  Print more messages [shows where oS/oE starts
		and ends, number if lines in oS/oE, etc.].
    -len N	Set max line length allowable in region [default: $MAXLENGTH]
    -lines N	Set max lines allowable in one region [default: $MAXLINES]
    -book	Assume the current directory is a book; use Description
		file for list of files to check.
    -desc file	Use <file> as Description file [default is './Description']
    -draft	Set number of lines appropriate for draft style.
    -pub	Set number of lines appropriate for publish style. [default]
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
    ( sed -e '/^$/d' -e '/^#/d' -e 's/[ 	][ 	]*/ /g' $desc_file |
    		while read pname type stuff ; do
	eval `echo $stuff | nawk '
	    BEGIN { ff="" }
	    {
		for (fld=1; fld<=NF; fld++) {
		    if ($fld != "APPENDIX" && $fld != "UNNUMBERED" && \
		    $fld != "PREFACE" && $fld != "FRONT" && $fld != "SGREF" ) {
			ff=ff" "$fld;
		    }
		}
	    }
	    END { printf("files=\"%s\"\n", ff); }'`
	echo $pname $files
    done ) > $tmp
else
    # think of this as a book with one piece - all the files on cmd line
    if [ -z "$files" ] ; then
	files="-"
	files="$tmpf"
	cat - > $tmpf
    fi
    echo fake $files > $tmp
fi

# ____________________________________________________________________________

if $verbose ; then Verbose=1 ; else Verbose=0 ; fi
export Verbose		# to pass into to awk...
export MAXLENGTH MAXLENGTH_LEFT MAXLINES

cat $tmp | while read pname files ; do

    if $verbose ; then if $do_book ; then echo "Piece: $pname" ; fi ; fi
    for f in $files ; do
	if $verbose ; then echo "Checking file: $f" ; fi

	FILE="$f" ; export FILE

	sed -e 's/\\\*.//g' -e 's/\\e/\\/g' $f | awk '
BEGIN {
    file="'$FILE'"
    verbose="'$Verbose'"
    lic=0;	# lines in this chunk
    lenmax1=int("'$MAXLENGTH'");
    lenmax2=int("'$MAXLENGTH_LEFT'");
    licmax=int("'$MAXLINES'");
    noS=0;
    inoS=0;
    longest=0
    reported=0
}
/^\.oS/ {
    if (inoS == 1) {
	printf "%s: Nested oS/oE region not allowed, starting at line %d.\n", \
		file, NR
    }
    if (iniS == 1) {
	printf "%s: You can not nest an oS within an iS, line %d\n", file, NR
    }
    inoS=1;
    oSstart=NR;
    if (NF > 1) lenmax=lenmax2
    else lenmax=lenmax1
    reported=0
}
/^\.oE/ {
    if (lic > licmax)
	printf "%s: Too many lines in one oS/oE (%d), from line %d to %d\n", \
		file, lic, oSstart, NR
    if (verbose == 1)
	printf "%s: %d lines in oS/oE region starting at %d, longest: %d\n", \
		file, lic, oSstart, longest
    if (inoS == 0) {
	printf "%s: You ended an oS without being in one, line %d\n", file, NR
    }
    inoS=0;
    noSs=noSs+1;
    lic=0;
    longest=0
}
/^\.iS/ {
    iniS=1;
    if (inoS == 1) {
	printf "%s: You can not nest an iS within an oS, line %d\n", file, NR
    }
}
/^\.iE/ {
    if (iniS == 0) {
	printf "%s: You ended an iS without being in one, line %d\n", file, NR
    }
    if (inoS == 1 && iniS == 0) {
	inoS=0;
	printf "%s: You ended an oS with an iE, line %d\n", file, NR
    }
    iniS=0;
}
{
    if (inoS == 0) next;
    l=length($0);
    if (l > longest) longest=l
    if (l > lenmax) {
	if (reported == 0) {
	    printf "%s: Line(s) too long (line %d, %d chars; max is %d):\n", \
		file, NR, l, lenmax
	    printf "|"
	    for (i=1; i<(lenmax-1); i++) printf "-"
	    printf "|\n"
	    reported=1
	}
	printf "%s\n", $0
    }
    lic=lic+1;
}
END {
    if (noSs > 0 && verbose == 1)
	printf "%s: %d oS/oE regions in file\n", file, noSs
}
'

    done
done

