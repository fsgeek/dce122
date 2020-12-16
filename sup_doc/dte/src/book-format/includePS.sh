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
# $Log: includePS.sh,v $
# Revision 1.1.2.6  1994/06/23  19:48:57  fred
# 	free copyright
# 	[1994/06/23  19:43:22  fred]
#
# Revision 1.1.2.5  1994/06/23  18:37:47  fred
# 	free copyright
# 	[1994/06/22  15:29:32  fred]
# 
# Revision 1.1.2.4  1993/04/10  01:03:19  bowe
# 	Add OSF copyright.
# 	[1993/04/10  01:00:36  bowe]
# 
# Revision 1.1.2.3  1992/08/11  13:52:53  bowe
# 	Added ".rs" between .ne and .sp so page PS includes at top of a page
# 	come out right.  CR 4047.
# 	[1992/08/11  13:51:54  bowe]
# 
# Revision 1.1.2.2  1992/07/07  14:52:35  bowe
# 	Initial rev.
# 	[1992/07/07  14:48:48  bowe]
# 
# $EndLog$
#
#  $Header: /u1/rcs/dte/book-format/includePS.sh,v 1.1.2.6 1994/06/23 19:48:57 fred Exp $
#
#  Program to do either:
#	insert the string "%%BoundingBox: x1 y1 x2 y2" in file (-edit flag), or
#	send to stdout troff instructions for including the figure with caption
#	This second operation is meant to be called from a troff macro.

tmp=/tmp/bb-$$
bbpro=/tmp/bb-pro-$$
#bb_prolog=/some/file/...
file=""
do_edit=false

trap "rm -f $tmp $bbpro ; exit $?" 0 1 2 3 15

while [ $# -gt 0 ] ; do
    case "$1" in
	-edit)		do_edit=true ;;
	*)		file="$1"
			height="$2"
			width="$3"
			center="$4"
			break ;;
    esac
    shift
done

if [ -z "$file" ] ; then
    echo "ERROR: You must specify a file name." >&2
    exit 1
fi

bb=`egrep '^%%BoundingBox' $file | tail -1 | sed -e 's/%%BoundingBox://'`
if [ -z "$bb" ] ; then
    if [ ! -z "$height" -a ! -z "$width" ] ; then
	bb="0 0 $width $height"
    else
	echo "ERROR: '$file' is not a valid EPS-format file." >&2
#	gs -DNODISPLAY $bb_prolog < $file > /dev/null
	cat >$bbpro <<'BBEOF'
%! 
% bb.ps --
% Prints a file, but keeps track of bounding box info, and prints the box at
% the end (around the figure.)
250 dict dup /$BoundingBox exch def begin
/xdef { exch def } def
/xstore { exch store } def
/bb-pt+ { exch   4 -1 roll add   3 1 roll add } def

% Stubs of old functions.
/-stroke     /stroke     load def
/-fill       /fill       load def
/-eofill     /eofill     load def
/-image      /image      load def
/-show       /show       load def
/-awidthshow /awidthshow load def
/-showpage   /showpage   load def

% New Functions.
/stroke {
	gsave { flattenpath
	 	strokepath	% Make sure to take line width into account.
	} stopped {		% strokepath often hits a limitcheck.
		grestore	% Restore the original path
		gsave
	} if
	bb-path			% Accumulate it into our box.
	grestore
	-stroke
} def

/fill { gsave bb-path grestore -fill } def
/eofill { gsave bb-path grestore -eofill } def

% Text is implemented by reducing everything to an `awidthshow'.

/show {
	0 0 0 0 0		% Extra parameters for awidthshow
	6 -1 roll		% Bring the string back up
	awidthshow
} def

/widthshow {
	0 0			% Extra parameters for awidthshow
	3 -1 roll		% Bring the string back up.
	awidthshow
} def

/ashow { 0 0 0   6 3 roll   awidthshow } def

/awidthshow {
	5 dict begin
	gsave
	currentpoint
	2 copy /@starty xdef /@startx xdef
	2 index stringwidth	% Get the natural length of the string
	bb-pt+			% Add to the start to get the end.

	2 index length		% How many characters?

	dup			% Add the offsets to each character
	6 index mul
	exch 5 index mul
	bb-pt+

	5 index 3 index
	bb-chcount		% How many padding characters?

	dup			% Add the offsets for each pad.
	9 index mul
	exch 8 index mul
	bb-pt+

	/@endy xdef /@endx xdef

	bb-fontheight		% Get the height and depth of the current font.
	
	4 copy
	@startx @starty bb-pt+ bb-point
	@startx @starty bb-pt+ bb-point
	@endx @endy bb-pt+ bb-point
	@endx @endy bb-pt+ bb-point

	grestore
	end
	-awidthshow
} def

% `image':
% Assume here that the image lands in the unit square.
/image { 0 0 bb-point   1 1 bb-point   -image } def

