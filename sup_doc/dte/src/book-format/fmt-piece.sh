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
# $Log: fmt-piece.sh,v $
# Revision 1.1.2.6  1994/06/23  19:48:48  fred
# 	free copyright
# 	[1994/06/23  19:42:50  fred]
#
# Revision 1.1.2.5  1994/06/23  18:37:39  fred
# 	free copyright
# 	[1994/06/22  15:29:08  fred]
# 
# Revision 1.1.2.4  1993/09/08  02:01:08  bowe
# 	Fix for printorder. Don't try to be so smart with piece/file
# 	numbers.  DTE CRs: 428, 443.
# 	[1993/09/08  01:59:29  bowe]
# 
# Revision 1.1.2.3  1993/04/10  01:03:14  bowe
# 	Add OSF copyright.
# 	[1993/04/10  01:00:27  bowe]
# 
# Revision 1.1.2.2  1992/07/07  14:52:05  bowe
# 	Initial rev.
# 	[1992/07/07  14:48:35  bowe]
# 
# $EndLog$
#
#  $Header: /u1/rcs/dte/book-format/fmt-piece.sh,v 1.1.2.6 1994/06/23 19:48:48 fred Exp $
#
#  fmt-piece - build a piece of a book.
#  Called from book-format.


# some default settings
doNroff=false
doTroff=false
doExpress=false
Formatter=NONE
Form=NONE
Style=NONE
preProcess=NONE
nopost=false
doSML=false
descFile=Description
defines=""
verbose=false
showifdef=false
xmacs=""
alt_dir=""
doPrintOrder=false

# parse command line

badInit=false

while test $# != 0 ; do
    case $1 in
	-n)	doNroff=true
		Formatter=-n
		;;
	-t)	doTroff=true
		Formatter=-t
		;;
	-x)	doExpress=true
		Formatter=-t
		;;
	-d)	Style=d
		Form=draft
		;;
	-p)	Style=p
		Form=pub
		;;
	-mac)	
		xmacs="$xmacs $2"
		shift
		;;
	-pre)	
		if [ "$preProcess" = "NONE" ]; then
		    preProcess="$2"
		else
		    preProcess="$preProcess | $2"
		fi
		shift
		;;
	-libdir | -root)
		DTE_LIBDIR=$2
		shift
		;;
	-des*)	descFile=$2
		shift
		;;
	-D*)	defines="$defines $1"
		;;
	-alt)   alt_dir=$2
		shift
		;;
	-showif*)
		showifdef=true;;
	-v)	verbose=true;;
	-T*)	TYPESETTER=`echo $1 | sed "s/-T//"`
		nopost=true;;
	-sml)	doSML=true;;
	-nosml)	doSML=false;;
	-printorder)	doPrintOrder=true ;;
	*)	Piece="$1"
		shift
		break
		;;
    esac
    shift
done

if [ " $Formatter" = " NONE" -o "$Form" = "NONE" -o \
	"$Style" = "NONE" -o -z "$Piece" ]; then
	badInit=true
fi

nextPiece=`echo $Piece | awk '{printf "%03d",$1+1}'`
Piece=`echo $Piece | awk '{printf "%03d",$1}'`
masterDoSML=$doSML
Options="$*"

if $badInit ; then
    cat << EOF

synopsis:  build-piece -n|-t|-x -d|-p <piece #> [special-options]

    -n		build for nroff
    -t		build for troff
    -x		build for express

    -d		draft formatting
    -p		publish formatting
    -sml	Build with sml macros
    -nosml	Build without sml macros (default)
    -mac <macs>	include macros <macs> after others

    -showifdef	embolden and offset #ifdef/#else/#endif
    -D<symbol>	define <symbol> and filter thru rmifdef

    -out <dir>	Set directory for output to <dir>
    -des <file>	Specify alternate Description file to <file>
    -libdir <dir> Set root directory of DTE library to <dir>

    -Ttypesetter argument (ps is default)

    <piece #> is which piece of the book to build

