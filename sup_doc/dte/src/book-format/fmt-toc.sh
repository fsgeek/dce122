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
# $Log: fmt-toc.sh,v $
# Revision 1.1.2.6  1994/06/23  19:48:51  fred
# 	free copyright
# 	[1994/06/23  19:43:04  fred]
#
# Revision 1.1.2.5  1994/06/23  18:37:41  fred
# 	free copyright
# 	[1994/06/22  15:29:16  fred]
# 
# Revision 1.1.2.4  1993/09/08  02:01:10  bowe
# 	Fix for printorder. Don't try to be so smart with piece/file
# 	numbers. (people use FRONT keyword for things other than frontmatter.)
# 	DTE CRs: 428, 443.
# 	[1993/09/08  02:00:40  bowe]
# 
# Revision 1.1.2.3  1993/04/10  01:03:16  bowe
# 	Add OSF copyright.
# 	[1993/04/10  01:00:29  bowe]
# 
# Revision 1.1.2.2  1992/07/07  14:52:20  bowe
# 	Initial rev.
# 	[1992/07/07  14:48:44  bowe]
# 
# $EndLog$
#
# $Header: /u1/rcs/dte/book-format/fmt-toc.sh,v 1.1.2.6 1994/06/23 19:48:51 fred Exp $
#
#  fmt-toc -- format a TOC from the info gleaned from book sync files.
#  Called from book-format.
#

# set some defaults
Formatter=-t
Form=draft
Style=d
nopost=false
descFile=Description
verbose=false
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
	-v)	verbose=true	;;
	-printorder)	doPrintOrder=true ;;

	-h*)	
		echo "usage: $0 [-n|-t|-x] [-d|-p] [-Ttypesetter] [-des DescriptFile] [-out OutputDir] [-libdir LibDir] [-help]"
		exit 0
		;;

	-T*)	TYPESETTER=`echo $1 | sed "s/-T//"`
		nopost=true
		;;

	-D*)	;;
    esac
    shift
done

if [ -z "$TROFF" ]	; then TROFF=troff ; fi
if [ -z "$NROFF" ]	; then NROFF=nroff ; fi
if [ -z "$TYPESETTER" ]	; then TYPESETTER=ps ; fi
if [ -z "$SYNC_DIR" ]	; then SYNC_DIR="Sync" ; fi

Macros=$DTE_LIBDIR/macros

if [ "$Style" = "d" ]; then
    Macs="-mm Headers/header.mm $Macros/draft-hdr.mm $Macros/draft-mmt+.mm \
		$Macros/headfoot.mm $Macros/draft.mac"
else
    Macs="$Macros/mmt $Macros/pub-hdr.mm Headers/header.mm $Macros/pub-mmt+.mm \
		$Macros/headfoot.mm"
fi

# must be last macro file loaded
if egrep '^##.*PARTS' $descFile >/dev/null ; then
    Macs="$Macs $Macros/parts.sml"
fi

# be tolerant of fonts loaded into the wrong place

if [ ! -d /usr/lib/font/dev$TYPESETTER -a -d /usr/local/lib/font ]; then
    LIB="-F/usr/local/lib/font"
else
    LIB=""
fi
if [ -z "$DTE_OUTFILTER" ] ; then DTE_OUTFILTER="eps $LIB" ; fi

if $doPrintOrder ; then
    # Find how many pieces at the beginning are for Front, then add a 't'
    # to that number.  toc will go after that.  Zero is OK.
    Pc=`sed -e '/^#/d' -e '/^$/d' $descFile | awk '
      BEGIN { fr=1 }
      /FRONT/ { if (fr) n=n+1 ; next }
      { fr=0; next }
      END { printf "%03dt.\n",n }'`
fi

if [ "X$Formatter" = "X-n" ]; then
    formatter="$NROFF -Tlp -rN5 $nroffOptions $Macs -"
    outFile=$OUTPUT_DIR/${Pc}toc
    outFilter="col > $outFile"

elif [ "X$Formatter" = "X-t" ]; then
    formatter="$TROFF -T$TYPESETTER $LIB -rN5 $troffOptions -rO.625i $Macs -"
    outFile=$OUTPUT_DIR/${Pc}toc.$TYPESETTER
    if `$nopost` ; then
	outFilter="cat > $outFile"
    else
	outFilter="$DTE_OUTFILTER > $outFile"
    fi

elif [ "X$Formatter" = "X-x" ]; then
    formatter="$TROFF -Tps $LIB -rN5 $troffOptions -rO.625i $Macs -"
    outFile=$OUTPUT_DIR/${Pc}toc.x
    outFilter="cat > $outFile"
    Formatter=-t
fi

echo ""
echo "formatting table of contents"

syncFile=$Style$Formatter
rm -f $SYNC_DIR/toc.$syncFile.not $SYNC_DIR/toc.$syncFile.tab $SYNC_DIR/toc.$syncFile.fig

FILES="$SYNC_DIR/$syncFile.???"

cat $FILES |
    sed -n 's/\!TOC: //p' |
	sed 's//\\ /g' |
	    grep -i '\.)T 1 1 "table' > $SYNC_DIR/toc.$syncFile.tab
		# NOTE: /bin/grep REQUIRES table with -i (NO caps allowed)

cat $FILES |
    sed -n 's/\!TOC: //p' |
	sed 's//\\ /g' |
	    grep -i '\.)T 1 1 "figure' > $SYNC_DIR/toc.$syncFile.fig

cat $FILES |
    sed -n 's/\!TOC: //p' |
	sed 's//\\ /g' |
	    grep -i -v '\.)T 1 1 "table' |
	    # table was TABLE
		grep -i -v '\.)T 1 1 "figure' > $SYNC_DIR/toc.$syncFile.not
		    # figure was Figure

rm -f $outFile
(cat $Macros/toc-pre.mm \
	$SYNC_DIR/toc.$syncFile.not $Macros/toc-middle.mm \
	$SYNC_DIR/toc.$syncFile.tab $SYNC_DIR/toc.$syncFile.fig \
	$Macros/toc-post1.mm
 
    # if not 0 change .nr for TABLES so don't get empty printed page
    if [ -s $SYNC_DIR/toc.$syncFile.tab ]
    then 
	echo '.nr !1 1' 
    fi 

    # if not 0 change .nr for FIGURES so don't get empty printed page
    if [ -s $SYNC_DIR/toc.$syncFile.fig ]
    then 
	echo '.nr !0 1'
    fi 

    cat $Macros/toc-post2.mm ) |
	eval "$formatter" | eval "$outFilter"

