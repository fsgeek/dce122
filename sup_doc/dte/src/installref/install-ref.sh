#!/bin/sh
#
# THIS IS NOT A SOURCE FILE - DO NOT EDIT
#
#
# Copyright 1992,1993 Open Software Foundation, Inc.,
# Cambridge, Massachusetts
# All rights reserved.
#
# @OSF_FREE_COPYRIGHT@
#
# 
# HISTORY
# $Log: install-ref.sh,v $
# Revision 1.1.2.9  1994/06/24  15:47:47  fred
# 	free copyright
# 	[1994/06/24  15:28:14  fred]
#
# Revision 1.1.2.8  1994/06/23  18:40:55  fred
# 	free copyright
# 	[1994/06/22  19:42:10  fred]
# 
# Revision 1.1.2.7  1993/09/21  20:15:41  bowe
# 	Add `pwd` to path if manpage directory is relative to current dir.
# 	Made Ken much happier.
# 	[1993/09/21  20:14:50  bowe]
# 
# Revision 1.1.2.6  1993/05/20  18:55:57  bowe
# 	Fixed sed instructions.  There was a problem with stripping trailing
# 	blanks on lines when a comment followed.  Escaped blanks should be
# 	kept.
# 	[1993/05/20  18:55:29  bowe]
# 
# Revision 1.1.2.5  1993/04/09  21:30:28  bowe
# 	Add copyright statement.
# 	[1993/04/09  21:28:40  bowe]
# 
# Revision 1.1.2.4  1992/12/14  19:04:13  bowe
# 	Fix botch in generation of sed script to expand book name.
# 	(Used to depend on writers to specify then in a strict format.)
# 	DTE CR 427.
# 	[1992/12/14  19:03:48  bowe]
# 
# Revision 1.1.2.3  1992/08/07  13:32:23  bowe
# 	Added option to make simple suffixes (*.1X -> *.1).
# 	Some performance enhancements (use sh's "case...esac" instead
# 	of "if [ xx ] ..." (less processes), especially within loops.
# 	[1992/08/07  13:28:23  bowe]
# 
# Revision 1.1.2.2  1992/07/14  14:44:16  bowe
# 	Initial rev.
# 	[1992/07/14  14:41:50  bowe]
# 
# $EndLog$
#
# $Header: /u1/rcs/dte/installref/install-ref.sh,v 1.1.2.9 1994/06/24 15:47:47 fred Exp $
#
#  Install procedure for manpages for any offering.
#
#  Additional programs required:
#    rmifdef	  - compile rmifdef.c and be sure rmifdef is in your path
#    rmboxes	  - be sure shell script rmboxes is in your path
#    tbl, eqn	  - shipped as "unsupported" with OSF/1; come with DWB
#
#  Additional files required:
#    <offering>.dirlist - list of directories (under doc root) where files to
#			  be installed reside
#    <offering>.links   - list of hard links to make in directories (each line
#			  is of the form "man1/vi.1 man1/view.1") [ if desired ]
#    bookdefs.mac       - for expanding troff strings referencing book names
#    sml macros		- header.all, sml, rsml
#
#  Information required:
#    Path to root of doc source tree.
#    Path to SML macros directory
#    Path to man installation (target) directory.
#    
#  Also needed:
#    Write permission to man page destination ($MANDIR or /usr/share/man).
#
#  To process in batch mode, do something like this (this should not ask
#  you questions):
#    inst-refs -offering osf1 -smart -sml path-to-sml-macros \
#		-doc path-to-doc-tree -man path-to-man-install-area -so
# __________________________________________________________________

#  Initialize some variables we'll need later

help=false
verbose=0
Verbose=0
sml_so=false
sml_insert=false
smart=0
solink=true
offering=""
here=`pwd`
fake=false
hack_tables=false
dup_tables=0
exp_names=0
simple_suff=0

