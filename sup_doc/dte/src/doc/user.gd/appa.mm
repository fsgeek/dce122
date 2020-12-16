...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\"  @OSF_FREE_COPYRIGHT@
...\"
...\" HISTORY
...\" $Log: appa.mm,v $
...\" Revision 1.1.2.7  1994/06/24  15:16:02  fred
...\" 	free copyright
...\" 	[1994/06/23  20:15:03  fred]
...\"
...\" Revision 1.1.2.6  1994/06/23  18:39:58  fred
...\" 	free copyright
...\" 	[1994/06/22  19:33:56  fred]
...\" 
...\" Revision 1.1.2.5  1993/04/10  01:22:35  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  01:20:16  bowe]
...\" 
...\" Revision 1.1.2.4  1992/05/28  18:20:23  bowe
...\" 	Fix botched initial check-in.
...\" 	[1992/05/28  18:15:37  bowe]
...\" 
...\" Revision 1.1.2.3  1992/05/28  17:56:00  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:53:37  bowe]
...\" 
...\" Revision 1.1.2.2  1992/05/28  16:49:31  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:46:11  bowe]
...\" 
...\" $EndLog$
...\" _________________________________________________________________
...\"
.nr H1 0
.H 1 "Internal Information About Build Tools"
.iX "index entry"
.iX "another index entry"
.P
This appendix provides some internal information about the functioning of
the build tools.  This information may be useful to licensees
interested in modifying or extending the tools.
.H 2 "Internal Structure of the Formatting Tools"
.P
The DTE has 3 layers, the top layer of which
OSF provides. 
The bottom layer is the 
.B n/troff 
formatters. They provide a set 
of primitives useful, but not sufficient 
for, the preparation of documents. 
At the next level up are the 
.B mm 
and 
.B man 
macros.  Both these layers are part of the Documenter's
Workbench (DWB) package, and are not provided
by OSF.
At the highest level are the DTE 
shell scripts and additional macros provided
by the DTE.  
.P
This appendix provides some internal information
about the highest DTE layer: the OSF
macro file extensions, and the DTE shell scripts.
Licensees who wish to extend the DTE for their own
use must be familiar with their own implementations
of the two bottom layers.  
.H 2 "OSF Macro Extensions and How They are Used"
.P
This sections shows the macros provided in the DTE as extensions to
the
.B man
and
.B mm
macro packages.
.P
Every time that a piece of a document is processed by the
.B book-format
and
.B format-piece
programs
(the latter program is the one that really does the work),
a long UNIX pipe is invoked.
That pipe includes DWB preprocessors,
the
.B nroff
or
.B troff
command (for ASCII or typeset output, respectively),
and appropriate post-processors,
as required.
The generation of that pipe command is performed by the
.B roff-cmd
program,
which is run by
.BR format-piece .
.P
The commands included within the pipe command are:
.AL
.LI
Before any DWB pre-processors are run,
the document source is run through
.BR elimso ,
which performs
.B .so
.BR nroff / troff
requests.
This allows
.B tbl
(etc.)
code to be included in a book's source by use of the
.B .so
request.
.LI
Required DWB preprocessors
.RB ( tbl ,
.BR pic ,
and so on)
are run.
.LI
.BR nroff / troff
is invoked.
.LI
Required DWB post-processors
(eg,
.B eps
for PostScript generation)
are run.
.LE
.P
For correct formatting of each piece of the book,
the proper macro files must be processed.
They are passed as options or files to
.BR nroff / troff
in the pipe command.
Specifically,
.AL
.LI
Standard DWB macros are passed as an option,
.B -man
for manpages, and
.B -mm
otherwise.
.LI
To support PostScript image inclusion in a book
via the
.B .P!
macro, the file
.B /usr/lib/tmac/tmac.eroff
is included for the Elan DWB,
and
.B ps.mm
for all other DWBs.
.LI
A host of internal DTE macro packages are then processed,
depending on the type of piece being processed
.RB ( man
vs.
.BR mm ),
and the keywords listed for that piece in the book's description file.
Details about these macros can be found in the following sections.
.LI
The
.B bookdefs.mac
file (which contains string definitions for book titles)
is always included.
.LI
Book-specific header files (from the book's
.B Headers
directory)
are included to set book-wide definitions
(eg, the title of the book).
.LI
Synchronization files are always included before the piece content is processed
to pass
formatting status
(eg, page numbers, section numbers, etc)
from the previous piece into the current piece.
Synchronization files are also included after processing a piece's
content to save the status so that it can be passed to the next piece.
.LE
.P
The subsections that follow describe the macro files in more detail.
.H 3 "Macros For Book Body Formatting (Draft Appearance)"
The following macro files are for formatting the body
of the book, including headers, with the draft appearance.
For manpages, the draft-an+.man file is the one in which
we redefined the footer macro, so as to produce
chapter-page numbering.
.P
Note that in almost all cases characteristics of the draft appearance 
(point size, indentation, and so on) are set within
these files using primitives and registers, rather than
redefining macros.  Redefining was necessary for
man page footers because the man package provided
no other way to get the needed look.
.P
.DS I
draft.mac		general draft appearance extensions

draft-an+.man		man page and mm macro extensions
draft-mmt+.mm

draft-hdr.man		header file definitions
draft-hdr.mm
.DE
.H 3 "Macros for Front and Backmatter Formatting"
The following macro files are for synchronization,
frontmatter, and backmatter formatting.
.P
.DS I
glossary.mm		glossary formatting macros
glosshead.mm

index-pre.mm		index formatting macros - use before and
index-post.mm		after index content

sync-pre.man		synchronization files between pieces.
sync-pre.mm	        Note common -pre file, specific -man
sync-post.man		and -mm -post files
sync-post.mm		

