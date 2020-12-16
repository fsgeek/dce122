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
# $Log: fmt-gloss.sh,v $
# Revision 1.1.2.5  1994/06/23  19:48:40  fred
# 	free copyright
# 	[1994/06/23  19:42:32  fred]
#
# Revision 1.1.2.4  1994/06/23  18:37:31  fred
# 	free copyright
# 	[1994/06/22  15:28:48  fred]
# 
# Revision 1.1.2.3  1993/04/10  01:03:08  bowe
# 	Add OSF copyright.
# 	[1993/04/10  01:00:18  bowe]
# 
# Revision 1.1.2.2  1992/07/07  14:51:51  bowe
# 	Initial rev.
# 	[1992/07/07  14:48:27  bowe]
# 
# $EndLog$
#
#  $Header: /u1/rcs/dte/book-format/fmt-gloss.sh,v 1.1.2.5 1994/06/23 19:48:40 fred Exp $
#
#  fmt-gloss - format a glossary from info gleaned from sync files.
#  Called from book-format.

# set some defaults
DEFAULT_DTE_LIBDIR=/project/tools/libdata
DEFAULT_GLOSSDIR=$DEFAULT_DTE_LIBDIR/glossary

Formatter=-t
Form=draft
Style=p
nopost=false
descFile=Description
bookName=-all
verbose=false
dump=false
gOPT=""
doPrintOrder=false
term_list="/tmp/gl.in.$$"

trap "rm -f $term_list ; exit $?" 0 1 2 3 4 15

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
	-book)	bookName=$2
		shift
		;;
	-out*)	OUTPUT_DIR=$2
		shift
		;;
	-libdir | -root)
		DTE_LIBDIR=$2
		shift
		;;
	-dump)	dump=true
		gOPT="-q"
		;;
	-printorder)	doPrintOrder=true ;;
	-h*)	
		cat << E_O_F
usage: $0 [-n|-t|-x] [-d|-p] [-Ttypesetter] [-des DescriptFile]
	[-out OutputDir] [-libdir LibDir] [-book name] [-help]
    -t 			format with troff (default)
    -n			format with nroff
    -x			format with express
    -p			publish look (default)
    -d			draft look
    -Ttypesetter	typesetter - default is "ps"
    -des DescriptFile	alternate name of description file
    -out OutputDir	name of output directory
    -libdir LibDir	set root of DTE library tree
    -book name		filter glossary db by name of book
    -help		print this help message and exit
E_O_F
		exit 0
		;;

	-T*)	TYPESETTER=`echo $3 | sed "s/-T//"`
		nopost=true
		;;

	-D*)	;;
	-v)	verbose=true ;;

	*)	TYPESETTER=ps
		nopost=false
		;;
    esac
    shift
done

if [ -z "$TROFF" ]	; then TROFF=troff ; fi
if [ -z "$NROFF" ]	; then NROFF=nroff ; fi
if [ -z "$TYPESETTER" ]	; then TYPESETTER=ps ; fi
if [ -z "$DTE_LIBDIR" ]	; then DTE_LIBDIR=$DEFAULT_DTE_LIBDIR ; fi
if [ -z "$SYNC_DIR" ]	; then SYNC_DIR="Sync" ; fi

M=$DTE_LIBDIR/macros

if $dump ; then
    Macs="$M/$Form-hdr.mm $M/$Form-mmt+.mm"
else
    Macs="Headers/header.mm $M/$Form-hdr.mm $M/$Form-mmt+.mm"
fi

if egrep '^##.*PARTS' $descFile >/dev/null ; then
    Macs="$Macs $M/parts.sml"
fi

Macs="$Macs $M/headfoot.mm $M/glossary.mm $M/glosshead.mm $M/sml $M/gpsml"

GLOSS=query_gloss
if [ -z "$GLOSSDIR" ] ; then
    if [ -z "$DTE_LIBDIR" ] ; then
	GLOSSDIR=$DEFAULT_GLOSSDIR
    else
	GLOSSDIR=$DTE_LIBDIR/glossary
    fi
fi
if [ ! -d "$GLOSSDIR" ] ; then
    echo "Can not find glossary directory '$GLOSSDIR'"
    exit 1
fi

# be tolerant of fonts loaded into the wrong place

if [ ! -d /usr/lib/font/dev$TYPESETTER -a -d /usr/local/lib/font ]
    then LIB="-F/usr/local/lib/font"
    else LIB=""
fi
if [ -z "$DTE_OUTFILTER" ] ; then DTE_OUTFILTER="eps $LIB" ; fi

if $doPrintOrder ; then Pc="998." ; fi