EOF
    exit 1
fi

if [ ! -r $descFile ]
	then echo "Can't find book Description file"
		 exit 1
fi

if [ -z "$DTE_LIBDIR" ]
	then echo "ERROR: DTE_LIBDIR not defined"
		exit 2
fi

if [ -z "$TYPESETTER" ] ; then TYPESETTER=ps ; fi

if [ ! -d "$SYNC_DIR" ] ; then mkdir $SYNC_DIR ; fi

if $showifdef ; then
    defines=""
    if [ "$preProcess" = "NONE" ]; then
	preProcess="show-ifdefs"
    else
	preProcess="$preProcess | show-ifdefs"
    fi
fi

# be tolerant of fonts loaded into the wrong place

if [ ! -d /usr/lib/font/dev$TYPESETTER -a -d /usr/local/lib/font ]
	then LIB="-F/usr/local/lib/font"
	else LIB=""
fi

if [ -z "$DTE_OUTFILTER" ] ; then DTE_OUTFILTER="eps $LIB" ; fi

Macros=$DTE_LIBDIR/macros

if $doNroff ; then
    outFilter=col
    outForm=ascii
    ext=""
fi

if $doTroff ; then
    if $nopost
	then outFilter=cat
	else outFilter="$DTE_OUTFILTER"
    fi
    Options="$LIB $Options"
    outForm=$TYPESETTER
    ext=".$TYPESETTER"
fi

if $doExpress ; then
    outFilter=cat
    Options="$LIB $Options"
    outForm=dito
    ext=".x"
fi

syncFile=$Style$Formatter

#	produce synchronized head from the previous piece

echo '!SYNC: "0" "0" "0" "0" "0" "0" "0"' > $SYNC_DIR/$syncFile.001

lastH1=`grep '^\!H1' $SYNC_DIR/$syncFile.$Piece | tail -1`
rm -f $SYNC_DIR/$syncFile.$nextPiece
if [ "$lastH1" != "" ]
	then echo "$lastH1" > $SYNC_DIR/$syncFile.$nextPiece
	else cat /dev/null  > $SYNC_DIR/$syncFile.$nextPiece
fi

lastPART=`grep '^\!PART:' $SYNC_DIR/$syncFile.$Piece | tail -1`
if [ "$lastPART" != "" ]
	then echo "$lastPART" >> $SYNC_DIR/$syncFile.$nextPiece
fi

# get the details of the piece we are to format

#  A bit of a hack here.  Piping a shell expression that expands to > 4K
#  into sed caused problems.  This will expand and sed separately.
#  There still may be a problem if/when we hit the shell cmd line limit
#  (we haven't yet).					-JBowe
eval `sed -e '/^#/d' -e '/^$/d' $descFile | sed -n ${Piece}p | awk '
BEGIN { special=""; ff=""; }
{
    printf("name=%s\nType=%s\n",$1,$2);
    for (fld=3; fld<=NF; fld++) {
	if ($fld == "APPENDIX" || $fld == "PREFACE" || \
		$fld == "FRONT" || $fld == "SGREF" || \
		$fld == "UNNUMBERED") { special=special" "$fld;	}
	else if (substr($fld,0,1) == "<") { ff=ff" \`cat "$fld"\`"; }
	else { ff=ff" "$fld; }
    }
}
END { printf("special=\"%s\"\nff=\"%s\"\n", special,ff); }'`

files=`echo $special | \
    sed -e "s@APPENDIX@$Macros/appendix.mac@" \
	-e "s@PREFACE@$Macros/preface.mac@" \
	-e "s@FRONT@$Macros/front.mac@" \
	-e "s@SGREF@$Macros/sgref.mm@" \
	-e "s@UNNUMBERED@$Macros/unnumbered.mm@" \
	-e "s@GLOSSARY@$Macros/glossary.mm@"`

