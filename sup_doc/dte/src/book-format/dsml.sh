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
# $Log: dsml.sh,v $
# Revision 1.1.2.5  1994/06/23  19:48:29  fred
# 	free copyright
# 	[1994/06/23  19:39:58  fred]
#
# Revision 1.1.2.4  1994/06/23  18:37:21  fred
# 	free copyright
# 	[1994/06/22  15:28:16  fred]
# 
# Revision 1.1.2.3  1993/04/10  01:03:00  bowe
# 	Add OSF copyright.
# 	[1993/04/10  01:00:04  bowe]
# 
# Revision 1.1.2.2  1992/07/07  14:51:20  bowe
# 	Initial rev.
# 	[1992/07/07  14:48:19  bowe]
# 
# $EndLog$
#
# $Header: /u1/rcs/dte/book-format/dsml.sh,v 1.1.2.5 1994/06/23 19:48:29 fred Exp $
#
#  Format files using SML macros (GPSML, RSML).  Meant to be a replacement
#  for dmm and dman.
#

DEFAULT_DTE_LIBDIR=/project/tools/libdata

copyright=false
do_col=false
do_nroff=false
sml="gp"
book=false
expresspreview=false
nopost=false
quick=false
usage=false
verbose=false
defines=""
showifdef=false
do_rmifdef=0
FILES=""
MACS=""
xmacs=""

# look at personal defaults
if [ -f $HOME/.dterc ] ; then
    . $HOME/.dterc
    export DTE_LIBDIR DTE_OUTFILTER TYPESETTER OUTPUT
    export TROFF NROFF TBL PIC NEQN EQN RMIFDEF
fi

while [ "$#" -gt 0 ] ; do
    case $1 in
    -n)		do_nroff=true ;;
    -t)		do_nroff=false ;;
    -x)		do_nroff=false
		expresspreview=true
		;;
    -c)		copyright=true ;;
    -book)	book=true ;;
    -q)		quick=true ;;		# skip tbl, pic, eqn
    -libdir)	shift
		DTE_LIBDIR=$1
		;;
    -gp)	sml="gp" ;;
    -ref)	sml="ref" ;;
    -m)		xmac="$xmac $2"
		shift
		;;
    -mac*)	DMAC=$2
		shift
		;;
    -v)		verbose=true ;;
    -T*)	TYPESETTER=`echo $1 | sed "s/-T//"`
		nopost=true
		;;
    -D)		do_rmifdef=1 ;;
    -D*)	defines="$defines $1" ;;
    -U*)	defines="$defines $1" ;;
    -showif*)	showifdef=true ;;
    -h*)	usage=true
		break
		;;
    -)		FILES="$FILES -" ;;
    -*)		usage=true
		echo "Unknown option \"$1\"."
		break
		;;
    *)		FILES="$FILES $1" ;;
    esac
    shift
done

if `$usage` ; then
    cat << E_O_F
Usage: $0 [options ...] [files ...]
    -t		Process with nroff [default]
    -n		Process with nroff
    -x		Process with express
    -c		Include copyright macros
    -book	Include book draft macros
    -q		Use "quick mode" - skip tbl, pic, eqn processing
    -libdir <dir> set DTE library directory.  (default $DTE_LIBDIR)
    -gp		Use GPSML (general purpose) macros [default]
    -ref	Use RSML (reference) macros
    -mac <dir>	Search <dir> for macro files
    -D<sybmol>	Process #ifdef/#else/#endif (cpp-like), defining <symbol>.
    -showifdef  Embolden #ifdef/#else/#endif in the output.  Turns off -D.
    -T<typeset>	Use typesetter <typeset>
    -help	Print this help message
    <files>	Files to process ("-" means read standard input)
E_O_F
    exit 1
fi

#  see what we want to do with #ifdefs
if `$showifdef` ; then
    defines=""
    do_rmifdef=0
