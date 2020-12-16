...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\"  @OSF_FREE_COPYRIGHT@
...\"
...\" HISTORY
...\" $Log: ch03.mm,v $
...\" Revision 1.1.2.7  1994/06/24  15:16:21  fred
...\" 	free copyright
...\" 	[1994/06/23  20:15:41  fred]
...\"
...\" Revision 1.1.2.6  1994/06/23  18:40:20  fred
...\" 	free copyright
...\" 	[1994/06/22  19:34:48  fred]
...\" 
...\" Revision 1.1.2.5  1993/04/10  01:22:51  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  01:20:36  bowe]
...\" 
...\" Revision 1.1.2.4  1992/05/28  18:20:42  bowe
...\" 	Fix botched initial check-in.
...\" 	[1992/05/28  18:16:27  bowe]
...\" 
...\" Revision 1.1.2.3  1992/05/28  17:56:19  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:53:37  bowe]
...\" 
...\" Revision 1.1.2.2  1992/05/28  16:50:07  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:47:30  bowe]
...\" 
...\" $EndLog$
...\" _________________________________________________________________
...\"
...\"build rmifdef tbl
...\"
.H 1 "Building Books"
.iX "building books"
.iX "another index entry"
.P
This chapter describes the features the build tools provide,
gives you an overview of how the tools operate, and describes
how to set up your build environment and use the tools. 
...\"*********************************************************************
...\"		Second-level head
...\"*********************************************************************
.H 2 "Features the Build Tools Provide"
.P
The build tools allow writers to build complete or
partial books. The tools provide many features common 
to publishing environments, such as:
.BL
.LI
the ability to build your books for on-line or
hard-copy display, with the layout format you
specify in a command-line option.  The 
build tools do not provide the layout;
rather, they call an appropriate set of
macro definitions, which provide the layout.
.LI
automatic numbering of sections, pages, and
chapters, as well as tables and figures.  Typically, you do not
need to set registers within your source files.  Besides
being easier for you, this
design makes your source files more modular,
so that OSF technology licensees can 
more easily integrate them
into other documents.
.LI
headers and footers that operate properly through
the book, without intervention on your part.  
.LI
a simple means of building the entire book, or pieces
of the book, with correct numbering in either case.  
.LI
flexibility in organizing the files that make up
your book.
.LI
conditional processing of books, so that you
can include information for two or more different
versions of a book. 
.LI
indexes and tables of contents, when you specify to
the build procedure that you want the book built
with these.
.LI
automatic generation of a glossary from the central
glossary files/database, when you specify to 
the build procedure that you want the book built
with it.
.LE
.P
Additional information
is produced as a vestige of the build procedure.  This
"synchronization information", about the values of registers
at particular states in the build process, is created separately,
and may make it easier to extend the tools to provide such
new features as cross-references to tables, figures, and sections.
#ifdef osf
#else
.P
Note that before you can use the build tools outside OSF, you need to
build and install them following the directions provided
in the release notes shipped with the tools.  In particular,
you must have set certain environment variables that define
command paths and other information.  
.I
Do not try to use
the DTE without first installing and building it
according to the directions in the release notes!
.R
#endif
.H 2 "How the Build Tools Work"
.P
Before you learn to build 
your books, you should understand
how the tools operate.  This is a brief overview.  Appendix A 
provides some additional information about the
internal operation of the tools.  Licensees who plan
to extend or modify the tools should consult Appendix A.
.P
The build tools operate in a directory you create for
your source files, and create various output files
in or under that directory.  The following table
summarizes the files and directories required and created
in the document source directory.
.P
.ne 15
.TB "Files and Directories in the Document Source Directory" 
.TS
center,box;
l | l. 
\fBFile/Directory	When/How Created\fR 
_
.TH
_
\&\fBDescription\fP file	By writer, before building
\&\fBHeaders\fP directory	By writer, before building
Source files	By writer, before building
\&\fBOutput\fP directory	By tools, during build
\&\fBSync\fP directory	By tools, during build
.TE
.P
The tools use the following as input:
.BL
.LI 
Your source files.  (As described in Chapter 2, these are likely
based either on source from a technology supplier that you have
modified, or our DTE templates).
.LI
A description file you create, which specifies the sequence you
want for these source
files within in your book, the "pieces" in which you want the 
build tools to build the book, and any special 
processing directions.
.LI
A header file directory you create, which specifies headers that are
used throughout the book (typically you specify only the book's title; chapter
heads also appear, as part of the default appearance).
.LI
Your directions (selected through command-line options)
about the output style you want for the book.
.LE
.P
Although the format of the description
file is simple, and the file is simple to create,
this structure provides flexibility for controlling 
the organization of your book, and for 
controlling the builds, since it lets
you specify the units (pieces) in
which the tools build the book.
You have the flexibility to create
your book from a small number of large files, or from a larger number
of small files.  You can choose to build your book in many small pieces,
or in several large pieces.  Finally, you can change the organization
easily whenever you want.
.P
Once you've set up your environment, you use the simple
.B book-format
command to build the book.  Options to this command let you choose 
whether you are building in draft or published format, and,
for draft-format documents, whether you want 
ASCII or PostScript output.
Other command-line options let you specify
whether to build all or part of the book.
.B book-format
invokes other tools that actually do the work of building your book. 
.P
Based on the directions just described, the build tools use the 
appropriate macros in 
.B tools/macros
and invoke appropriate text-processing commands,
such as
.B "tbl, pic, troff"
etc.,
to produce output in the style you requested.  The
output style comes from the macros selected.  The 
tools automatically include document-set-wide header files (such
as
.B "bookdefs"
.R )
so that you do not need to include 
.B ".so"
directives for these files.
.P
As part of the build process, the build tools 
place synchronization information in the 
.B Sync
directory.  This information is recorded at the
transitions between pieces.  Once the book is built once, and the synchronization
information recorded, you can rebuild any piece by itself, and the synchronization
information will be correct. 
.P
After processing, the build files produce a directory called
.B "Output"
in your book directory area.  This directory contains subdirectories for ASCII
or PostScript files, with your output files in the
subdirectories.  The files created are named as the
pieces that you specified in the description file.  You can 
print these files, keep them for your on-line use, put them in snapshots,
etc.
.P
.B book-format
does not invoke
.B dmm
and
.BR dman .
Although
.B dmm
and
.B dman
use the same macros as the 
book-building tools, they 
are primarily for building short documents that are
contained in one file.  For example, it's appropriate to build
project plans and individual man pages
with these tools.  They do not require a description file, and they
don't do anything special with registers except use the defaults.  This
chapter concentrates on the use of
.B book-format
rather than
.B dmm
and
.B dman.
.H 2 "Setting up Your Build Environment"
.P
Before you can build your book for the first time, you 
must set up your build environment.
This section describes how to set up your build environment,
including the following elements:
.BL
.LI
The source file directory
.LI
the description file
.LI
the header file directory
.LE
.P
The final subsection summarizes these steps. 
Although we've gone into some detail to describe the process, it's
quite simple.
Preparation of the directory and Description file for
this small book, for example, took ten minutes or so. 
.P
As you are using this section, you can refer to a
sample book directory in 
.BR "tools/dtedoc/dte_guide_src" .  
It contains
all the source files for this book. 
.H 3 "The Source File Directory"
.P
Create your source file directory in your working area for
your project.  This directory (we will call it
.I "bookdir" 
in this document) can have any name. 
You can put all your files directly into 
.I "bookdir"
or
separate them into subdirectories of 
.I "bookdir."
All the files you specify in the description
file will have pathnames relative to
.I "bookdir."
.H 3 "The Description File"
.P
The description file describes the "body" of the book that
the build tools process.  (Since the TOC and index are generated
automatically, you need not describe them in the description file). 
Optionally, the description file contains special instructions
for building with \fBbook-\fP\fBformat\fP.  These instructions are a
convenient way to insure that you always use certain
command-line options with
.BR book-format ; 
without these instructions, you
need to specify certain 
.B book-format 
options each time you run 
.BR book-format . 
.P
We can say that the description file has a piece description
section and a special instructions section.
The \fBdescription\fP(4) man page describes the format in detail; this
section summarizes how you create the parts of the
description file.  A sample description file is in the
\fBtools/dtedoc/dte_guide_src\fP
directory; you can copy this file for use in your books. 
.P
Create the description file in 
.I "bookdir"
with the name
.B "Description" 
(a default name; you use the
.B "book-format -des" 
option to override the default and use another name.
.B "Description" 
must be composed of lines of text; use # to start
a comment line, and use ## to start a special instructions
line.
.H 4 "The Piece Description Section"
.P
Each piece description section describes a
"piece" of the book's body. As you recall, the piece is the logical
unit used for building the book.  A
piece can be as large as a chapter or several chapters,
or as small as a section of one chapter.  Output files
created have the name
.I piece.output_type
where 
.I piece
is the name of the piece and
.I output_type
is an abbreviation for the type of
output file created (PostScript, text, etc.).
.P
Each piece description line specifies
the macro package that the piece requires, and, in order, the names
of the files that comprise the piece.  You can have one
or more files in each piece.  
.P
There are only four rules for separating your book into pieces:
.AL
.LI
Each piece must require only one macro package,
.BR "man" ,
.BR "rsml" ,
.BR "mm" ,  
.BR "mptx" ,
or
.BR "gpsml" .
This is important if your book will use a mixture of macro
packages, as the reference books do.  
.LI
The title/copyright page, preface, and appendices must each
be in pieces by themselves.  This is because you use a keyword
in the piece description line to tell the build tools to 
use particular 
page and section-numbering conventions for each of these pieces of
the book.
.LI
Do not include pieces for the glossary, index, or TOC.
These are produced automatically.  Do not name other
pieces glossary, index, or TOC, or the output files for
these pieces will be replaced by the automatically-generated
glossary, index and TOC. 
.LI
When formatted, the output file for each piece starts at the
top of a new page. If you don't want certain sections separated
in this way, keep these files in the same piece. 
.LE
.H 4 "Required Format of Piece Description Section Lines"
Each piece description line 
in the build file has the following required format.
.P
.DS I  \"*** I=standard indent
\fIpiece\fR \fB<Tab>\fR [ \fBmm\fR | \fBgpsml\fP | \fBman\fR | \fBrsml\fP ] \fB<Tab>\fR \fI{KEYWORD} file1 file 2....filen\fR 
.DE
.P
where KEYWORD, if present, has one of the following values: \fBFRONT\fP, \fBPREFACE\fP,
\fBAPPENDIX\fP, \fBGLOSSARY\fP, \fBUNNUMBERED\fP.
.P
As you can see, the required format
specifies three fields, each separated by at least 
one hard tab.  In the middle field
you specify the name of the macro package.  In the fields 
.I "piece" and 
.I "[KEYWORD] file1...filen" 
you name the piece and name the files that comprise the piece.  The KEYWORD
label, if present, indicates to the 
build tools that special numbering conventions
are required for the files in this piece:  
no page numbers for the \fBFRONT\fP (this is for title
and copyright pages), Roman numerals for the \fBPREFACE\fP (this is for the
preface), alphabetic page and section numbers for appendixes 
and unnumbered
heads for any file in which you want unnumbered heads.
Use these keywords
as described to label these parts of the book. 
.P
The filenames in the third field can be literal names,
wildcard specifiers, or output from a shell command line.
All names are relative to your build directory,
.I "bookdir".
.P
If an alphabetic sort of a directory is not sufficient, you
can sort across directories.  For example, the following description
file line takes files with the suffixes
\&.2 and .3 from the man2 and man3 directories, sorts them alphabetically,
and puts them both in a piece called \fBfunctions\fP:
.P
.DS I
.ft CW
functions	man	`ls man[23]/*.[23] | sort -t/ +1` 
.ft R
.DE
.P
The DTE does not enforce any restrictions on filenames; however,
for portability, keep filenames consistent, clear, and
less than 12 characters (the character restriction is
so that input files and output files, with their suffixes,
will be readable on a system that only recognizes 14-character
filenames.)
.H 4 "Special Instruction Section"
.P
The special instruction section in the description
file allows you to specify several
options to \fBbook-\fP\fBformat\fP; these options
are used whenever you process the book and save you
from explicitly specifying them from the command line.  See
the \fBdescription\fP(4) man page for complete information.  The
important ones to know are for definition of
symbols for conditional processing, for overriding
some of the default behavior of \fBbook-format -all\fP,
and for providing glossary information.  The sample description
file shows the special directions; you can
edit these as appropriate.
.P
If you would like to easily build your book with a
particular type of conditional processing, use one or more 
.BI "##DEFINE -D" SYMBOL
directives in the description file.  For example, if
you frequently build books for two software releases,
and have information that is conditionally included for
each release, you may want to have two 
description files, each with a
particular symbol definition.   (Alternatively, you
can use a 
.B book-format
option every time you process, or write a script
that invokes the tool with the proper option.)
.P
As we will see in the next section, with the
.B all
argument, 
.B book-format 
always attempts to build a glossary,
index, and table of contents (TOC). 
You can use description file directives to turn parts of this
processing on or off, and still be able to use
the
.B all
argument. For example, if you typically want to
build with a TOC and index, but with no glossary,
you can turn glossary processing off by default,
and build with 
.BR all .
See the manpage for
information about turning off TOC, index, and glossary
processing.
.P
When glossary processing is enabled,
you should use the
.B ##BOOK
directive to specify your book name; 
otherwise, 
.B book-format
always attempts to build a glossary using ALL the
entries in the glossary files!  You can also specify
this with a
.B book-format
command-line option; however, it is much simpler to do it
in the description file since your book name rarely changes.
.H 4 "Sample Description File and Discussion"
.P
Here is a sample description file, similar to the description
file used to build this book. 
.DS I  \"*** I=standard indent
.ft CW

# sample description file
front1  mm      FRONT title.mm
front2  mm      FRONT copyright.mm
front3  mm      PREFACE preface.mm
ch1     mm      ch01.mm
ch2     mm      ch02.mm
ch2sml  gpsml	ch02.sml
ch3     mm      ch03.mm
ch4     mm      ch04.mm
ch5     mm 	ch05.mm
ch6mm   mm	ch06.mm
ch6man	mm      ch06man/*.1 ch6man/*.4
apps    mm      APPENDIX appa.mm

#special instructions section

#conditional processing directives
#defines OSF as a conditional processing symbol
#This definition is for use when building for OSF use.
##DEFINE -DOSF

#Definition of book name
#from bookdefs.mac
#For use in glossary build
##BOOK OSProgRef 

#Turn off automatic processing for
#glossary, index, and TOC
##NO GLOSSARY
##NO INDEX 
##NO TOC
.ft R
.DE
.P
As you can see, this file uses several types of pieces.  Some pieces
(ch1, ch2, ch3...) 
consist only of one file, each containing one chapter.  The frontmatter
is arranged in three separate pieces.  Chapter 6, which contains both
mm and man macros, is arranged to format in two pieces.  Note that the piece 
ch6man 
lists its included files with a wildcard.
Because of the wildcard, the build tool
will arrange the man pages
in alphabetical order, which is the normal order for man pages.  If, for
some reason, you wanted to order the pages differently, you could specify
explicit individual filenames in this field.  The appendixes build as 
one piece; note that this piece description lists the names of its files rather
than using a wildcard.
.P 
As you can see, this sample file turns off glossary, index, and
TOC processing.  
.H 4 "Choosing Appropriate-Sized Pieces"
.P
Organize your book into pieces as makes sense for you.
Since you can rebuild a piece at a time, consider the
size that might be convenient for you in rebuilding.  Your pieces could
be related to the order in which you are writing pieces, or the
order in which you are sending material out for review.  You can, of
course, change the description file at any time in the writing process.
.P
You can have as many files as you like within a piece,
up to the limits allowed by the shell in which
you run 
.BR book-format .  
One possible
organizational method is to construct pieces of fairly
large logical entities, such as chapters or parts of chapters, and a number
of files making up each piece.  
.P
If there is a reason to keep files separate,
the description file mechanism lets you do it.  
Because of the robust synchronization
mechanism, you don't have to worry about register information
when you use a number of files to create one logical entity.
.P
For example, you might want
to have sections of a chapter in separate files, because you think that
OSF source licensees are likely to want to put separate modules into
an on-line documentation system.  
.P
...\"*********************************************************************
.H 3 "The Header File Directory"
.P
Create a directory called 
.B Headers
in your book directory
bookdir, and create files in this directory for
as many macro packages as you are using.  They must be named:
.B header.mm
and
.B header.man.
A sample exists in 
.BR "tools/dtedoc/dte_guide_src" . 
.P 
The format of this template file currently is very simple; it just specifies the
title of the book, which is used as one of the headers throughout the book. 
Put your title in the appropriate place.
.ig ++
.H 3 "Optional comment lines"
.P
By default, the build tools invoke all possible text-processing
tools.  You can speed up processing time, especially for a long book,
by specifying at the top of each source file the tools required to
process the file.  For example, if a file requires use of
.B n/troff 
with 
.B mm 
macros and
.B tbl
only, you can specify this to tell the build tools not to invoke
.B n/troff 
with 
.B man
macros,  
.B eqn
and
.B pic
when formatting the file.  Use the following format to specify this:
(to be added).
.DS I
\...\\" \fBbuild\fR [ \fBtbl\fR | \fBeqn\fR | \fBpic\fR | \fB-mm\fR | \fB-man\fR ] \fIoptions\fR "_"
.DE
.++
.H 4 "Summary of Build Environment Creation Steps"
.P
Here's a brief summary of the steps you need to go through to set up
your build environment for a book.  Refer back through the chapter for
information about each step.
.AL
.LI
Create the build directory and put your source files into it.
.LI
Prepare your description file.  Move source files around, if
necessary.  Check to ensure the columns in the 
piece description lines are hard-tab-separated.
.LI
Prepare your Headers directory and header files.
.LI
Put build instructions at the top of your source files, if you like. 
. LE
.H 2 "Building the Book"
.P
Once you have set up your build environment, you can build the book.
To do this, you use 
.B book-format 
with the proper options.
Chapter 6 contains a manual page for 
.B book-format
as well as other DTE manual pages.
.P
.B book-format 
organizes its output into "body" files (these are part of the body
of the book) and, if you specify, index, 
glossary and toc files.  Each body file
has the name of the piece from which it was created, so a piece named
\fBch1\fP 
produces the output file 
.BI ch1. [suffix]
where suffix is blank (for nroff output) or
\&.ps (for PostScript output.) 
.P
All the output created is in the
.B Output
directory, by default (unless you
use the -output option to
change the name of the destination
directory.)  
Within the 
.B publish
or
.B draft
subdirectory under the output directory, 
the output files are in the
.BR ps ,
.BR ascii,
or
.B dito
subdirectory. 
.P
As described earlier, all OSF documentation shipped
to licensees uses draft layout style only.
.H 3 "Building for the First Time"
The first time you build your book, you should build the entire body
of the book, in order to produce the synchronization information in
the \fBSync\fP directory.  Subsequently, you can 
build any of the pieces you specified
in the description file, and they will have the proper synchronization
information.  To build the entire body, first go to your book directory,
and then invoke
.B book-format
with the
.B body
argument, as follows:  
.P
.DS I F \"*** I=standard indent; F=fill
.B "cd "
.I "bookdir"
.P
.B "book-format "
.I "[options]
.B "body"
.DE
.P
.B "book-format"
displays a status message as it builds each piece.
The
.B book-format
manpage includes complete information about options
and arguments; the remainder of this section highlights
important options.
.P
The next section describes how you change the defaults
using 
.B book-format 
options.
.H 3 "Changing the Layout and Processing Defaults"
By default,
.B book-format
uses 
.B troff 
and the "publish" layout, 
creating PostScript files, each of which have a \fB.ps\fP suffix.
Use the 
.B -n 
and/or 
.B -d
options to specify use of nroff and draft layout, respectively.
(Note that "publish" layout is only used inside OSF.)
Use the
.B -sml
option to build with SML.
.H 3 "Building the Entire Book"
.P
You can build the entire book, including TOC, index and glossary, at any time.
A simple way to do this is to use the
.B all
argument to
.B book-format 
as shown below:
.DS I F \"*** I=standard indent; F=fill
.B "book-format "
.I "other options"
.B "all"
.DE
Use a combination of the
.BR body ,
.BR index , 
.BR glossary ,
and
.B toc 
arguments, or the 
.B all
argument, to specify which parts of the book you want built.
.H 3 "Building Pieces of the Book"
.P
After arranging your book in pieces, you can take advantage of the
pieces to expedite rebuilding.  You can rebuild a piece of your
book simply as follows:
.DS I F \"*** I=standard indent; F=fill
.B "book-format"
.I "piece"
.DE
The synchronization information created in your first build persists,
and gives the piece the right chapter and section numbers.  So, for example, if
you modified Chapter 2, you can just rebuild the piece(s) containing Chapter 2,
without rebuilding the entire book.
(If pagination has changed, the table of contents and 
index will not be correct unless 
you rebuild them, though.)
.P
As you might imagine, if you make radical changes to the description file, such
as removing or adding a line, the
Synchronization information will change for all subsequent lines in the description
file.  To resynchronize the book, you should rebuild the whole
book or the whole body; otherwise synchronization
information for all parts of the book after the change will be wrong.  
.P
If you restructure the description file to have fewer parts, 
it is wise to delete old 
.B Sync/* 
files.  Sometimes the table of contents may be built with wrong
information if you do not delete these old Sync files.
.H 3 "Conditional Building"
.P
To build conditionally, you can use the book-format -D
option.  (Note that you can invoke this option
by default if you specify it in the description file,
as described in the Description File section.)  Remember
that your files must be marked up with conditional
processing directives, as described in Chapter 2, 
before this will work.
.DS I F \"*** I=standard indent; F=fill
.B "book-format -D\c"
.I "SYMBOL"
.DE
You can have as many 
.B -D
.I SYMBOL 
arguments on the command line as you
want or need.
.P
To build 
.I without 
showing any of the conditional information, you should 
include a "dummy"
-D argument, like
.DS I 
.B "book-format -DNOTINFILE"
.DE
.P
This says that no symbols are defined, and
formats the book taking only 
the \fB#else\fP branches in the conditions.
(Your description file needs to say the same thing
if you use the \fB#DEFINE\fP directive.)
.P
.B book-format 
also allows you to build with the 
conditional processing directives highlighted, for  
easy identification in the text.  This is useful
for checking that information is properly
conditionalized, as you might want to technical
reviewers to do during a review cycle.  See 
.BR book-format(1) .
.H 3 "Building a Glossary"
.P
Once you have your document marked up for 
building a glossary as described in Chapter 2, you can generate
your glossary.  If the book's 
identifier from \fBmacros\fP/\fBbookdefs\fP.\fBmac\fP
is not already specified in the description file,
you must specify it from the command line; or,
you can use a command-line specification to override
the description file specified-name.
.P
Build the glossary for the first time as follows:
.DS I F 
.B "book-format -book"
.I "book-name"
.B "all"
.DE
.P
If your synchronization information is already
correct, you can use
.B glossary
instead of
.BR all ;
you can omit the 
.B -book 
option if your
description file already specifies it.
.P
Note that this will produce a file called 
.B glossary.ps 
for PostScript formatting runs, and 
.B glossary 
for ASCII formatting
runs.  This file will be created in the appropriate \fBOutput/\fP
directory along with the TOC, index, and other pieces of your
book.
.H 3 "In Case of Problems"
.P
If you encounter problems in your initial build, check the directions in this
chapter again.  Make sure that your description file fields are separated
by hard tabs.  Make sure
that you have all the required directories and files.
Finally, ensure that you
don't have hard-coded register information in 
your files that interferes with the synchronization mechanism.
.P
If one of the tools invoked by
.B "book-format"
encounters a coding error, such as an unterminated list, an
error message from that processor may or may not appear during 
the build.  Often in case of processing errors, the
build tools will not be able to complete the synchronization information.
When this happens, all section numbers encountered after the error will
begin with "100".  If you see numbers that
start with "100", find your formatting error (look
near the place that the 100s began, or look at the
place where formatting stopped, if formatting stopped
completely.)  Then rebuild the book.
.P
When you are building a complex file for the first time, you might want to  
format it quickly using
.B dmm
or
.B dman
just to catch any formatting errors.  Then, when you are sure the file
processes properly, use
.B book-format
to build the book.
.P
If you experience errors when building with the 
.B #ifdef 
conditional
compilation feature, check your 
.B #ifdef/#else/#endif 
combinations.  Unterminated
.B #ifdef/endif 
clauses will cause an error, hopefully accompanied
by an appropriate error message.
.ig yy 
...\"*********************************************************************
 
...\"		Third-level head
...\"*********************************************************************
.H 3 "Third-Level Head"
.P
Text, text, and text.
...\"*********************************************************************
...\"		Fourth-level head
...\"*********************************************************************
.H 4 "Fourth-Level Head"
.P
Text, text, and text.
...\"*********************************************************************
...\"		Lists
...\"*********************************************************************
.H 2 "Lists"
...\"**************************************************
...\"		Bulleted list
...\"**************************************************
.BL
.LI
An item 
.P
More information about the item
.LI
Another item
.LI
Another item
...\"**************************************************
...\"		Dashed list (within the bulleted list)
...\"**************************************************
.DL
.LI
An item  
.LI
Another item
.LI
Another item
.LE      \"*******end of dashed list
.LE      \"*******end of bulleted list
...\"**************************************************
...\"		Numbered list
...\"**************************************************
.AL
.LI
Item 1
.LI
Item 2
...\"**************************************************
...\"		Numbered list (within a numbered list)
...\"**************************************************
.AL a
.LI
Item 2.a 
.LI
Item 2.b
.LE
.LI
Item 3
.LE
...\"*********************************************************************
...\"		Variable length list (1st line at left margin, rest
...\"		of the text indented).  The indent is set by the
...\"   	"This is a phrase".
...\"   	
...\"   	The backslashes in the .LI phrases (which specify 
...\"   	unpaddable spaces) prevent the formatter from using
...\"   	those spaces when it calculates the justification for 
...\"   	that first line.
...\"*********************************************************************
.H 2 "Variable Length Items"
.VL \w@\fBThis\ is\ a\ phrase\fR@u
.LI "\fBThis\ is\ a\ phrase\fR"
Explanation of the phrase. 
.LI "\fBThis\ is\ another\ phrase\fR"
.br
Explanation.
.LI "\fBWord\fR"
Explanation.
.LE 
...\"*********************************************************************
...\"		Notes
...\"*********************************************************************
.H 2 "Notes"
.DS "" F 1.5i \"*** ""=no standard indent; F=fill; 1.5i=right indent
.in 1.5i
.ti -\w@\fBNOTE:\ \ \fR@u
.BR "NOTE:\ \ \c"
Text of the note. 
.P
Second paragraph of the note (if any).
.DE
...\"*********************************************************************
...\"		Cautions
...\"*********************************************************************
.H 2 "Cautions"
.DS "" F 1.5i \"*** ""=no standard indent; F=fill; 1.5i=right indent
.in 1.5i
.ti -\w@\fBCAUTION:\ \ \fR@u
.BR "CAUTION:\ \ \c"
Text of the caution.
.P
Second paragraph of the caution (if any).
.DE
...\"*********************************************************************
...\"		User input
...\"*********************************************************************
.H 2 "User Input"
.DS I F \"*** I=standard indent; F=fill
.B "command"
.B "-option(s)"
.I "variable"
.DE
...\"*********************************************************************
...\"		System responses and files
...\"*********************************************************************
.H 2 "System Response and Files"
.P
This is an example.
.DS I  \"*** I=standard indent
.ft CW
12345678902234567890234567890423456789052345678906234567890
12345678902234567890234567890423456789052345678906234567890
.ft R
.DE
...\"*********************************************************************
...\"		Unmarked list (indented paragraph)
...\"*********************************************************************
.H 2 "Unmarked Lists"
.DS 1   \"*** I=standard indent
word
word
word
word
word
.DE
...\"*********************************************************************
...\"		Comments to reviewers
.H 2 "Comments to Reviewers"
.P
\fBREVIEWERS:\fR  This is my question...
...\"*********************************************************************
...\"		Table
.H 2 "Tables"
.P
\fITo be defined.\fR
...\"*********************************************************************
...\"		Figure
.H 2 "Figures"
.P
\fITo be defined.\fR
...\"*********************************************************************
...\"		In text items
.H 2 "In-Text Items"
.VL 1.25i
.LI "Chapter\ Title"
...\"#chaphead
.B "Title"
.LI "Pathname"
...\"#path
.B "path/name"
.LI "Subroutine,\ System\ Call,\ Function\ Name"
.br
...\"#func
.B "function"
.LI "Command"
...\"#command
.B "command"
.LI "Glossary\ Term"
...\"#gloss
.B "term"
.LI "Keyboard\ Key"
...\"#key
.B "<Return>"
.LI "Variable (symbol?)"
...\"#var
.I "variable"
.LI "Emphasis"
...\"#emph
.I "Word\ or\ phrase"
.LI "Document Title"
...\"#doctitle
.I "Title"
.LI "OSF/1\ Data\ Structure\ or\ Variable"
.br
...\"#dname
.I "data structure"
.LE

.yy 
