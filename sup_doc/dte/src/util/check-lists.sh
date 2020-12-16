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
# $Log: check-lists.sh,v $
# Revision 1.1.2.6  1994/06/24  15:49:22  fred
# 	free copyright
# 	[1994/06/24  15:43:55  fred]
#
# Revision 1.1.2.5  1994/06/23  18:42:35  fred
# 	free copyright
# 	[1994/06/22  20:18:10  fred]
# 
# Revision 1.1.2.4  1993/05/18  12:51:28  bowe
# 	Use "nawk" instead of "gawk".
# 	[1993/05/18  12:50:37  bowe]
# 
# Revision 1.1.2.3  1993/04/10  00:17:58  bowe
# 	Add OSF copyright.
# 	[1993/04/10  00:16:46  bowe]
# 
# Revision 1.1.2.2  1992/07/07  13:45:34  bowe
# 	Initial rev.
# 	[1992/07/07  13:44:14  bowe]
# 
# $EndLog$
#
#  $Header: /u1/rcs/dte/util/check-lists.sh,v 1.1.2.6 1994/06/24 15:49:22 fred Exp $
#
#  Program to check validity of lists for SML.  Some features:
#	Checks for missing .LE (list ends)
#	Checks for .LI without being in a list (yes, people are doing this)
#	Shows line number of start of offending list.
#	In "verbose" mode, shows you your lists, how many items are in them,
#	    where they start (line number), and where they end.
#	Allows -B1 and -C2 for security games.
#	Easily lets you check a list of files or all the files in a book (uses
#	    Description file)
#
# ____________________________________________________________________________

verbose=false
do_help=false
cmd=`basename $0`
do_book=false
do_ifdef=false
desc_file=Description
tmp=/tmp/lstchk.$$
tmpf=/tmp/stdin.$$
C2DEF="-DSEC_BASE -DSEC_ACL -DSEC_ACL_SWARE -DSEC_ARCH -DSEC_FSCHANGE \
  -DSEC_ROLE_X -DSEC_ROLE_ASCII"
B1DEF="-DSEC_BASE -DSEC_ACL -DSEC_ACL_SWARE -DSEC_ARCH -DSEC_FSCHANGE \
  -DSEC_ROLE_X -DSEC_ROLE_ASCII -DSEC_MAC -DSEC_TERMINAL -DSEC_PRIV"

trap 'rm -f $tmp $tmpf; exit $?' 0 1 2 3 15
# ____________________________________________________________________________

while [ $# -gt 0 ] ; do
    case "$1" in
	-v)		verbose=true	;;
	-book)		do_book=true	;;
	-help)		do_help=true	;;
	-if*)		do_ifdef=true	;;
	-desc*)		shift ; desc_file=$1	;;
	-B1 | -b1)	sec=B1 ; do_ifdef=true	;;
	-C2 | -c2)	sec=C2 ; do_ifdef=true	;;
	-*)		echo "Illegal option: $1.  Ignored."	;;
	*)		files="$files $1"	;;
    esac
    shift
done

if $do_help ; then
    cat << E_O_F
Usage: $cmd [-v] [-help] [-book] [-desc file] [-B1] [-C2] [file ...]

The $cmd command will check the validity of SML lists and
point out problems.

Options:
    -v		Verbose mode.  Print more messages [shows where lists start
		and end, number if items in list, etc.].
    -book	Assume the current directory is a book; use Description
		file for list of files to check.
    -ifdef	Process #ifdef's [default is no #ifdef processing]
    -B1		Define macros for B1 security and process #define's. 
    -C2		Define macros for C2 security and process #define's.
    -desc file	Use <file> as Description file [default is './Description']
    file	List of files to check.  If omitted and not doing -book,
		stdin is used.
    -help	Print this help message.

E_O_F
    exit 0
fi

# ____________________________________________________________________________

#  if doing security stuff, set appropriate variables
if [ "$sec" = "B1" ] ; then
    defines="$B1DEF"
elif [ "$sec" = "C2" ] ; then
    defines="$C2DEF"
else
    defines="-Dnothing"
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

if $do_ifdef ; then ifdf="rmifdef $defines" ; else ifdf="" ; fi

if $verbose ; then Verbose=1 ; else Verbose=0 ; fi

cat $tmp | while read pname files ; do

    if $verbose ; then if $do_book ; then echo "Piece: $pname" ; fi ; fi
    for f in $files ; do
	if $verbose ; then echo "Checking file: $f" ; fi
	FILE="$f"
	cat $f | (if $do_ifdef ; then rmifdef $defines ; else cat ; fi) | \
	    nawk -v file=$FILE -v verbose=$Verbose '
BEGIN {
    list_level=0;
}
/^\.[ABDMV]L/ {
    list_level++
    lists[list_level]=$1
    lineno[list_level]=NR
    items[list_level]=0
    next
}
/^\.LE/ {
    if (list_level > 0 && verbose == 1)
	printf "  %s from lines %d to %d OK, %d items\n", lists[list_level],
		lineno[list_level], NR, items[list_level]
    list_level--
    if (list_level < 0) {
	printf "%s, line %d: You ended a list without being in one.\n", file,NR
	list_level=0
    }
    next
}
/^\.LI/ {
    if (list_level == 0) {
	printf "%s, line %d: You specified a .LI without being in a list.\n",
		file, NR
    }
    else { items[list_level]++ }
    next
}
/^\.SH|^\.TH|^\.SS/ {
    if (list_level > 0) {
      printf "%s: You started a .SH (line %d) while in list (%s at line %d)\n",
		file, NR, lists[list_level], lineno[list_level]
    }
}
END {
    if (list_level) {
	printf "%s: You have missing .LE (%d deep)\n", file,list_level
	if (verbose)
	    for (i=1; i<=list_level; i++)
		printf "%s: list starts at line %d: %s.\n", \
			file, lineno[i],lists[i]
    }
}
'
    done
    if $verbose ; then if $do_book ; then echo "" ; fi ; fi
done