fi
if [ -n "$defines" -o $do_rmifdef -eq 1 ]; then
    IFDEF="cat $FILES | $RMIFDEF $defines"
elif `$showifdef` ; then
    IFDEF="cat $FILES | show-ifdefs"
else
    IFDEF="cat $FILES"
fi

# working locations and format control places:
if [ -z "$DTE_LIBDIR" ] ; then DTE_LIBDIR=$DEFAULT_DTE_LIBDIR ; fi
if [ -z "$TYPESETTER" ] ; then TYPESETTER=ps ; fi
if [ -z "$DMAC" ] ; then DMAC=$DTE_LIBDIR/macros ; fi
export DTE_LIBDIR

# be tolerant of fonts loaded into the wrong place
if [ ! -d /usr/lib/font/dev$TYPESETTER -a -d /usr/local/lib/font ]
    then LIB="-F/usr/local/lib/font"
    else LIB=""
fi

RMBOXES=rmboxes
if [ -z "$TBL" ]	; then TBL=tbl		; fi
if [ -z "$PIC" ]	; then PIC=pic		; fi
if [ -z "$EQN" ]	; then EQN=eqn		; fi
if [ -z "$NEQN" ]	; then NEQN=neqn	; fi
if [ -z "$NROFF" ]	; then NROFF=nroff	; fi
if [ -z "$TROFF" ]	; then TROFF=troff	; fi
if [ -z "$RMIFDEF" ]	; then RMIFDEF=rmifdef	; fi
if [ -z "$DTE_OUTFILTER" ] ; then DTE_OUTFILTER="eps $LIB" ; fi

if [ "$sml" = "gp" ]; then
    MACS="-mm"
elif [ "$sml" = "ref" ]; then
    MACS="-man"
fi

# add the right SML macros
if [ "$sml" = "gp" ]; then
    MACS="$MACS $DMAC/draft-hdr.mm $DMAC/draft-mmt+.mm"
    MACS="$MACS $DMAC/sml $DMAC/gpsml $DMAC/nonbook.mm"
elif [ "$sml" = "ref" ]; then
    MACS="$MACS $DMAC/draft-hdr.man $DMAC/draft-an+.man"
    MACS="$MACS $DMAC/sml $DMAC/rsml $DMAC/nonbook.man"
fi
if [ -r /usr/lib/tmac/tmac.eroff ]
    then MACS="$MACS /usr/lib/tmac/tmac.eroff"
    else MACS="$MACS $DMAC/ps.mm"
fi

# copyright option
if `$copyright` ; then
    MACS="$MACS $DMAC/copyright.mm"
fi

# figure out args to [nt]roff
if `$do_nroff`; then
    FORMATTER="$NROFF -Tlp"
    TBL="$RMBOXES | $TBL"
    EQUATIONS=$NEQN
    MACS="$MACS $DMAC/nroff-hdr.mm"
    if `$do_col`
	then POST="col -l |"
	else POST=""
    fi
    POST="$POST more"
else
    FORMATTER="$TROFF $LIB -T$TYPESETTER"
    EQUATIONS=$EQN
    if `$nopost` || `$expresspreview`
	then POST="cat"
	else POST=$DTE_OUTFILTER
    fi
fi

# now, do formatting
tmp=/tmp/sml-err-$$
trap "rm -f $tmp ; exit $?" 0 1 2 3 15

if `$quick` ; then
#    cat $FILES | $FORMATTER $MACS - 2>> $tmp | eval $POST
    eval $IFDEF | $FORMATTER $MACS - 2>> $tmp | eval $POST
else
    eval $IFDEF | $PIC | eval $TBL | $EQUATIONS | $FORMATTER $MACS - 2>> \
		$tmp | eval $POST
    if $verbose ; then
	echo "$IFDEF | $PIC | eval $TBL | $EQUATIONS | $FORMATTER $MACS -" \
		> /dev/tty
    fi
fi

# distinguish troff errors from sml comments found in stderr
egrep '^/ERROR:' $tmp