#  These are for OSF/1 security-based manuals
C2DEF="-DSEC_BASE -DSEC_ACL -DSEC_ACL_POSIX -DSEC_ARCH -DSEC_FSCHANGE \
  -DSEC_ROLE_X -DSEC_ROLE_ASCII"
B1DEF="-DSEC_BASE -DSEC_ACL -DSEC_ACL_POSIX -DSEC_ARCH -DSEC_FSCHANGE \
  -DSEC_ROLE_X -DSEC_ROLE_ASCII -DSEC_MAC -DSEC_TERMINAL -DSEC_PRIV"

#  Change this to "install ...", if you like.
if [ -z "$INSTALL" ] ; then INSTALL=mv ; fi

# __________________________________________________________________

# parse args
while [ $# -gt 0 ] ; do
    case "$1" in
	-doc)		shift; DOCROOT=$1		;;
	-man)		shift; MANDIR=$1		;;
	-so)		sml_so=true			;;
	-insert)	sml_insert=true			;;
	-sml)		shift ; sml_dir=$1		;;
	-solink)	solink=true			;;
	-hardlink)	solink=false			;;
	-tbl)		shift; TBL=$1			;;
	-eqn|-neqn)	shift; EQN=$1			;;
	-dirlist)	shift; DirList=$1		;;
	-link)		shift; LinkList=$1		;;
	-B1)		SEC_LEVEL=B1			;;
	-C2)		SEC_LEVEL=C2			;;
	-off*)		shift ; offering=$1		;;
	-osf)		offering=osf			;;
	-dce)		offering=dce			;;
	-motif)		offering=motif			;;
	-dme)		offering=dme			;;
	-v)		verbose=1			;;
	-V)		verbose=1 ; Verbose=1		;;
	-smart)		smart=1				;;
	-expand)	exp_names=1			;;
	-suff*)		simple_suff=1			;;
	-hacktab*)	hack_tables=true		;;
	-duptab*)	hack_tables=true ; dup_tables=1 ;;
	-help)		help=true; break		;;
	-install)	shift ; INSTALL="$1"		;;
	-fake)		fake=true			;;
	-*)		echo "Unrecognized argument '$1' - ignored"	;;
    esac
    shift
done

if $help ; then cat << END_HELP

Usage: $0 [options ...]
  -doc DIR	root of documentation tree
  -offering OFF	use config files for offering OFF (osf, dce, motif, dme, ...)
  -dir FILE	file listing directories the contain man files to be installed
  -sml DIR	directory where SML macros live [default \$DTE_LIBDIR]
  -man DIR	path of destination man heirarchy [default /usr/share/man]
  -smart	smart mode - try to find defaults for args not specified
  -so		insert ".so" for SML macros into installed man files
  -insert	insert copy of SML macro files in each man file
  -solink	use .so for duplicates in multple-command man file [default]
  -hardlink	use hard links for duplicates in multple-command man file
  -tbl CMD	name of tbl command to use, or "none" for none [default "tbl"]
  -eqn CMD	name of eqn command to use, or "none" for none [default "none"]
  -B1		filter for B1 level security (osf1)
  -C2		filter for C2 level security (osf1)
  -hacktables	Hack certain tables to fit in 80 column display (Motif only)
  -duptables	Hack certain tables to fit in 80 column display in nroff
		but use all 5 columns in troff (Motif only)
  -expand	Expand certain filenames if not on a system with 14-character
		filename limit (Motif, generally)
  -suffix	Simplify suffixes to single digits.  E.g. abc.1X -> abc.1
  -v		verbose mode - shows progress of procedure
  -V		more verbose mode - shows more details of progress of procedure

Some information can not be defaulted.  If you do not specify the documentation
tree root or the path to sml macros, you will be asked.

If B1 or C2 is not specified, no security is assumed.
END_HELP
    exit 0
fi

# __________________________________________________________________