if [ " $Formatter" = " -n" ]; then
    formatter="$NROFF -Tlp -mm $nroffOptions $Macs - 2>/dev/null"
    if $dump ;
	then outFile=gloss-dump
	else outFile=$OUTPUT_DIR/${Pc}glossary
    fi
    outFilter="col > $outFile"

elif [ " $Formatter" = " -t" ]; then
    formatter="$TROFF -T$TYPESETTER $LIB -mm $troffOptions $Macs -  2>/dev/null"
    if $dump ;
	then outFile=gloss-dump.$TYPESETTER
	else outFile=$OUTPUT_DIR/${Pc}glossary.$TYPESETTER
    fi
    if $nopost; then
	outFilter="cat > $outFile"
    else
	outFilter="$DTE_OUTFILTER > $outFile"
    fi

elif [ " $Formatter" = " -x" ]; then
    formatter="$TROFF -Tps $LIB -mm $troffOptions $Macs - 2>/dev/null"
    if $dump ;
	then outFile=gloss-dump.x
	else outFile=$OUTPUT_DIR/${Pc}glossary.x
    fi
    outFilter="cat $LIB > $outFile"
    Formatter=-t
fi

echo ""
echo "formatting glossary"

if $dump ; then
    true
else
    syncFile=$Style$Formatter
    FILES="$SYNC_DIR/$syncFile.???"
    # If a glossary entry is given by [ .gL "*" ] in the input file,
    # the writer wants all definitions.
    cat $FILES | egrep '!GLOSSARY: *"\*"' >> /dev/null
    if [ $? -eq 0 ] ; then
	dump=true
    else
	cat $FILES |
		sed -n 's/\!GLOSSARY: //p' | sed -e 's/"//' -e 's/".*$//' | \
		sort -f | uniq > $term_list
    fi
fi
if $dump ; then
    cat $GLOSSDIR/gloss[@A-Z] | sed -n 's/^|\.TERM|//p' | sort -f | uniq > $term_list
    gOPT="-q"
fi

rm -f $outFile


#  This (awk script) will take input (described below) about glossary
#  infomation and output troff -mm fodder to be processed into a glossary
#  on the page.
#
#  Input expected to look like this from the database
#
#	|.TERM|kill|1
#	|.ACR|				<-- optional
#	   |.DEFIN|1|An operating system command that stops a process.
#	      |.XREF|			<-- optional, can be more than 1 entry
#	      |.BOOK|			<-- optional, can be more than 1 entry
#	      |.TOPIC|			<-- optional, can be more than 1 entry

$GLOSS $gOPT $bookName $term_list $GLOSSDIR - |
awk -F'|' '
BEGIN {
    term="";
    ndefs=0;
    printf(".VL \\n(!!u\n");
}
/\.TERM/ {
    if (ndefs > 1) printf(".LE\n");
    term=$3;
    ndefs=$4;
    seeother=0;
}
/\.ACR/ {
    printf(".sp .25v\n.ne 3\n.LI \"\\*L%s",term);
    if (NF > 2 && length($3) > 0) printf(" (%s)",$3);
    printf("\\*O\"\n");
    if (ndefs > 1) printf(".AL\n");
    else printf(".sp .5v\n");
}
/\.DEFIN/ {
    if (ndefs > 1)
	printf(".br\n.ne 3\n.LI\n%s\n",$4);
    else
	if (index($4,"*") == 1)
	    seeother=1;
	else
	    printf("%s\n",$4);
    nxref=0;
}
/\.XREF/ {
    if (NF > 2 && length($3) > 0) {
	xref[nxref] = $3;
	nxref++;
    }
}
/\.BOOK/ {
    if (nxref == 1) {
	if (seeother == 1)
	    printf("\\fISee\\fR \\*L%s\\*O.\n",xref[0]);
	else
	    printf("\\fISee also\\fR \\*L%s\\*O.\n",xref[0]);
    }
    else if (nxref > 1) {
	printf("\\fISee also\\fR ");
	for (i=0; i<nxref; i++)
	    if (i == (nxref-1))
		printf("\\*L%s\\*O.\n",xref[i]);
	    else
		printf("\\*L%s\\*O, ",xref[i]);
    }
    nxref=0;
}
/\.TOPIC/ { }
/./ { if (NF == 1 && length($1) > 0) print $0; }
END {
    if (ndefs > 1) printf(".LE\n");
    printf(".LE\n");
}
' | eval "$formatter" | eval "$outFilter"

# finally, add an entry to the TOC--

echo "!TOC: .)T 1 1 \"\h'|0i'\" Glossary GL-1" > $SYNC_DIR/$Style$Formatter.998