toc-pre.mm		table of contents formatting macros - use -pre
toc-middle.mm		before .H entries, middle after .H and before
toc-post1.mm		table/figure/... entries, -post after them.
toc-post2.mm

bookdefs.mac		book title string definitions

appendix.mac		macros used when processing an APPENDIX piece
			(as specified in description file)
front.mac		macros used when processing a FRONT piece
			(as specified in description file)
preface.mac		macros used when processing a PREFACE piece
			(as specified in description file)
unnumbered.mm		macros used when processing a UNNUMBERED 
			file (as specified in description file). 

ptx.mm			directives for properly formatting permuted
			indexes
.DE
.H 3 "SML Macro Files"
The following macro files are for SML processing only.
They are to be used with the -mm, -man, and other
macro files previously described. 
.DS I
sml			SML definitions valid in GPSML and RSML
gpsml			SML definitions valid in GPSML only 
rsml			SML definitions valid in RSML only
.DE
.H 2 "Formatting Pieces and the Sync Directory"
The description file (see Chapter 3) divides a document 
into formatting pieces. Each piece represents a 
single run of the formatters.  
The concept of
piece resides only with the DTE shell scripts and macros: 
the uppermost layer described above. The Sync directory 
collects information about the state between pieces that  
must be passed between runs
of the formatters.  This state information
includes chapter numbers, most recent heading, 
last page number of current piece, and so on.  
.H 3 "Format of Sync Files"
.P
The DTE assigns each piece 
an internal number (n); the sync file for that piece is called
.I appearance-processor.n
where 
.I appearance
is the appearance (d for draft or p for publish),
and 
.I processor 
is n for nroff or t for troff.  So, for example, the
synchronization information for piece 7 of a troffed draft file
is in Sync/d-t.7. 
.P
The sync files contain any formatter error messages produced during formatting,
and also status lines of the type 
Header, TOC, Index, and
Synchronization.  Fields within status lines are separted
by spaces. The first field of each status line identifies
the line type as follows:
.DS 
		!H#     	Header line (where # is a 1 digit number).
		!TOC    	Table of Contents line
		!INDEX  	Index line
		!SYNC   	Synchronization information line
		!GLOSSARY	Glossary line
.DE
.P
Note that the status line type identifiers above all begin with !. 
This allows the DTE to recognize and display in standard out
non-status lines (error messages inserted into 
the synch file by the formatters.) 
The fields in each line are
as follows:
.P
Header Status Lines
.AL
.LI
!H# line identifier.
.LI
The digit following the H indicates the section level: 1 to 5.
.LI
The header text, enclosed in double "s.
.LE
.P
Table of Contents (TOC) Status Lines (based
on internal TOC processing as defined by the -mm
macros.)
.AL
.LI
!TOC line identifer
.LI
The literal .)T
.LI
level number
.LI
level number (...)
.LI
The section number in double "s. The 
format used here is the format used in the
table of contents. If this entry is to appear in 
the Table of Contents without
a section number, for example as the chapter titles do, 
then this field is null.
.LI
The section title, as it should appear in the Table of contents. 
.LI
The page number on which the section begins.
.LI
The chapter in which the section appears.
.LE
.P
Index Status Lines 
.AL
.LI
!INDEX line identifier
.LI
The number of lines displayed for this index entry.  Index
entries with more than a primary entry take up more 
than one line in the index field.  This number of
lines appears only in the first line of a
multi-line index entry). 
.LI
The complete page number of the entry (chapter-page). 
.LI
The primary index entry 
For index entries with secondary, tertiary, and flags
reference entries, the entries themselves appear on
separate lines, with index entries and page numbers. 
.LE
.P
Synchronization Information Lines
.AL
.LI
!SYNC line identifier
.LI
The last page in this piece, enclosed in double "s.
.LI
The last chapter in this piece, in double "s.
.LI
The last section in this piece, in double "s.
.LI
The last sub-section in this piece, in double "s.
.LI
(Next three lines) Subordinate sections in double "s. 
.LE
.P
.AL
.LI
!GLOSSARY line identifier
.LI
The glosssary term in double quotes.
.LI
The chapter and page where the term occurs,
in double quotes ("1-5"). 
.LE
Following is a sample fragment from a sync file;
it shows TOC, index and head information.
.oS
\&.
\&.
\&.
!TOC: .)T 1 1 "Chapter2." "Using Document Mark-up" 1 2
!H1: "Using Document Mark-up"
!INDEX: 1 2-001 index entry
!INDEX: 1 2-001 another index entry
!TOC: .)T 2 2 "2.1" "Standard Troff Markup/Portability Guidelines" 1 2
!H2: "Standard Troff Markup/Portability Guidelines"
!TOC: .)T 3 3 "2.1.1" "Use of Macros Instead of Primitives" 2 2
!H3: "Use of Macros Instead of Primitives"
\&.
\&.
\&.
.oE
.H 2 "Extending the DTE by Adding Proprietary Macro Packages"
.B book-format 
provides rudimentary support for extension to include
proprietary macro packages.
Before extending the tool, use the 
.B -v
option to
.B book-format 
to learn more about the internal operation of book-format.
Look through the OSF-supplied
macro files (listed in the previous section) and note potential
conflicts before trying to extend the package or add a proprietary package.  
.P
You should expect to do some debugging in order to extend
the macro packages or the DTE, since
there could be conflicts between the macros provided by the DTE
and proprietary macros.   Also, you must be familiar with
your own macro packages, and with 
.B troff 
macro programming
in general.
.P
To incorporate a different macro package into the
DTE, use the 
.B -mac
option to
.BR book-format . 
This option sources in a specified macro package 
.I after 
processing
the book-format packages, and 
.I before 
the source files.