TH_sed=/tmp/RefInst.$$
smlinc=/tmp/inc.sml.$$
sed_tab=/tmp/tab.s.$$
awk_tab=/tmp/tab.a.$$
instmp=/tmp/instmp-$$
trap "rm -rf $TH_sed $smlinc $sed_tab $awk_tab $instmp ; exit $?" 0 1 2 15

if [ "$SEC_LEVEL" = "B1" ] ; then
    DEFINES="$B1DEF"
elif [ "$SEC_LEVEL" = "C2" ] ; then
    DEFINES="$C2DEF"
fi

#  elimso comes with the DTE, soelim should come with DWB
if [ -z "$SOELIM" ] ; then SOELIM=elimso ; fi

# __________________________________________________________________

#  Be sure builtin sh's echo groks "-n".  OSF/1's and SYSV's currently do not;
#  Ultrix's and Sun's do...  (we'll try to use the builtin)
#  We'll use $echon instead of "echo -n" when we need "echo -n".
if [ `echo -n x | wc -l` -eq 0 ] ; then
    echon="echo -n"
else
    if [ -f /usr/bin/echo ] ; then echon="/usr/bin/echo -n"
    elif [ -f /bin/echo ] ; then echon="/bin/echo -n"
    else echon="echo -n"
    fi
fi

# __________________________________________________________________

#  Decide whether system does long names (a real system) or it can
#  only handle 14 characters (a toy system).

case "$exp_names" in 1)
    touch /tmp/vERYVERYLONGNAME
    n=`ls /tmp/vERYVERY*`
    if [ "$n" != "/tmp/vERYVERYLONGNAME" ] ; then exp_names=0 ; fi
    rm -f /tmp/vERYVERYLONGNAME
;; esac

# __________________________________________________________________

# Be sure some required variables are set.  Some of these can be
# set as environment variables.

if [ -z "$MKWHATIS" ] ; then
    if [ -f /usr/lbin/mkwhatis ] ; then MKWHATIS=/usr/lbin/mkwhatis
    elif [ -f /usr/lib/makewhatis ] ; then MKWHATIS=/usr/lib/makewhatis
    else MKWHATIS='echo "Could not find a makewhatis command"'
    fi
fi
if [ -z "$CATMAN" ] ; then
    if [ -f /usr/sbin/catman ] ; then CATMAN=/usr/sbin/catman
    elif [ -f /usr/etc/catman ] ; then CATMAN=/usr/etc/catman
    else CATMAN='echo "Could not find a catman command"'
    fi
fi

if [ -z "$offering" ]  ; then
    n=`ls *.dirlist | wc -l`
    if [ $n -eq 1 ] ; then
	offering=`echo *.dirlist | sed -e 's/\.dirlist$//'`
	echo "Determined that offering is $offering."
    else
	case "$smart" in
	    1)
		echo "Can not determined what offering to install."
		exit 1
	    ;;
	    0)
		while [ -z "$offering" ] ; do
		    $echon "Offering to install: "
		    read offering
		    if [ ! -f $offering.dirlist ] ; then
			echo "Can find ./$offering.dirlist file"
			offering=""
		    fi
		done
	    ;;
	esac
    fi
fi

if [ -z "$DirList" ]  ; then DirList="$offering.dirlist" ; fi
if [ -z "$LinkList" ] ; then LinkList="$offering.links"  ; fi

for f in $DirList $LinkList ; do
    if [ ! -f $f ]  ; then
	echo ""
	echo "The file '$f' does not exist.  This file must be in"
	echo "the directory from which you run the install procedure."
	exit 1
    fi
done

# __________________________________________________________________

# Source files directories from DOCROOT
def=$DOCROOT
if [ -z "$DOCROOT" ] ; then
    if [ -z "$def" ] ; then
	echo "Root of doc source tree. [no default]"
    else
	echo "Root of doc source tree [default $def]"
    fi
    $echon "Directory: "
    read DOCROOT
