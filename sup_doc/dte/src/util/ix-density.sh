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
# $Log: ix-density.sh,v $
# Revision 1.1.2.5  1994/06/24  15:49:31  fred
# 	free copyright
# 	[1994/06/24  15:44:08  fred]
#
# Revision 1.1.2.4  1994/06/23  18:42:43  fred
# 	free copyright
# 	[1994/06/22  20:18:42  fred]
# 
# Revision 1.1.2.3  1993/04/10  00:18:04  bowe
# 	Add OSF copyright.
# 	[1993/04/10  00:17:04  bowe]
# 
# Revision 1.1.2.2  1992/12/03  15:14:11  bowe
# 	Initial revision.
# 	[1992/12/03  15:10:05  bowe]
# 
# $EndLog$
#
# $Header: /u1/rcs/dte/util/ix-density.sh,v 1.1.2.5 1994/06/24 15:49:31 fred Exp $
#
# Index density tool
#
# This tool works in a DTE book directory to determine and show the index
# density of each piece of the book.  To use this tool, first run
# "book-format -all", then run it from the top level of the book directory.
#
# Original by K Flowers.  Enhancements by J Bowe.

# Set some defaults.
Description=Description
Sync=Sync
MakeTbl=0
Help=false
my_name=`basename $0`

# _____________________________________________________________________
# Parse the command line options.
#
while [ $# -gt 0 ] ; do
    case $1 in
        -desc)	shift; Description=$1	;;
        -sync)	shift; Sync=$1		;;
        -tbl)	MakeTbl=1		;;
        -h*)	Help=true		;;
        *)	echo "Bad option: '$1'. Try '$my_name -help'" ; exit 1	;;
    esac
    shift
done

# _____________________________________________________________________
# Print the help message
#
if $Help ; then
cat <<End_Help
Usage: $my_name [-desc file] [-sync directory] [-tbl] [-h]
    -desc  Specifies a description file other than "Description."
    -sync  Specifies a sync directory other than "Sync."
    -tbl   Causes $myname to produce tabular output suitable for
           processing with dmm.
    -h     Prints this help message.

End_Help
    exit
fi

# _____________________________________________________________________
# Get the list of pieces from the Description file and put it
# in the variable Pieceslist.

Pieceslist=`sed -e '/^#/d' -e '/^[ 	]*$/d' -e 's/[ 	].*//' $Description `

# Validate that the book is properly built (i.e. all the pieces are there).

if [ ! -d $Sync ] ; then
    echo "$my_name: $Sync directory missing."
    echo "Please rebuild book with 'book-format -all'."
    exit 1
fi

Piececount=`echo "$Pieceslist" | wc -l`
Synccount=`ls $Sync/d-t.[0-8]?? | wc -l`
Synccount=`expr $Synccount - 1`

if [ $Piececount -ne $Synccount ] ; then
    echo "my_name: $Description file does not match $Sync directory."
    echo "Please rebuild book with 'book-format -all'."
    exit 1
fi

# _____________________________________________________________________
# Now do the work.

(   echo "Piece: Fake"
    for p in $Pieceslist ; do echo "Piece: $p" ; done
    egrep 'INDEX: [123]|SYNC:' $Sync/d-t.??? | sed -e 's/^.*:!//' -e 's/:/ /'
) | awk '
BEGIN {
    npieces = 1
    n = 1
    Prevpages = 0
    Prevchap = 0
    iXentries = 0
    col_fmt="%-20.20s %10s %10s %10s\n"
    if ( MakeTbl ) {
	printf ".PH \"\"\n"
	printf ".PF \"\"\n"
	printf ".TS\n"
	printf "box,tab(@);\n"
	printf "lb s   s   s\n"
	printf "lb lbe lbe lbe\n"
	printf "lb lbe lbe lbe\n"
	printf "l  le  le  le.\n"
	printf "Index Density for %s\n", pwd
	printf "_\n"
	printf "@@Index@Index\n"
	printf "Piece@Pages@Entries@Density\n"
	printf "="
    }
    else {
	printf "\n    Index Density for %s\n\n", pwd
	printf col_fmt, "", "# OF", "INDEX", "INDEX"
	printf col_fmt, "PART NAME", "PAGES", "ENTRIES", "DENSITY"
    }
}
/^Piece/ {
    pieces[npieces] = $2
    npieces = npieces + 1
    next
}
/INDEX/ {
    iXentries = iXentries + 1
    next
}
/SYNC/ {
    # see if it is the 1st ("fake") piece
    if ( n <= 1 ) {
	n = n + 1
	next
    }
    gsub("\"", "")
    Syncchap = $3
    Syncpages = $2
    if ( Prevchap == Syncchap ) Realpages = Syncpages - Prevpages + 1
    else Realpages = Syncpages
    Prevpages  = Syncpages
    Prevchap   = Syncchap
    Pagestotal = Pagestotal + Realpages
    iXtotal    = iXtotal + iXentries

    if ( Realpages > 0 ) d = sprintf("%.2f", iXentries/Realpages)
    else d = "N.A."

    if ( MakeTbl )
	printf "%s@%s@%s@%s\n",  pieces[n], Realpages, iXentries, d
    else
	printf col_fmt, pieces[n], Realpages, iXentries, d

    iXentries = 0
    n = n + 1
    next
}
{
    printf "HUH??\t%s\n", $0
}
END {
    if ( Pagestotal > 0 ) d = sprintf("%.2f", iXtotal/Pagestotal)
    else d = "N.A."
    if ( MakeTbl )
	printf "%s@%s@%s@%s\n", "Total", Pagestotal, iXtotal, d
    else {
	printf "\n"
	printf col_fmt, "TOTAL", Pagestotal, iXtotal, d
    }
}
' MakeTbl=$MakeTbl pwd=`pwd`