if [ -n "$alt_dir" ] ; then
#    a="-alt $alt_dir"
    files="$files `expand_fname $ff -alt $alt_dir`"
else
#    a=""
    files="$files $ff"
fi

#files="$files `expand_fname $ff $a`"
#files="$files $ff"			# OLD WAY

if [ "$Type" = "gpsml" ]; then
    type=mm
    doSML=true
elif [ "$Type" = "rsml" ]; then
    type=man
    doSML=true
else
    type=$Type
    doSML=$masterDoSML
fi

# look through description file for special instructions
if egrep '^##.*CHAPTERPART' $descFile >/dev/null ; then
    if [ "$type" = "mm" ] ; then   files="$Macros/chappart.sml $files" ; fi
fi
if egrep '^##.*PARTS' $descFile >/dev/null ; then
    parts="$Macros/parts.sml"
else
    parts=""
fi
if egrep '^##.*OSFHEAD' $descFile >/dev/null ; then
    files="$Macros/osfhead.rsml $files"
fi

if $verbose ; then
    echo "Processing files: $files"
fi

#  Yuck!  This is to get rid of the newlines in the files string.
#  (Another reason why this whole thing should be re-done in C...)
files=`eval echo $files`

if $doPrintOrder ; then
    np=`echo $nextPiece | awk '{printf "%03d",$1-1}'`
    OutfileName=$OUTPUT_DIR/$np.$name$ext
else
    OutfileName=$OUTPUT_DIR/$name$ext
fi

rm -f $OutfileName

if [ -z "$name" -o -z "$type" -o -z "$files" ]; then
    echo ""
    echo "Error in Description file, line $Piece"
    echo ""
    echo "name='$name', type='$type', files='$files'"
    echo ""
    exit 4
fi

echo ""
echo "formatting body $name ($Type) for $outForm;  part $Piece of" `sed -e '/^#/d' -e '/^$/d' $descFile | wc -l`

# do body stuff

if [ "$type" = "mm" ]
then
	(if [ ! -r Headers/header.mm ]
	 	then echo "Can't find Headers/header.mm"
	 		 exit 2
	 fi

	 rm -f $SYNC_DIR/head.$syncFile.$Piece
	 echo "$lastH1" | sync-h1-mm > $SYNC_DIR/head.$syncFile.$Piece
	 if [ -n "$lastPART" ] ; then
	     echo "$lastPART" |
		sed 's/\!PART:\(.*\)$/.ds |P \1/' >> $SYNC_DIR/head.$syncFile.$Piece
	 fi

	 if $doTroff && [ "$Form" = "pub" ]
		then macs="$Macros/mmt"
		else macs="-mm"
	 fi

	 if [ "$Form" = "draft" ]
		then macs="$macs $Macros/draft.mac"
	 fi

	macs="$macs $Macros/header.all $parts $Macros/$Form-hdr.mm \
          $Macros/headfoot.mm $Macros/$Form-mmt+.mm $Macros/bookdefs.mac"

	 if $doTroff ; then
	     if [ -r /usr/lib/tmac/tmac.eroff ]
		then macs="$macs /usr/lib/tmac/tmac.eroff"
		else macs="$macs $Macros/ps.mm"
	     fi
	     Options="$Options -T$TYPESETTER"
	     PicPrep=""
	 else
	     macs="$macs $Macros/nroff-hdr.mm"
	     Options="$Options -Tlp"
	     if $doExpress
		then PicPrep=""
		else PicPrep="rmPic"
	     fi
	 fi

	 if $doExpress ; then
	     if [ -r /usr/lib/tmac/tmac.eroff ]
		then macs="$macs /usr/lib/tmac/tmac.eroff"
		else macs="$macs $Macros/ps.mm"
	     fi
	     Options="$Options -Tps"
	 fi

	 if $doSML
		then macs="$macs $Macros/sml $Macros/gpsml"
	 fi

	 prefiles="$SYNC_DIR/head.$syncFile.$Piece \
		Headers/header.mm $Macros/sync-pre.mm"
	 postfiles="$Macros/sync-post.mm"
	 syncOptions=`syncGen $SYNC_DIR/$syncFile.$Piece`
	 allOptions="$Options -rN5 $syncOptions $macs $xmacs \
		$prefiles - $postfiles 2>>$SYNC_DIR/$syncFile.$nextPiece"
	 if [ "$preProcess" = "NONE" ]; then
	    preProcess="$PicPrep"
	 else
	    if [ -n "$PicPrep" ]; then
		preProcess="$preProcess | $PicPrep"
	    fi
	 fi
	 if $verbose ; then
	     echo ""
	     echo "command to execute:"
	     echo "`roff-cmd $Formatter $defines -p \"$preProcess\" \
		-o \"$allOptions\" $files`"
	     echo ""
	 fi
	 eval "`roff-cmd $Formatter $defines -p \"$preProcess\" \
		-o \"$allOptions\" $files `" | \
		$outFilter >$OutfileName

	 grep -v "^\!" $SYNC_DIR/$syncFile.$nextPiece | sed "s/^/ERROR: /"

	 if [ "`tail -1 $SYNC_DIR/$syncFile.$nextPiece | cut -f1 -d' '`" != "!SYNC:" ]
		then echo "ERROR: this piece did not format to completion, and the section and page"
		     echo "ERROR:     numbers in the following pieces will be wrong"
	 fi
	)