fi
if [ -z "$DOCROOT" ] ; then DOCROOT=$def ; fi
while [ ! -d "$DOCROOT" ] ; do
    echo ""
    echo "The directory '$DOCROOT' does not exist."
    echo "Root of doc source tree [no default]"
    $echon "Directory: "
    read DOCROOT
    if [ -z "$DOCROOT" ] ; then DOCROOT=$def ; fi
done

# __________________________________________________________________

# be sure MANDIR is set to a place that we can write to
def=/usr/share/man
if [ -z "$MANDIR" ] ; then
    MANDIR=/$$-$$.x
    while [ ! -d "$MANDIR" ] ; do
	echo ""
	$echon "Path to man heirarchy [$def]: "
	read MANDIR
	if [ -z "$MANDIR" ] ; then MANDIR=$def ; fi
	touch $MANDIR/touchtst.$$ 2>&1 >/dev/null
	st=$?
	rm -f $MANDIR/touchtst.$$
	def=$MANDIR
	if [ "$st" -ne 0 ] ; then
	    echo ""
	    echo "Can not write to '$MANDIR'!"
	    MANDIR=/$$-$$.x
	fi
    done
fi

def="$DTE_LIBDIR/macros"
if [ -z "$sml_dir" ] ; then
    if [ -f "$DTE_LIBDIR/macros/sml" ] ; then
	sml_dir="$DTE_LIBDIR/macros"
    fi
    echo ""
    $echon "Path to SML macro directory [$def]: "
    read sml_dir
    if [ -z "$sml_dir" ] ; then sml_dir=$def ; fi
fi

#  be sure SML files are there
for f in header.all sml rsml bookdefs.mac ; do
    if [ ! -f $sml_dir/$f ] ; then
	echo "Could not find required file: $sml_dir/$f"
	exit 1
    fi
done
bookdefs="$sml_dir/bookdefs.mac"

# __________________________________________________________________

do_catdir=false
do_catman=false
do_mkwhatis=false

case "$smart" in
  1)	do_catdir=true	;;
  0)
    echo ""
    $echon "Would you like to create the 'cat' directories? [y/n, default 'n'] "
    read a
    if [ "$a" = "n" ] ; then do_catdir=true ; fi
    if $do_catdir ; then
	echo ""
	$echon "Would you like to run the catman command? [y/n, default 'n'] "
	read a
	if [ "$a" = "y" ] ; then do_caman=true ; fi
    fi
    if $do_catman ; then
	:
    else
	echo ""
	$echon "Would you like to run the mkwhatis command? [y/n, default 'n'] "
	read a
	if [ "$a" = "y" ] ; then do_mkwhatis=true ; fi
    fi
  ;;
esac

# __________________________________________________________________

case "$verbose" in 1)
    echo ""
    echo "Checking that source directories exist:"
;; esac
SourceList=""
for d in `egrep -v '^#' $here/$DirList` ; do
    case "$verbose" in 1) echo "    $d" ;; esac
    if [ -d $d ] ; then
	SourceList="$SourceList `pwd`/$d"
    elif [ -d $DOCROOT/$d ] ; then
	SourceList="$SourceList $DOCROOT/$d"
    else
	echo ""
	echo "$d does not exist!"
	echo "Please correct this and try again."
	exit 1
    fi
done
case "$verbose" in 1) echo "Source directories OK." ;; esac

# __________________________________________________________________

#  This is for motif table mucking.  It changes the 5-column tables into
#  rows of 3 and 2 cells.

sed_tab_cmd=""
if $hack_tables ; then
    RMBOXES=none
    cat > $sed_tab << 'END_THACK'
