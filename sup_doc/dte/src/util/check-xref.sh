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
# $Log: check-xref.sh,v $
# Revision 1.1.2.6  1994/06/24  15:49:27  fred
# 	free copyright
# 	[1994/06/24  15:44:02  fred]
#
# Revision 1.1.2.5  1994/06/23  18:42:39  fred
# 	free copyright
# 	[1994/06/22  20:18:26  fred]
# 
# Revision 1.1.2.4  1993/05/18  12:51:31  bowe
# 	Use "nawk" instead of "gawk".
# 	[1993/05/18  12:50:50  bowe]
# 
# Revision 1.1.2.3  1993/04/10  00:18:01  bowe
# 	Add OSF copyright.
# 	[1993/04/10  00:16:56  bowe]
# 
# Revision 1.1.2.2  1992/07/07  13:45:44  bowe
# 	Initial rev.
# 	[1992/07/07  13:44:24  bowe]
# 
# $EndLog$
#
#  $Header: /u1/rcs/dte/util/check-xref.sh,v 1.1.2.6 1994/06/24 15:49:27 fred Exp $
#
#  Program to check validity of cross references in manpages (i.e. the
#  See Also -type section).  Some features:
#	Use all files in man heirarchy or a list of user-specified files.
#	Only pays attention to the string RELATED FEATURES (not SEE ALSO).
#	Optionally checks circular references (aaa.1 refers to bbb.1 and
#	    vice versa).
#
# ____________________________________________________________________________

do_help=false
verbose=false
Verbose=false
circular=false
check=true
cmd=`basename $0`
men="man1 man2 man3 man4 man5 man6 man7 man8"
man_dir=.
files=""
filelist=""

tmp=/tmp/refs.X.$$
sd=/tmp/sd.X.$$
flist=/tmp/fl.X.$$
circ=/tmp/circ.X.$$

trap 'rm -f $tmp $sd $flist $circ; exit $?' 0 1 2 3 15

while [ $# -gt 0 ] ; do
    case "$1" in
	-V)		verbose=true	;;
	-v)		verbose=true ; Verbose=true	;;
	-help)		do_help=true	;;
	-nocheck)	check=false	;;
	-cir*)		circular=true	;;
	-man)		shift ; man_dir=$1	;;
	-F)		shift ; filelist=$1	;;
	-*)		echo "Illegal option: $1.  Ignored."	;;
	*)		files="$files $1"	;;
    esac
    shift
done

if $do_help ; then
    cat << E_O_F
Usage: $cmd [-v] [-help] [-circ] [-man dir] [file ...]

The $cmd command will check manpage cross-references.

Options:
    -v		Verbose mode.  Print more messages as checking progresses.
    -man dir	Use <dir> as the root of the man heirarchy [default .].
    -circ	Print circular references.
    -F file	Use <file> as a file containing the list of files to check.
    file	List of files to check.
    -help	Print this help message.

If you do not specify a list of files, it is assumed that to want to check
starting at the root of a man file tree (e.g. /usr/share/man).

E_O_F
    exit 0
fi

# _______________________________________________________________________

if [ ! -d $man_dir ] ; then
    echo "Man root directory '$man_dir' does not exist."
    exit 1
fi
cd $man_dir

# _______________________________________________________________________

if [ -z "$files" ] ; then
    if [ -n "$filelist" ] ; then
	cp $filelist $flist
    else
	# Make a list of all files - to be used later
	if $verbose ; then echo "Finding list of files we're interested in" ; fi
	find $men -type f -name '*.[1-8]*' -print > $flist
	if $verbose ; then echo "There are" `cat $flist|wc -l` "man files." ; fi
    fi
else
    # create a file with the list of files to check
    touch $flist
    for f in $files ; do echo $f >> $flist ; done
fi

# _______________________________________________________________________

#  for convenience
cat > $sd << S_E_D
/^\./d
s/Commands: *//
s/Command: *//
s/Files: *//
s/File: *//
s/Functions: *//
s/Function: *//
s/Interfaces: *//
s/Interface: *//
s/Subroutines: *//
s/Subroutine: *//
s/Daemons: *//
s/Daemon: *//
s/Calls: *//
s/Call: *//
s/\. *$//
s/\, *$//
s/\\\\\*.//g
s/, */\\
/g
s/ /\\
/g
S_E_D

if $verbose ; then echo "Finding 'RELATED INFO' parts of files" ; fi

cat $flist | while read f ; do

    sed -n -e '/^\.SH RELATED IN/,/^.SH/p' $f | egrep '\([1-8][A-z]*\)' |
	sed -f $sd | sed -e "s,^,$f:	," 

done | sed -e '/^$/d' > $tmp

# _______________________________________________________________________

if $verbose ; then echo "Checking cross references" ; fi

if $circular ; then touch $circ ; fi

cat $tmp | while read file seealso ; do
    f=`echo $seealso | sed -e 's/(.*$//'`
    n=`echo $seealso | sed -e 's/.*(\(.*\)).*$/\1/'`
    if $Verbose ; then echo "trying $file $seealso ..." ; fi
    fn="man$n/$f.$n"
    if $check ; then
	if egrep "^$fn" $flist >/dev/null ; then
	    true
	else
	    echo "Bad reference in $file	$seealso"
	fi
    fi
    if $circular ; then
	cf=`echo $file | sed -e 's:^.*/::' -e 's/\.\([1-8]\):$/.\1.$/'`
	cf2=`echo $file | sed -e 's:^.*/::' -e 's/\.\([1-8]\):$/(\1)/'`
	if egrep "$fn:.*$cf" $tmp >/dev/null ; then
	    echo "good $cf2 $seealso" >> $circ
	else
	    echo "bad $cf2 $seealso" >> $circ
	fi
    fi
done

if $circular ; then
    echo ""
    grep '^good' $circ | nawk '
    $1 < $2 { printf "%s\t%s\n", $2, $3 ; next }
    { printf "%s\t%s\n", $3, $2 ; next }
    ' | sort -u | sed -e 's,^,Circular ref: ,'
    echo ""
    grep '^bad' $circ | nawk '
    $1 < $2 { printf "%s\t%s\n", $2, $3 ; next }
    { printf "%s\t%s\n", $3, $2 ; next }
    ' | sort -u | sed -e 's,^,Missing circular ref: ,'
fi

date
