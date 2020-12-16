...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\"  @OSF_FREE_COPYRIGHT@
...\"
...\" HISTORY
...\" $Log: ch01.mm,v $
...\" Revision 1.1.2.7  1994/06/24  15:16:10  fred
...\" 	free copyright
...\" 	[1994/06/23  20:15:23  fred]
...\"
...\" Revision 1.1.2.6  1994/06/23  18:40:07  fred
...\" 	free copyright
...\" 	[1994/06/22  19:34:16  fred]
...\" 
...\" Revision 1.1.2.5  1993/04/10  01:22:42  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  01:20:25  bowe]
...\" 
...\" Revision 1.1.2.4  1992/05/28  18:20:30  bowe
...\" 	Fix botched initial check-in.
...\" 	[1992/05/28  18:15:59  bowe]
...\" 
...\" Revision 1.1.2.3  1992/05/28  17:56:07  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:53:37  bowe]
...\" 
...\" Revision 1.1.2.2  1992/05/28  16:49:48  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:46:49  bowe]
...\" 
...\" $EndLog$
...\" _________________________________________________________________
...\"
...\"build rmifdef tbl	
...\"
.H 1 "Getting Ready to use the OSF Doc Tools Environment"
.iX "introduction"
.iX "another index entry"
.P
This chapter describes the OSF Documentation Tools Environment
(DTE), and prepares you to use it.
.H 2 "Understanding the DTE" 
.P
This section provides background to 
the DTE.  The section discusses: 
.BL
.LI
The capabilities the DTE provides you, the writer, 
.LI
The terminology we use in describing the DTE,
.LI
The structure of the DTE,
.LI
Current state of the DTE and future directions.
.LE
.H 3 "DTE Capabilities"
.P
The DTE provides tools that allow you to 
to:
.BL
.LI
Mark up source documents,
.LI
Process your source documents to produce books with
the normal frontmatter and backmatter, including index and TOC,
.LI
Conditionally build versions of books,
.LI
Choose a style for your processed documents,
and change styles simply by reprocessing your book with
a different command-line option.
.LE
.H 3 "Terminology"
.P
This manual uses a few terms over and over.  Because they are
critical to your understanding, and because we may use them
differently than you are used to,
we'll go over them now.  
.P
The term
.B "build tools"  
refers to the shell scripts or C programs that take your source files
and information you specify about these files, and create processed
output files.  This document concentrates primarily on book-building tools,
but the simple scripts
.B dmm
and
.B dman
.R ,
which you use to build short documents such as plans and specs, are
also part of the build tool set. 
.B "Macro definitions"
and
.B "header files"
are sets of definitions that dictate the layout of your books, and may
provide additional information, such as the expansion of string-define
characters.  Other standard header files, created by the tools group as
part of the DTE, also provide the set-up of register and
other "numeric" information within your files. 
.P
.B Templates
are skeleton source files to show proper use of the macros and provide
samples that you can copy.  OSF writers 
may not use templates, depending on whether the document
starts with source
files from a technology supplier, or is created new.
.P
Many publishing systems provide templates.  It's important to note that
in our DTE, templates are only skeletons, and do NOT provide features
such as autonumbering.  Instead, header files and the build tools provide
those features in our DTE. 
.H 3 "Motivation for and Goals of the DTE"
DTE is designed specifically for the needs of the OSF documentation group.
Our group has several key requirements:
.BL
.LI
An efficient and sufficiently rich document production environment for OSF writers,
.LI
A means to quickly and easily create online output files for snapshots (both
ASCII and Postscript),  
.LI
The ability to create portable source files, which 
are suitable source documentation for licensee
documentation groups.  In particular licensees need to provide their
own proprietary appearance for the documentation they receive from us,
and they often wish to translate it to other markup languages. 
.LE
.P
.H 3 "Structure of the DTE"
.P
The DTE has several components.  The writer provides a 
source directory for each document, containing:
.BL
.LI
Source files, created from templates and technology-suppliers' documentation,
.LI
Information about how to use the source files in creating the book.
.LE
.P
The DTE provides:
.BL
.LI
Build tools
.LI
Macro definitions
.LI
Standard header files
.LI
Output directories and status files created during book processing.
.LE
.P
As noted previously, the templates are a part of the DTE 
created by writers and editors, as an aid to the writers
in source file creation.
.P
When you process your source directory, 
the tools install the proper header
files and invoke the proper macro definitions,
based on the layout style and
output format you've specified.   
#ifdef OSF
.P
The DTE will fit into an OSF-Engineering wide source code 
control and configuration
management system.  The source 
directories created by writers using the 
DTE will go under source code control.
The tools group will create makefiles that invoke the build tools.
#endif
.H 3 "Current Condition and Future Directions of DTE"
.P
The DTE includes templates, build tools, "draft"
appearance macros (used to process OSF books shipped on tape as
part of OSF offerings) and
"published" appearance macros (for OSF internal use only;
not provided with the DTE version shipped with OSF
source materials). 
.P
With one minor exception, the "draft" appearance is produced
without 
.I modification
of any standard \fBmm\fP or \fBman\fP macros; what licensees 
need to do to maintain this appearance is to build books
with the DTE.  The draft appearance also relies on some
.I additions
to the 
.B mm 
and 
.B man 
packages; these are provided by additional macros, shipped
in the macros directory with the DTE. 
#ifdef OSF
#else
.P
Often the standard macro packages have been
redefined at a licensee site, so that the standard macros
produce a different appearance.  
If you, as a licensee, wish
to retain your redefined appearance instead of the
OSF draft appearance, you will likely need to make some modifications
in the tools to maintain this appearance.  See Appendix
A for internals information and hints for extending the package. 
#endif
.P
The DTE at this release also includes basic support for the
Semantic Markup Language\(tm (SML\(tm.)
SML is based on the semantic elements used
today in Open Software Foundation\(tm (OSF\(tm) technical documentation.
The motivation for SML was an OSF Documentation Special
Interest Group (SIG) Information Architecture Task Force meeting in
November 1989.  The meeting participants asked OSF to specify
such a language, based on the existing 
.BR nroff/troff
macro packages
in use in OSF documents, as the first phase in the
migration to a more generic document interchange
mechanism.  This first phase, which generalizes and standardizes
the current markup in OSF documents, 
will make it simpler for OSF licensees to create documentation from
OSF source, and will set the stage for the next phase, in which
complete document models will be identified.  
.P
Chapter 2 provides
basic task-oriented information for the use
of SML in document markup.
Chapters 4 and 5 are "references", providing
a technical description of SML, and a number of reference
tables, respectively.   
#ifdef OSF
#else
See the release notes shipped
with your documents for information about
whether your documents include SML markup,
or standard \fBtroff\fP markup and a translator
that translates them to SML.  The SML macros
we ship provide a draft appearance, not
a published appearance. 
#endif
.P
Although the DTE is not a supported part of
OSF offerings, we do expect to enhance it
based on user feedback.
Future directions for the DTE include enhanced portability
in a variety of environments.  We look forward to feedback from
OSF technology suppliers and licensees for appropriate areas for
portability enhancements.  At the same time, since the
.B "nroff/troff"
packages on which the DTE is currently based are not our
long-term direction for document interchange, we expect to
limit the work that is useful only in the
.B "nroff/troff" 
context.  
.H 2 "Preparing to Use the DTE Tools"
.P
#ifdef OSF
To use the tools, you must have the project
.B docsrc
mounted.  Your search path must include at
least the directories specified in the default
.B .cshrc
scripts in
.B /project/docsrc/Env/General/cshrc
.R .
Check your path before starting to use these tools. 
.P
#else
To use the tools, build them as directed in the
release notes for your offering; then build the
documentation as directed.  The release notes
always contain complete information about using
the makefiles provided with the release to build
the documentation shipped with the offering.
This manual provides information about the
tools called by those makefiles.	 
#endif
.H 2 "Shortcuts For Eager Learners"
.P
This manual is large because it gathers together
information previously found in many places.  However,
the tools whose use the manual describes are actually
quite simple, so do not be daunted by the size of the
manual.  If typically you skip material in manuals, 
here is a set of
shortcuts to get you started with the DTE.
.AL
.LI
Create a directory that contains 
.B n/troff 
source files.  (Markup hints are in
Chapter 2.)
.LI
Create a description file and headers
directory as described in the Description(4)
manpage (Chapter 6), and the Chapter 3 headers directory
description.
.LI
Use
.B book-format
to build the book, as described in the
book-format(1) manpage, and Chapter 3.
.LI
Read this manual if you have problems, want
to use SML, want to generate an 
index or glossary, or other niceties.
.LE