/^$/d
/NROFF HACK START/,/NROFF HACK END/ {
s/^Name	Class	Type	Default	Access/_\
Name	Default	Access\
\\ \\ \\ \\ \\ \\ Class	\\ \\ \\ \\ \\ \\ Type\
_/g
/Name	Default	Access/,/^\.TE/{
s/^\([^	]*\)	\([^	]*\)	\([^	]*\)	\([^	]*\)	\([^	]*\)/\1	\4	\5\
\\ \\ \\ \\ \\ \\ \2	\\ \\ \\ \\ \\ \\ \\ \3\
_/g
}
s/^lBp8 lBp8 lBp8 lBp8 lBp8$/lB lB lB\
lB lB lB/g
s/^lp8 lp8 lp8 lp8 lp8/l l l/g
s/^cBp9 ssss$/CB ss/g
s/^center allbox/center box/g
s/^\.tH/\.TE\
\.bp\
\.TS\
center box;\
lB lB lB\
lB lB lB\
l l l\.\
Name	Default	Access\
\\ \\ \\ \\ \\ \\ Class	\\ \\ \\ \\ \\ \\ Type\
_\
_/g
# from rmboxes
s/doublebox//g
s/allbox//g
s/box//g
s/, *, */,/g
s/ *, *;/;/g
s/^ *, *//g
s/|/ /g
}
END_THACK

    # 
    cat > $awk_tab << END_THACK
BEGIN {
    nline=0
    op="\\{"
    cl="'br\\}"
    do_dup=$dup_tables
}
/^\.TS/ {
    in_tab=1
    next
}
/^\.TE/ {
    if (in_tab == 0) {	# should not happen
	nline=0
	next
    }
    hack=0
    for (i=0; i<7; i++) {
	if (line[i] == "Name	Class	Type	Default	Access") hack=1
    }
    if (hack) {
	if (do_dup) printf ".ie n %s\n",op
	printf "...\\\\\" NROFF HACK START\n"
    }
    printf ".TS\n"
    for (i=0; i<nline; i++) { printf "%s\n",line[i] }
    printf ".TE\n"
    if (hack) printf "...\\\\\" NROFF HACK END\n",op

    if (hack && do_dup) {
	printf "%s\n.el %s\n...\\\\\" TROFF START\n.TS\n",cl,op
	for (i=0; i<nline; i++) { printf "%s\n",line[i] }
	printf ".TE\n%s\n",cl
	printf "...\\\\\" TROFF END\n",cl,op
    }
    in_tab=0
    nline=0
    next
}
{
    if (in_tab) {
	line[nline]=\$0
	nline=nline+1
    }
    else
	print \$0
}
END_THACK
    sed_tab_cmd="awk -f $awk_tab | sed -f $sed_tab"
fi

# __________________________________________________________________

# Check to be sure commands are there.  Complain if not.

#  handle things that are not set
if [ -z "$RMIFDEF" ]	; then RMIFDEF=rmifdef	; fi
if [ -z "$TBL" ]	; then TBL=tbl		; fi
if [ -z "$RMBOXES" ]	; then RMBOXES=rmboxes	; fi

if [ "$RMIFDEF" = "none" ]	; then RMIFDEF=""	; fi
if [ "$TBL" = "none" ]		; then TBL=""		; fi
if [ "$EQN" = "none" ]		; then EQN=""		; fi
if [ "$RMBOXES" = "none" ]	; then RMBOXES=""	; fi

for cmd in $TBL $EQN $RMIFDEF $RMBOXES ; do
    if [ "$cmd" = "none" ] ; then continue ; fi
    ( $cmd < /dev/null > /dev/null ) 2>>/dev/null
    if [ $? -ne 0 ] ; then
	echo ""
	echo "The '$cmd' command is not in your path or is inaccessible."
	echo "Please fix this and try again."
	exit 1
    fi
done

# Figure out the filters we'll use and construct the "pipe".

FILTER="$SOELIM | $RMIFDEF $DEFINES | $RMBOXES | $sed_tab_cmd | $TBL | $EQN | sed -f $TH_sed"

FILTER=`echo $FILTER | sed -e 's/|[ |]*/| /g' -e 's/^ *| *//'`

