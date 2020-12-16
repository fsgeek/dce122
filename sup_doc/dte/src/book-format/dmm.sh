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
# $Log: dmm.sh,v $
# Revision 1.1.2.5  1994/06/23  19:48:27  fred
# 	free copyright
# 	[1994/06/23  19:39:51  fred]
#
# Revision 1.1.2.4  1994/06/23  18:37:19  fred
# 	free copyright
# 	[1994/06/22  15:26:31  fred]
# 
# Revision 1.1.2.3  1993/04/10  01:02:59  bowe
# 	Add OSF copyright.
# 	[1993/04/10  01:00:02  bowe]
# 
# Revision 1.1.2.2  1992/07/07  14:51:15  bowe
# 	Initial rev.
# 	[1992/07/07  14:48:11  bowe]
# 
# $EndLog$
#
# $Header: /u1/rcs/dte/book-format/dmm.sh,v 1.1.2.5 1994/06/23 19:48:27 fred Exp $
#
#  Formats -mm or gpsml documents.
#

# set variables:
DEFAULT_DTE_LIBDIR=/project/tools/libdata

Version="\$Revision: 1.1.2.5 $, \$Date: 1994/06/23 19:48:27 $, \$Author: fred $";
copyright=false
col_p=false
COL=col
nroff=false
expresspreview=false
sml=false
check_sml=true
nopost=false
FILES=""
defines=""
do_rmifdef=0
showifdef=false
verbose=false
tmp=/tmp/dmm-er-$$

trap "rm -f $tmp ; exit $?" 0 1 2 3 4 15

# look at personal defaults
if [ -f $HOME/.dterc ] ; then
    . $HOME/.dterc
    export DTE_LIBDIR DTE_OUTFILTER TYPESETTER OUTPUT
    export TROFF NROFF TBL PIC NEQN EQN RMIFDEF
fi

while [ "$#" -gt 0 ]
do
	case $1 in
	-n)		nroff=true;;
	-t)		nroff=false;;
	-x)		nroff=false
			expresspreview=true;;
	-c)		copyright=true;;
	-sml)		sml=true  ; check_sml=false	;;
	-nosml)		sml=false ; check_sml=false	;;
	-libdir)	shift
			DTE_LIBDIR=$1;;
	-p)		col_p=true;;
	-D | -ifdef | -rmifdef)
			do_rmifdef=1 ;;
	-D*)		defines="$defines $1" ;;
	-U*)		defines="$defines $1" ;;
	-showif*)	showifdef=true;;
	-T*)		TYPESETTER=`echo $1 | sed "s/-T//"`
			nopost=true;;
	-version)	echo "`basename $0`: $Version"
			exit 0 ;;
	-v)		verbose=true ;;
	-)		FILES="-" ;;
	-*)		FILES=""
			break;;
	*)		FILES="$FILES $1";;
	esac
	shift
done

if [ "$FILES" = "" ]; then
    cat << E_O_F
usage: $0 [-n|-t|-x] [-Ttypesetter] [-Dsym ...] [-libdir dir] [-sml] file ...

    -n		build for nroff.
    -t		build for troff (default).
    -x		build for express.

    -Ttypesetter  use the named typesetter (don't postprocess) (default "ps").

    -sml	use SML macros.
    -nosml	do not use SML macros (default).

    -libdir <dir>	set DTE library directory.  (default $DTE_LIBDIR)

    -Dsymbol	filter through rmifdef to do #ifdef processing.
    -showifdef  Embolden #ifdef/#else/#endif in the output.  Turns off other
		#ifdef processing.

    file	file(s) to process.  "-" means read standard input.

E_O_F
    exit 1
fi

if $check_sml ; then
    for f in $FILES ; do
	if echo $f | egrep '\.sml' >/dev/null ; then
	    echo "Note: assuming SML (from .sml suffix of $f)" 1>&2
	    sml=true
	fi
    done
fi

if [ -z "$DTE_LIBDIR" ] ; then DTE_LIBDIR=$DEFAULT_DTE_LIBDIR ; fi
if [ -z "$TYPESETTER" ] ; then TYPESETTER=ps ; fi

# be tolerant of fonts loaded into the wrong place

if [ ! -d /usr/lib/font/dev$TYPESETTER -a -d /usr/local/lib/font ]
	then LIB="-F/usr/local/lib/font"
	else LIB=""
fi

# working locations and format control places:

PATH=/usr/local/bin:$PATH
export DTE_LIBDIR PATH

RMBOXES=rmboxes
if [ -z "$TBL" ]	; then TBL=tbl		; fi
if [ -z "$PIC" ]	; then PIC=pic		; fi
if [ -z "$EQN" ]	; then EQN=eqn		; fi
if [ -z "$NEQN" ]	; then NEQN=neqn	; fi
if [ -z "$NROFF" ]	; then NROFF=nroff	; fi
if [ -z "$TROFF" ]	; then TROFF=troff	; fi
if [ -z "$RMIFDEF" ]	; then RMIFDEF=rmifdef	; fi
if [ -z "$DTE_OUTFILTER" ] ; then DTE_OUTFILTER="eps $LIB" ; fi

DMAC=$DTE_LIBDIR/macros

if [ -r /usr/lib/tmac/tmac.eroff ]
    then MACS="-mm /usr/lib/tmac/tmac.eroff"
    else MACS="-mm $DMAC/ps.mm"
fi

MACS="$MACS $DMAC/header.all $DMAC/draft-hdr.mm $DMAC/draft-mmt+.mm $DMAC/bookdefs.mac"

# copyright option
if $copyright ; then
    MACS="$MACS $DMAC/copyright.mm"
fi

# sml option
if $sml ; then
    MACS="$MACS $DMAC/sml $DMAC/gpsml"
fi

OPTIONS=""

if $nroff ; then

    FORMATTER="$NROFF -Tlp $OPTIONS"
    TBL="$RMBOXES | $TBL"
    EQUATIONS=$NEQN
    MACS="$MACS $DMAC/nroff-hdr.mm"
    if $col_p
	then POST="$COL -l |"
	else POST=""
    fi
    POST="$POST cat"

else
    FORMATTER="$TROFF $LIB -T$TYPESETTER $OPTIONS"
    EQUATIONS=$EQN
    if $nopost || $expresspreview
	then POST="cat"
	else POST=$DTE_OUTFILTER
    fi
fi

# get rid of the book-like styling (page numbers, Chapters)
MACS="$MACS $DMAC/nonbook.mm"

# now, do formatting

#  see what we want to do with #ifdefs
if $showifdef ; then
    defines=""
    do_rmifdef=0
fi
if [ -n "$defines" -o $do_rmifdef -eq 1 ]; then
    IFDEF="cat $FILES | $RMIFDEF $defines"
elif $showifdef ; then
    IFDEF="cat $FILES | elimso | show-ifdefs"
else
    IFDEF="cat $FILES | elimso"
fi

if $verbose ; then
    echo "COMMAND: $IFDEF | $PIC | $TBL | $EQUATIONS | \
	$FORMATTER $MACS - | $POST" 1>&2
fi

echo "!Hack for bug in OSF/1's grep" > $tmp
eval $IFDEF |
    $PIC | eval $TBL | $EQUATIONS |
	$FORMATTER $MACS - 2>> $tmp |
	    eval $POST

# distinguish troff errors from sml comments found in stderr

grep -v "^\!" $tmp | sed "s/^/ERROR: /" >& 2

