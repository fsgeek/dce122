...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\"  @OSF_FREE_COPYRIGHT@
...\"
...\" HISTORY
...\" $Log: appb.mm,v $
...\" Revision 1.1.2.7  1994/06/24  15:16:05  fred
...\" 	free copyright
...\" 	[1994/06/23  20:15:13  fred]
...\"
...\" Revision 1.1.2.6  1994/06/23  18:40:01  fred
...\" 	free copyright
...\" 	[1994/06/22  19:34:03  fred]
...\" 
...\" Revision 1.1.2.5  1993/04/10  01:22:38  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  01:20:19  bowe]
...\" 
...\" Revision 1.1.2.4  1992/05/28  18:20:26  bowe
...\" 	Fix botched initial check-in.
...\" 	[1992/05/28  18:15:49  bowe]
...\" 
...\" Revision 1.1.2.3  1992/05/28  17:56:03  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:53:37  bowe]
...\" 
...\" Revision 1.1.2.2  1992/05/28  16:49:37  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:46:38  bowe]
...\" 
...\" $EndLog$
...\" _________________________________________________________________
...\"
.H 1 "Postscript Inclusion"
.P
.PF "''- \\\\nP -''"
In the dawn of document processing writers used scissors and
glue to cut and paste figures into a document.  Today
we use electronic scissors and glue to perform the same
task prior to the page reaching the printer.  Some WYSIWIG 
systems provide compound document capabilities, in which you
can use the same editing environment to create graphics
as to create text; in other environments you need to create
graphics separately and then include it in text.
.P
Here at OSF we are constrained to use a "portable" means
of electronic cutting and pasting.  So, 
we use the scissors of
.B troff
and PostScript to create space
in a document for a figure, and the glue of special processing
filters to include a PostScript figure in that space.
.P
The basic steps to including a PostScript figure are as follows:
.BL
.LI
Create a PostScript figure.
.LI
Prepare the figure for inclusion.
.LI
Create space in the
.B troff
document.
.LI
Include the figure in the document so that
the PostScript code is passed through the
.B troff
processing.
.LE
.P
This chapter describes the whys behind each of
these steps and gives a detailed procedure of each.  For
licensees, the steps that we use to create Postscript figures
at OSF are provided just for information; your environment
may be different.  Read these sections for background; you
may find most useful the information that about debugging
Postscript inclusion problems, at the end. 
.H 2 "Creating a PostScript Figure"
.P
At OSF PostScript figures are usually created either
using a drawing program or by making a screen dump image.
Drawing programs that output in PostScript format are
available for the Macintosh (MacDraw, Adobe Illustrator,
and Super Paint 2), and a few are available for
UNIX systems (idraw on a PMAX).  You may also get
PostScript files from vendor sources are
created with any number of different drawing packages.
.H 3 "Creating an xwd File"
.P
The other common method of creating PostScript figures is
by making a screen dump image using the X11 release 4 programs
.BR xwd
and
.BR xpr .
The process is to make a screen dump file in xwd format using the
.B xwd
command, then convert the xwd file to PostScript using the
.B xpr
command.  The
.B xwd
command has the following general syntax.
.DS I F
\fBxwd\fP
[\fB-help\fP]
[\fB-out\fP \fIfile\fP]
[\fB-frame\fP]
.DE
.P
There are more options to
.BR xwd ,
but they are not often used.  See the manual
page for a full list of options.
The
.B -help
option displays a syntax line.  The
.B -out
option specifies an output file.  Output is otherwise
sent to the standard output.
The
.B -frame
option causes
.B xwd
to dump the window manager frame as well as the contents
of the window.
.P
After entering the
.B xwd
command the pointer is changed to a crosshair cursor for
you to choose the window whose contents you want to dump.
Note that
.B xwd
dumps the an image of the visible screen area bounded by the
window you click in, therefore if the window you click in
is obscured by another window, you will dump an image of the
obstructing window bounded by the selected window.  You can
use this to your advantage to dump only a small portion of a
larger window by purposely obscuring most of a small window
with a larger window.  The small window should be placed below
the portion of the large window you want to dump as show in
the figure below.
.br
.ne 1.5i
.PS
scale = 8
move down 4
line down 4
line right 1
line up 4
line left 1
move right 1
line dashed right 4
line dashed down 4
line dashed left 4
line down 4
line right 12
line up 12
line left 12
line down 4
.PE
.P
To dump just the contents of a window issue the command.
.DS I F
\f(CWxwd -out outfile.wd\fP
.DE
.P
To dump the contents of a window as well as the window's
window manager border issue the command.
.DS I F
\f(CWxwd -frame -out outfile.wd\fP
.DE 
.H 3 "Creating a PostScript File From xwd"
.P
Once you have an xwd format file you can 
#ifdef osf
edit it using the
.B xgedit
program on an HP workstation, or 
convert it to PostScript
for inclusion in a document using the
.B xpr
command.
#else
convert it to PostScript
for inclusion in a document using the
.B xpr
command.
#endif
The
.B xpr
command has the following general syntax:
.DS I F
\fBxpr\fP
[\fB-device ps\fP]
[\fB-scale\fP \fIscale\fP]
[\fB-landscape|portrait\fP]
[\fB-gray 1|2|3|4\fP]
[\fB-compact\fP]
[\fB-output\fP \fIfile\fP]
[\fB-psfig\fP]
[\fIinput.file\fP]
.DE
.P
There are more options to
.BR xpr ,
but they are not often used.  See the manual
page for a full list of options.
The
.B -device
option defines for which device type to create the file.
You should always specify
.BR ps .
.P
The
.B -scale
option specifies a multiplier to scale the image by.  By default
the image is scaled to the largest size that will fit on an
8.5x11 page, so you will most often set the scale to 1 to avoid this.
.P
The
.B -landscape|portrait
options specify whether the image is rendered in landscape or
portrait mode.  Landscape is the default, so you will need to specify
portrait.
.P
The
.B -gray
option specifies the gray scale conversion for a color image.
The number specifies the number of square blocks used to represent
each color.  So a gray scale of 1 creates a black and white image,
and a gray scale of 4 creates the widest range of shades.  Because
it takes more pixels to represent larger gray scales, your image
will also be scaled by the gray scale value.
.P
The 
.B -compact
option cause a simple white space compaction algorithm to be used
in the image.  This saves disk space at the cost of significantly
longer processing time.
.P
The
.B -output
option specifies an output file.  Note that the same option is
called
.B -out
in the
.B xwd
command.
.P
The
.B -psfig
option prepares the image for PostScript inclusion by moving its
origin to the lower left corner of the page.  This obscures
part of the image when it is printed outside of a document, but
is necessary for including the image in a document.
.P
To convert an xwd file to postscript you will usually use the
following command.
.DS I F
\f(CWxpr -device ps -scale 1 -portrait -gray 4\e
.br
.in +5n
-output file.ps -psfig file.wd\fP
.in -5n
.DE
.br
.ne 5i
.H 3 "Setting the Screen Colors"
.P
The quality of the PostScript file that results from using
.B xwd
and
.B xpr
will depend greatly on the colors used in the window you take
the dump from.  This is because various colors are converted into
different gray scale values.  Be careful when choosing colors that
the colors look good once reduced for publishing as well as in full
size for draft format.  The changes to an
.B \&.Xdefaults
file for a good set of colors is as follows.
.DS I F
\f(CW
.nf
*Foreground:                  Black
*Background:                  Tan
*BorderColor:                 Tan
*topShadowColor:              Yellow
*bottomShadowColor:           CadetBlue
xterm*background:             Tan
xterm*foreground:             Black
xterm*cursorColor:            Black
xterm*pointerColor:           Black
Mwm*background:               Tan
Mwm*foreground:               Black
Mwm*topShadowColor:           Yellow
Mwm*bottomShadowColor:        CadetBlue
Mwm*activeBackground:         Tan
Mwm*activeTopShadowColor:     Yellow
Mwm*activeBottomShadowColor:  CadetBlue
Mwm*menu*background:          Tan
Mwm*menu*foreground:          Black
Mwm*iconbox*selectColor:      Black
Mwm*makeColors:               true
.fi
\fP
.DE
.P
These colors are only tested on a color HP workstation.  If
you are using a different workstation to make the window dumps,
you can test the colors by printing a window dump of a color demo
program and comparing the colors on paper.  Don't forget to consider
the effects of reducing the image for published production.
.H 2 "Preparing a PostScript Figure"
.P
Contrary to popular belief, it is not necessary for a document to
be in Encapsulated PostScript (EPS) format to be included in a
document.  EPS is a fancy industry buzzword used mostly by people
who are unfamiliar with the inclusion process.
It simply means that the PostScript file conforms to some very
specific rules so that it can be included in other PostScript
files.  Those rules include comment conventions, limitations on
the PostScript command set, and placing the
origin of the file at the lower left corner of the page.
These conventions are necessary to insure automated inclusion
of any file into any other, but are not completely necessary
for our purposes.
.P
You need the following things to be true in a PostScript file
for it to be suitable for inclusion in a document.
.BL
.LI
The lower left corner of the figure must be
at the lower left corner of the page.
.LI
The figure must take up less space than the text area
of the page.
.LI
The processing of the figure must not cause global changes
to the PostScript environment.  This is usually done by
saving and restoring the graphics state of the document
before and after processing the image.
.LE
.P
All EPS files satisfy these conditions with one small exception.
Some EPS files define the lower left corner of the figure to
be separated from the drawn area by some amount of space.
.P
In most cases the only processing that needs to be done to
a PostScript file is to translate the figures origin to the
lower left corner of the page.  This is done with the
.B translate
command in PostScript.
It has the following syntax.
.DS I F
\fIxdistance ydistance\fP \fBtranslate\fP
.DE
.P
This command moves the origin of the image, which is usually at
the lower left corner of the image (but it doesn't matter),
the distance specified by
.I xdistance
and
.I ydistance
around the plane of the page.  That is, positive movement is
usually away from the lower left corner of the page.  (This is
not always true since the coordinate system can change, but it is
an excellent first try.)
.P
The first step to translating the figure is to measure the
horizontal and vertical distances
from the lower left corner of the figure to the lower left corner
of the paper.  Then add the translate command in the proper
place in the postscript file.  It should usually directly follow 
the line.
.DS I F
\f(CW%%EndComments\fP
.DE
.P
It is better to place the translate command as early as possible
in the text, so that there is less chance of interaction with the
rest of the PostScript code.  If the translate command follows
the %%EndComments line, the basic unit of distance should be 1/72
of an inch.  This means that you will need to convert you distance
measurements to picas, or let PostScript do it for you.  For example,
if you need to translate the figure 2.3 inches down and 1.4 inches
to the left, you should add the following line after the %%EndComments
line.
.DS I F
\f(CW1.4 72 mul 2.3  72 mul translate\fP
.DE
.P
Note that PostScript is a stack machine, so the previous line
pushes the stack as follows.
.DS I F
.nf
\f(CW
         mul                     mul     translate
1.4 |  72 | 100.8 |   2.3 |    72 | 165.6    |    NULL |
    | 1.4 |       | 100.8 |   2.3 | 100.8    |         |
    |     |       |       | 100.8 |          |         |
\fP
.fi
.DE
.P
Because of the large possibility of scale and coordinate
changes, you should always test print these changes and make
adjustments as necessary.  You should note that 1/8th of
an inch on either side will not make a significant difference
in the final results of placement in the document.
.P
If this simple translate does not work, you will need to learn
a bit more about PostScript to fix the problem.  First step,
find someone who already knows a little about PostScript and
ask for their help.  If that fails, you can refer to the three
books written by Adobe for help:
.IR "PostScript Language Reference Manual" (Red),
.IR "PostScript Language Tutorial and Cookbook" (Blue),
and
.IR "PostScript Language Program Design" (Green).
.P
The PostScript file should now be ready for inclusion in
a
.B troff
document.  It will not be ready for printing alone.
You need to retranslate the image off the edge of the page
if you want to print it separately.  This can be done with
a standard script that adds a new line directly following
the %%EndComments line to translate the image up and over
so that it is out of the printers dead space.  The
program,
.BR printfig ,
that does this is show in the following listing.  It sends
output to the standard output, which can be redirected to
a new file or to a printer.  This script also adds the name
of the file to the page for reference.
.DS I F
.nf
\f(CW
#!/bin/sh
#
#  Puts the following text after %%EndComments
#  This make an EPS file printable.
#  The results are sent to stdio.
#
#  %%EndComments
#  gsave
#  /Times-Roman findfont
#  12 scalefont setfont
#  72 72 moveto
#  (<dirname>/<filename>) show
#  grestore
#  72 144 translate
#
for file
do
cd `dirname $file`
cwd=`pwd`
full=$cwd/`basename $file`
part=./`echo $full|cut -f5- -d/`
sed "
/%%EndComments/a\e
gsave\e
/Times-Roman findfont\e
12 scalefont setfont\e
72 72 moveto\e
($part) show\e
grestore\e
72 144 translate" `basename $file`
done
\fP
.fi
.DE
.H 2 "Creating Space in Troff"
.P
Once you have a figure to include in the
.B troff
source
of a document, you need to save space for it in the
document.  This is done vertically using the
.B \&.ne
and
.B \&.sp
.B troff
primitives.
The space made with
.B \&.sp
should be exactly the height of the figure.  (Don't forget
the units.)  The space reserved for the figure on the page by
.B \&.ne
should be about a quarter of an inch more than the height
of the figure to include space for the figure title.
The horizontal space is made by centering the figure in
the text area of the page with the
.B \&.in
.B troff
primitive.  The amount of indent is calculated as
half the difference between the width of the page and the
width of the figure as shown.
.DS
.nf
\f(CW
         ( page_width - figure_width )
indent = -----------------------------
                      2
\fP
.fi
.DE
.P
Absolute indents are based on the left margin of the
full text area.  Relative indents are based on the
current indent of the text area.
.P
You should also include a zero width character to anchor
the figure off of, such as
.BR \e0 .
This prevents a PostScript error whereby the figure is anchored
at the end of the strokepath of the last drawn page element
not the current position on the page.
.P
The following is an example of the space created for a figure
that is 1.75 inches high and 3.6 inches wide in a 6 inch text
area.
.DS
.nf
\f(CW
\&.\ .\ .  Figure 27-8 shows shows a typical figure
and how to include it.
\&.br
\&.ne 2i
\e0
\&.FG "A Typical Figure"
\&.sp 1.75i
\&.in +1.2i
<include figure here>
\&.in -1.2i
\&.P
Wasn't that a good figure?
\fP
.fi
.DE
.H 2 "Including a PostScript Figure"
.P
Including the PostScript figure in the space is
now a simple matter of using the
.B eroff
inclusion
macro,
.BR \&.P! ,
at the space provided in the text.
This macro takes a path name argument in the same way as
the
.B \&.so
.B troff
primitive.
To include the prepared PostScript file
.B graphics/typical.ps
in our previous example, use the following markup.
.DS
.nf
\f(CW
\&.\ .\ .  Figure 27-8 shows shows a typical figure
and how to include it.
\&.br
\&.ne 2i
\e0
\&.FG "A Typical Figure"
\&.sp 1.75i
\&.in +1.2i
\&.P! graphics/typical.ps
\&.in -1.2i
\&.P
Wasn't that a good figure?
\fP
.fi
.DE
.P
.ne 5i
The story would end here if it were not for the fact that
not all of our licensees use
.BR eroff .
The vast majority of
them use transcript or some variant.  In these systems it
is still possible to include PostScript files as show,
but they need to define the
.B \&.P!
macro to read in the PostScript file and pass it through to
the underlying PostScript processor.  This should be documented
in the release notes so that those licensees do not need to
resort to cut and paste.  The
.B \&.P!
macro should be redefined in a way similar to the following.
.DS
.nf
\f(CW
\&.de P!
\&\\\\&
\&.fl
\&\\\\!%PB
\&\\\\!/showpage{}def
\&.fl
\&.sy cat \\\\$1
\&\\\\!PE
\&\\\\!.
\&.sp \\\\$2
\&..
\fP
.fi
.DE
.P
Note in the release notes that this method will not work on
all systems, and that on some systems they will need to resort
to cut and paste.  You should always include hard copy figures
in the kit for those licensees who can not print PostScript.