# do man stuff

elif [ "$type" = "man" ]
then
	if [ ! -r Headers/header.man ] ; then
	    echo "Can't find Headers/header.man"
	    exit 2
	fi

	echo "$lastH1" | sync-h1-man > $SYNC_DIR/manhd.$syncFile.$Piece
	if [ -n "$lastPART" ] ; then
	    echo "$lastPART" |
		sed 's/\!PART:\(.*\)$/.ds |P \1/' >> $SYNC_DIR/manhd.$syncFile.$Piece
	fi

	if $doTroff && [ "$Form" = "pub" ]
	    then macs="$Macros/an"
	    else macs="-man"
	fi

	macs="$macs $Macros/header.all $Macros/$Form-hdr.man $Macros/$Form-an+.man $Macros/bookdefs.mac"

	if $doTroff ; then
	    if [ -r /usr/lib/tmac/tmac.eroff ]
		then macs="$macs /usr/lib/tmac/tmac.eroff"
		else macs="$macs $Macros/ps.mm"
	    fi
	    Options="$Options -T$TYPESETTER"
	else
	    Options="$Options -Tlp"
	fi

	if $doExpress ; then
	    if [ -r /usr/lib/tmac/tmac.eroff ]
		then macs="$macs /usr/lib/tmac/tmac.eroff"
		else macs="$macs $Macros/ps.mm"
	     fi
	     Options="$Options -Tps"
	fi

	if $doSML
	    then macs="$macs $Macros/sml $Macros/rsml"
	fi

	prefiles="$SYNC_DIR/manhd.$syncFile.$Piece Headers/header.man $Macros/sync-pre.man"
	postfiles="$Macros/sync-post.man"
	syncOptions=`syncGen $SYNC_DIR/$syncFile.$Piece`
	allOptions="$Options $syncOptions $macs $xmacs $prefiles - $postfiles \
		2>>$SYNC_DIR/$syncFile.$nextPiece"

	if [ "$Form" = "pub" ]; then
		if [ "$preProcess" = "NONE" ]; then
			preProcess="fix-man"
		else
			preProcess="$preProcess | fix-man"
		fi
	else
		if [ "$preProcess" = "NONE" ]; then
			preProcess="cat"
		fi
	fi

	if $verbose ; then
	    echo ""
	    echo "command to execute:"
	    echo "`roff-cmd $Formatter $defines -p \"$preProcess\" \
		-o \"$allOptions\" $files`"
	    echo ""
	fi
	eval "`roff-cmd $Formatter $defines -p \"$preProcess\" \
		-o \"$allOptions\" $files`" | \
		$outFilter >$OutfileName

	grep -v "^\!" $SYNC_DIR/$syncFile.$nextPiece | sed "s/^/ERROR: /"

	 if [ "`tail -1 $SYNC_DIR/$syncFile.$nextPiece | cut -f1 -d' '`" != "!SYNC:" ]
		then echo "ERROR: this piece did not format to completion, and the section and page"
		     echo "ERROR:     numbers in the following pieces will be wrong"
	 fi


