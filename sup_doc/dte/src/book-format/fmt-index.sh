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
# $Log: fmt-index.sh,v $
# Revision 1.1.2.7  1994/06/23  19:48:44  fred
# 	free copyright
# 	[1994/06/23  19:42:44  fred]
#
# Revision 1.1.2.6  1994/06/23  18:37:36  fred
# 	free copyright
# 	[1994/06/22  15:29:02  fred]
# 
# Revision 1.1.2.5  1993/04/10  01:03:12  bowe
# 	Add OSF copyright.
# 	[1993/04/10  01:00:24  bowe]
# 
# Revision 1.1.2.4  1992/12/10  18:37:46  fred
# 	various changes to implement the new master index
# 	[1992/12/10  18:35:53  fred]
# 
# Revision 1.1.2.3  1992/11/11  20:45:45  bowe
# 	Changed screen of symbols to find all chars that are NOT "A-Za-z0-9"
# 	instead of finding the ones IN a specified list.  (symbols are not
# 	together in ascii order...)
# 	[1992/11/11  20:45:24  bowe]
# 
# Revision 1.1.2.2  1992/07/07  14:52:00  bowe
# 	Initial rev.
# 	[1992/07/07  14:48:31  bowe]
# 
# $EndLog$
#
#  $Header: /u1/rcs/dte/book-format/fmt-index.sh,v 1.1.2.7 1994/06/23 19:48:44 fred Exp $
#
#  fmt-index -- format an index from info gleaned from sync files
#  Called from book-format.

# set some defaults
Formatter=-t
Form=pub
Style=p
nopost=false
indexName=index
descFile=Description
MIdescFile=MI.Description
MIndexFlag=
MIformatFlags='-r\;0'
doMIndex=false
verbose=false
PREP=""
doPrintOrder=false

while test $# != 0 ; do
    case $1 in
	-n)	Formatter=-n ;;
	-t)	Formatter=-t ;;
	-x)	Formatter=-x ;;

	-d)	Form=draft
		Style=d
		;;
	-p)	Form=pub
		Style=p
		;;
	
	-prep)	PREP=$2
		shift
		;;

	-des*)	descFile=$2
		shift
		;;

	-out*)	OUTPUT_DIR=$2
		shift
		;;

	-libdir | -root)
		DTE_LIBDIR=$2
		shift
		;;

	-v)	verbose=true
		;;

	-h*)	
		echo "usage: $0 [-n|-t|-x] [-d|-p] [-Ttypesetter] [-desc DescriptFile] [-out OutputDir] [-libdir LibDir] [-prep <file>] [-help]"
		exit 0
		;;

	-T*)	TYPESETTER=`echo $1 | sed "s/-T//"`
		nopost=true
		;;

	-printorder)	doPrintOrder=true ;;

	-D*)	;;
	master)	doMIndex=true
		descFile=$MIdescFile
		MIndexFlag=-m
		MIformatFlags='-r\;1'
		indexName=master-index
		if [ ! -r Headers/header.mm ]
	 		then echo "Can't find Headers/header.mm"
	 		     exit 2
	 	fi
		;;
    esac
    shift
done

if [ -z "$TROFF" ]	; then TROFF=troff ; fi
if [ -z "$NROFF" ]	; then NROFF=nroff ; fi
if [ -z "$TYPESETTER" ]	; then TYPESETTER=ps ; fi
if [ -z "$SYNC_DIR" ]	; then SYNC_DIR="Sync" ; fi

Macros=$DTE_LIBDIR/macros

# be tolerant of fonts loaded into the wrong place

if [ ! -d /usr/lib/font/dev$TYPESETTER -a -d /usr/local/lib/font ]; then
    LIB="-F/usr/local/lib/font"
else
    LIB=""
fi
if [ -z "$DTE_OUTFILTER" ] ; then DTE_OUTFILTER="eps $LIB" ; fi

if [ "$Form" = "draft" ]
	then macs="$macs $Macros/draft.mac"
fi

macs="$macs Headers/header.mm $Macros/$Form-hdr.mm $Macros/$Form-mmt+.mm"

if egrep '^##.*PARTS' $descFile >/dev/null ; then
    macs="$macs $Macros/parts.sml"
fi

macs="$macs $Macros/headfoot.mm $Macros/index-pre.mm"

if egrep '^##.*INDEXINTRO' $descFile >/dev/null ; then
    macs="$macs `sed -n 's/^##.*INDEXINTRO *//p' $descFile`"
fi

macs="$macs - $Macros/index-post.mm"

if $doPrintOrder ; then Pc="999." ; fi

if [ "X$Formatter" = "X-n" ]; then
    formatter="$NROFF -Tlp -mm $MIformatFlags $nroffOptions $macs"
    outFile=$OUTPUT_DIR/${Pc}${indexName}
    outFilter="col > $outFile"

elif [ "X$Formatter" = "X-t" ]; then
    formatter="$TROFF -T$TYPESETTER $LIB -mm $MIformatFlags $troffOptions $macs"
    outFile=$OUTPUT_DIR/${Pc}${indexName}.$TYPESETTER
    if `$nopost`
	then outFilter="cat > $outFile"
	else outFilter="$DTE_OUTFILTER > $outFile"
    fi

elif [ "X$Formatter" = "X-x" ]; then
    formatter="$TROFF -Tps $LIB -mm $MIformatFlags $troffOptions $macs"
    outFile=$OUTPUT_DIR/${Pc}${indexName}.x
    outFilter="cat $LIB > $outFile"
    Formatter=-t
fi

##############################################################################

echo ""
if $doMIndex ; then
	echo "formatting master index"
else
	echo "formatting index"
fi

rm -f $outFile

(if $doMIndex ; then
    cat $MIdescFile |
	while read line
	do
	    if echo $line | egrep '^#' > /dev/null ; then
		true
	    elif echo $line | egrep '^[ 	]*$' > /dev/null ; then
		true
	    else
		FILES="`echo $line | sed \"s:\([^,]*\),.*:\1/Sync/$Style$Formatter.???:\"`"
		BOOKN="`echo $line | sed 's/[^,]*,\(.*\)/\1/'`"
		ls $FILES | sed "s/\$/,\\\\fI$BOOKN\\\\fR/"
	    fi
	done
 else
	syncFile=$Style$Formatter
	ls $SYNC_DIR/$syncFile.???

 fi) |
    fmt-index-trim $MIndexFlag |
	indpresort $PREP |
	    sort -f |
		uniq |
		    indpostsort |
			eval "$formatter" |
			    eval "$outFilter"


# finally, add an entry to the TOC--

if $doMIndex ; then
    true
else
    echo "!TOC: .)T 1 1 \"\h'|0i'\" Index Index-1" > $SYNC_DIR/$Style$Formatter.999
fi