% `showpage':
% Just draw the box around the figure and print the page, and then initialize
% the bounding box variables again.
/bb-string 10 string def
/showpage {
	initgraphics

	bb-llx bb-lly itransform 	% Convert them into default coords.
	bb-urx bb-ury itransform
	/bb-lly xstore /bb-urx xstore
	/bb-ury xstore /bb-llx xstore

	/Courier findfont 10 scalefont setfont

	/F (tmpBoundBox) (w) file def
	F (%%BoundingBox: ) writestring
	F bb-llx bb-string cvs writestring F ( ) writestring
	F bb-lly bb-string cvs writestring F ( ) writestring
	F bb-urx bb-string cvs writestring F ( ) writestring
	F bb-ury bb-string cvs writestring
	F (\012) writestring		% newline
	F (% WIDTH: ) writestring
	F bb-urx bb-llx sub 72 div bb-string cvs writestring
	F ( in\012) writestring
	F (% HEIGHT: ) writestring
	F bb-ury bb-lly sub 72 div bb-string cvs writestring
	F ( in\012) writestring
	F closefile

	bb-init
} def

% BoundingBox functions:
% We accumulate the information about the bounding box into four variables.
% The data is stored in device coordinates.
/bb-init {
	/bb-llx 99999 store   /bb-lly 99999 store
	/bb-urx -99999 store   /bb-ury -99999 store
} def

/bb-llx 0 def   /bb-lly 0 def   /bb-urx 0 def   /bb-ury 0 def

% x y `bb-point' -
% Takes a point in user coordinates and adds it into the bounding box info.
/bb-point {
	transform		% Convert to device coords.
	dup
	dup bb-lly lt {	/bb-lly xstore } { pop } ifelse
	dup bb-ury gt { /bb-ury xstore } { pop } ifelse
	dup
	dup bb-llx lt { /bb-llx xstore } { pop } ifelse
	dup bb-urx gt { /bb-urx xstore } { pop } ifelse
} def

% - `bb-path' -
% Incorporates the bounding box of the path into the bounding box info.
/bb-path {
	gsave
	{
		0 setlinejoin
		flattenpath
	} stopped {
		grestore
		gsave
	} if
	pathbbox
	bb-point
	bb-point
	grestore
} def

% A nice black-and white line drawing function.
/bb-bwstroke {
	0 setlinewidth			% Thinnest possible lines
	1 setgray			% White first
	[5] 0 setdash			% Only half the line
	gsave -stroke grestore
	0 setgray			% Then black
	[5] 5 setdash			% On the other half
	-stroke
} def

% Stuff for text.
% char-code string `bb-chcount' occurs
% Counts the number of times a character appears in a string.
/bb-chcount {
	0 exch
	{ 2 index eq { 1 add } if } forall
	exch pop
} def

% - `bb-fontheight' heightx heighty depthx depthy
% 
% Returns the offsets to the lowest point and highest point in the current
% font.
/bb-fontheight {
	currentfont begin
	FontBBox
	exch pop 0 exch
	FontMatrix transform
	4 2 roll
	exch pop 0 exch
	FontMatrix transform
	end
} def

% Start it up.
bb-init

BBEOF
#	gs -DNODISPLAY $bbpro < $file > /dev/null
#	There's a bug in gs 2.2 where you can't define multi-line functions
#	on stdin...
	gs -DNODISPLAY $bbpro $file </dev/null >/dev/null
	if [ $? -eq 0 ] ; then
	    echo "ERROR: Ghostscript, however, says BoundingBox is" >&2
	    echo "ERROR:   `egrep '^%%BoundingBox' tmpBoundBox`" >&2
	    bb=`egrep '^%%BoundingBox' tmpBoundBox | tail -1 | \
		sed -e 's/%%BoundingBox://'`
	    rm -f tmpBoundBox		# was created by gs
	else
	    echo "ERROR: Could not find Ghostscript (gs) in PATH." >&2
	fi
    fi
fi

# _____________________________________________________

if $do_edit ; then		# are we editing file to insert %%BoundingBox?

    ed - $file << END_EX
1
a
`echo $bb | awk ' {
printf "%%%%BoundingBox: 0 0 %.2f %.2f\n",$3-$1,$4-$2;
printf "-%.2f -%.2f translate\n",$1,$2;    }'`
% original bounding box was $bb
.
w
q
END_EX

else		# we are being called from a troff macro

    F="$file"; export F
    cat > ${tmp}A <<EOF
	{
	    if (\$5 != 0) {
		printf ".ne %s\n.rs\n.sp %s\n", \$5, \$5
	    }
	    else {
		h=(\$4-\$2)/72;
		printf ".ne %.2fi\n.rs\n.sp %.2fi\n", h, h
	    }
	    w2=(\$3-\$1)/72.0
	    # 7th arg is set to center figure in text area, not live area.
	    # 6th arg is set if user specifies width of figure
	    if (\$7 == 1) {
		if (\$6 != 0) printf ".in \\\\n(!!u+(\\\\n(.lu-%s)/2u\\n", \$6
		else printf ".in \\\\n(!!u+(\\\\n(.lu-%.2fi)/2u\\n", w2
	    }
	    else {
		if (\$6 != 0) printf ".in (\\\\n(.lu-%s)/2u\\n", \$6
		else printf ".in (\\\\n(.lu-%.2fi)/2u\\n", w2
	    }
	    printf ".P! %s\n", "$F"
	    printf ".in\n"
	}
EOF
    if [ -z "$height" ] ; then height=0 ; fi
    if [ -z "$width"  ] ; then width=0  ; fi
    if [ -z "$center" ] ; then center=0 ; fi
    if [ $center != "0" ] ; then center=1 ; fi
    echo $bb $height $width $center | awk -f ${tmp}A
    rm -f ${tmp}A

fi