elif [ "$type" = "ptx" -o "$type" = "mptx" ] ; then

# handle permuted indexes.  We get a "ptx" in the second column of
# the Description file, then the list of files is the manpages from
# within which to grab the description lines.

    if $verbose ; then echo "Permuted index" ; fi

	(if [ ! -r Headers/header.mm ] ; then
	    echo "Can't find Headers/header.mm"
	    exit 2
	 fi

	 echo "$lastH1" | sync-h1-mm > $SYNC_DIR/head.$syncFile.$Piece
	 if [ -n "$lastPART" ] ; then
	     echo "$lastPART" |
		sed 's/\!PART:\(.*\)$/.ds |P \1/' >> $SYNC_DIR/head.$syncFile.$Piece
	 fi

	 if $doTroff && [ "$Form" = "pub" ]
		then macs="$Macros/mmt"
		else macs="-mm"
	 fi

	 if [ "$Form" = "draft" ]
		then macs="$macs $Macros/draft.mac"
	 fi

	macs="$macs $Macros/header.all $parts $Macros/$Form-hdr.mm \
		$Macros/headfoot.mm $Macros/$Form-mmt+.mm \
		$Macros/bookdefs.mac /usr/lib/tmac/tmac.ptx"

	 if $doTroff ; then
	     Options="$Options -T$TYPESETTER"
	     PicPrep=""
	 else
	     macs="$macs $Macros/nroff-hdr.mm"
	     Options="$Options -Tlp"
		 PicPrep=""
	 fi

	 if $doExpress ; then
	     Options="$Options -T$TYPESETTER"
	 fi

	 if $doSML
		then macs="$macs $Macros/sml $Macros/gpsml"
	 fi

	 prefiles="$SYNC_DIR/head.$syncFile.$Piece \
		Headers/header.mm $Macros/sync-pre.mm"
	 postfiles="$Macros/sync-post.mm"
	 syncOptions=`syncGen $SYNC_DIR/$syncFile.$Piece`
	 allOptions="$Options $syncOptions $macs $xmacs \
		$prefiles $Macros/ptx.mm - $postfiles 2>>$SYNC_DIR/$syncFile.$nextPiece"

	 ptxtmp=/tmp/ptx-$$-p
	 trap "rm -f $ptxtmp ; exit $?" 0 1 2 3 4 15
	 echo "...\\\"build -rmifdef -tbl -pic -eqn" > $ptxtmp
	 export defines
	 make-ptx $files >> $ptxtmp
	 if $verbose ; then
	     echo ""
	     echo "command to execute:"
	     echo "`roff-cmd $Formatter $defines \
		-o \"$allOptions\" $ptxtmp`"
	     echo ""
	 fi

	 eval "`roff-cmd $Formatter $defines \
		-o \"$allOptions\" $ptxtmp `" | $outFilter >$OutfileName

	 grep -v "^\!" $SYNC_DIR/$syncFile.$nextPiece | sed "s/^/ERROR: /"

	 if [ "`tail -1 $SYNC_DIR/$syncFile.$nextPiece | cut -f1 -d' '`" != "!SYNC:" ]
		then echo "ERROR: this piece did not format to completion, and the section and page"
		     echo "ERROR:     numbers in the following pieces will be wrong"
	 fi
	)

else
	echo "Error in Description file:  '$type' is an unknown type."
fi