case "$Verbose" in 1) echo "Filter is: $FILTER" ;; esac

# __________________________________________________________________

case "$Verbose" in 1)
    cat << EOF

Summary of settings to be used:
    DOCROOT	= $DOCROOT
    sml_dir	= $sml_dir
    MANDIR	= $MANDIR
    TBL		= $TBL
    EQN		= $EQN
    do_catdir	= $do_catdir
    do_catman	= $do_catman
    do_mkwhatis	= $do_mkwhatis
    smart	= $smart
    offering	= $offering
    sml_insert	= $sml_insert
    sml_so	= $sml_so
    INSTALL	= $INSTALL

EOF
;; esac

case "$smart" in 0)
    echo ""
    echo "No more questions.  Ready to start processing (may take a while)."
    echo ""
    $echon "OK to continue? [y/n, default 'y']: "
    read a
    if [ "$a" = "n" ] ; then exit 0 ; fi
;; esac

if $fake ; then exit 0 ; fi
# __________________________________________________________________
# __________________________________________________________________

# Create man directories, if they're not there

if [ ! -d $MANDIR ] ; then
    if mkdir $MANDIR ; then true
    else echo "Could not create $MANDIR" ; exit 1
    fi
fi
for m in man1 man2 man3 man4 man5 man6 man7 man8 manl ; do
    if [ ! -d $MANDIR/$m ] ; then
	if mkdir $MANDIR/$m ; then true
	else echo "Could not create $MANDIR/$m" ; exit 1
	fi
    fi
done

if $do_catdir ; then
    ( cd $MANDIR
    mkdir cat1 cat2 cat3 cat4 cat5 cat6 cat7 cat8 catl 2>>/dev/null
    chmod 777 cat1 cat2 cat3 cat4 cat5 cat6 cat7 cat8 catl 2>>/dev/null  )
fi


# __________________________________________________________________

# This is what we will insert after the .TH
# We get rid of comments and extra white space (blanks and tabs).

if $sml_insert ; then
    echo '...\" ______________ start of SML macros ______________' > $smlinc
    (cd $sml_dir ; cat header.all sml rsml ) | 
	sed -e '/^\.\.\.\\/d' \
	    -e 's/\\[ 	]*\\\".*/\\ /' -e 's/[ 	]*\\\".*//' \
	    -e '/\.d[es] [A-Za-z][A-Za-z]$/s/ //' \
	    -e 's/^\.	/./' \
	    -e 's/\.el /.el/' -e 's/\.if /.if/' -e 's/\.ie /.ie/' \
		>> $smlinc
    echo '...\"'  >> $smlinc
    echo '.rm zA' >> $smlinc
    echo '.rm zZ' >> $smlinc
    echo '...\" ______________ end of SML macros ______________' >> $smlinc
elif $sml_so ; then
    echo '...\"'			> $smlinc
    echo ".so $sml_dir/header.all"	>> $smlinc
    echo ".so $sml_dir/sml"		>> $smlinc
    echo ".so $sml_dir/rsml"		>> $smlinc
    echo '...\" ____'			>> $smlinc
fi

# __________________________________________________________________

# Create sed script to  insert the file created above after the .TH
# (if appropriate) and expand troff strings into book names. Source of
# data is bookdefs.mac file.  Steps:
#   get all lines starting with ".ds",
#   get rid of comments, make last char ":"
#   change \ to \\
#   change ".ds " to "\\\*("
#   change " " to ":"
#  e.g. change:
#    .ds Rc \fIOSF/1 Command Reference\fP\"	\"OSCommandRef
#  to:
#    s:\\\*(Rc:\\fIOSF/1 Command Reference\\fP:

if $sml_insert || $sml_so ; then
    cat << EOF > $TH_sed
/^\\.TH/r $smlinc
EOF
fi

if [ "$bookdefs" != "none" ] ; then
    egrep -e '^\.ds' < $bookdefs | \
	sed -e 's/\\".*//'		\
	    -e 's/\\/\\\\/g'		\
	    -e 's/\.ds /s:\\\\\\*\(/'	\
	    -e 's/ /:/'			\
	    -e 's/$/:/'			>> $TH_sed
fi

# __________________________________________________________________

# Now do the work.  cat each source file thru the filters, depositing
# in a temp directory.  Then install it (the install mechanism is
# settable) the man directory.

N=`(for d in $SourceList ; do (cd $d ; ls *.[0-9l]*) ; done ) |wc -l`
mkdir $instmp

for d in $SourceList ; do
    echo ""
    echo $N files remain to be processed.
    n=`(cd $d ; ls *.[0-9l]* |wc -l)`
    N=`expr $N - $n`
    echo Now processing $d - $n files
    ( cd $d
    for m in *.[0-9l]* ; do
	case "$verbose" in 1) echo "    Doing $m" ;; esac
	dir=$MANDIR/man`echo $m | sed -e 's/^.*\.\([0-9l]\).*/\1/'`
	(eval "cat $m | $FILTER") > $instmp/$m
	th="` egrep '^\.TH' $instmp/$m`"
	if [ -n "$th" ] ; then
	    rm -f $dir/$m
#	    (cd $instmp
	    cd $instmp
	    case "$exp_names" in 1)
		#  Get the name from first argument of the TH line  (assume
		#  that the name has no spaces)
		suff=`echo $m |sed -e 's/^.*\.//'`
		new=`echo $th | sed -e 's/^\.TH  *//' -e 's/ .*$//' -e 's/"//g`
		#  test that we haven't got the null string
		if [ ! -n "$new" ] ; then
		    echo "Error: No name in .TH line in file $m"
		fi
		if [ "$new.$suff" != "$m" ] ; then
		    case "$verbose" in 1) echo "Expand $m to $new.$suff" ;; esac
		    mv $m $new.$suff
		    m=$new.$suff
		fi
	    ;; esac
	    case "$simple_suff" in 1)
		mm=$m
		m=`echo $m | sed -e 's/[A-Za-z]*$//'`
		mv $mm $m
		case "$verbose" in 1) echo "Rename $mm to $m" ;; esac
	    ;; esac
#	    $INSTALL $m $dir/. )
	    $INSTALL $m $dir/.
	    cd $d
	else
	    case "$verbose" in 1) echo "Removing 0-length file $m" ;; esac
	    rm -f $instmp/$m
	fi
    done )
done

# __________________________________________________________________

#  Do the "links" (e.g. vi.1, view.1, ex.1 are the same file).
#  We read what we want linked/referenced from a file.

if [ -n "$LinkList" -a "$LinkList" != "none" ] ; then
    case "$verbose" in 1) echo "" ;; esac
    sed -e '/^#/d' -e '/^$/d' $LinkList |
	( cd $MANDIR ; while read file1 file2 ; do
		if [ -f $file1 ] ; then
		    case "$Verbose" in 1) echo "Linking $file2 to $file1" ;;esac
		    rm -f $file2
		    if $solink ; then
			echo ".so $file1" > $file2
		    else
			ln $file1 $file2
		    fi
		else
		    echo "Can not link $file2 to $file1.  $file1 is missing."
		fi
	    done
	)
fi

# __________________________________________________________________

case "$smart" in
  1)
    case "$verbose" in 1) echo "Skipping catman and mkwhatis commands." ;; esac
  ;;
  0)
    MANPATH=$MANDIR ; export MANPATH	# catman looks at MANPATH
    if $do_catman ; then
	( cd $MANDIR
	$echon "Running catman (may take a while)..."
	$CATMAN 12345678
	echo "done."  )
    fi
    if $do_mkwhatis ; then
	( cd $MANDIR
	$echon "Running mkwhatis (may take a while)..."
	$MKWHATIS
	echo "done."  )
    fi
  ;;
esac

# __________________________________________________________________

