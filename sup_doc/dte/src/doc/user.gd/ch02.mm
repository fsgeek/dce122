...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\"  @OSF_FREE_COPYRIGHT@
...\"
...\" HISTORY
...\" $Log: ch02.mm,v $
...\" Revision 1.1.2.8  1994/06/24  15:16:13  fred
...\" 	free copyright
...\" 	[1994/06/23  20:15:29  fred]
...\"
...\" Revision 1.1.2.7  1994/06/23  18:40:10  fred
...\" 	free copyright
...\" 	[1994/06/22  19:34:29  fred]
...\" 
...\" Revision 1.1.2.6  1993/04/10  01:22:44  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  01:20:29  bowe]
...\" 
...\" Revision 1.1.2.5  1992/12/01  22:31:24  bowe
...\" 	Fix bad markup describing: ...\"build rmifdef
...\" 	[1992/12/01  22:31:05  bowe]
...\" 
...\" Revision 1.1.2.4  1992/05/28  18:20:33  bowe
...\" 	Fix botched initial check-in.
...\" 	[1992/05/28  18:16:16  bowe]
...\" 
...\" Revision 1.1.2.3  1992/05/28  17:56:10  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:53:37  bowe]
...\" 
...\" Revision 1.1.2.2  1992/05/28  16:49:53  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:47:07  bowe]
...\" 
...\" $EndLog$
...\" _________________________________________________________________
...\"
...\"build rmifdef tbl
...\"
.H 1 "Using Document Mark-up"
.iX "index entry"
.iX "another index entry"
.P
This chapter describes how OSF marks up
documents using:
.BL
.LI
standard \fBtroff mm\fP and \fBman\fP markup
.LI
OSF additions (functional with both standard
troff and SML) for indexes, glossaries, and conditional
processing
.LI
semantic mark-up language (SML) 
.LE
.P
The reference chapters in the second half of this
book provide a technical description of SML  
and a quick reference for SML functions.  For
reference information about \fBtroff\fP, use 
the DWB documentation provided with your DWB 
package.
.P
We provide information about both standard 
.B troff
and SML markup because the OSF documentation set
is currently evolving towards full use of SML. 
.P
Note that Appendix B discusses one source file creation issue in
more detail; the generation and inclusion of Postscript
graphics in text.  Future revisions of the appendices 
will provide information
about our front ends for generating
.B pic
drawings. 
.P
We do not provide any guidelines for use of the
.B mptx
macros, because their use is limited to generation
of permuted indexes in some reference manuals, and
the OSF usage is standard. 
.H 2 "Standard Troff Markup/Portability Guidelines"
.P
This section provides information about 
the "portability guidelines" OSF has set for its
standard \fBtroff\fP markup.
First, some background about what portability guidelines
mean in this context.  
.B "troff" 
was OSF's short-term solution to the problem of creating
"portable" documentation for portable source code
software offerings.  Because development of portable
documentation has lagged behind development of portable
software, our initial goals had to be fairly limited.
For portability, we required
that our markup language was something easily available
on any UNIX\(r 
machine, and could produce ASCII output suitable
for on-line display by primitive help systems (such
as the UNIX man command.)  We also required
that OSF send out documentation written in ONE language, although
the documentation we received with our technologies arrived
in many languages!
.P
OSF documentation is created from two sources:
new documentation is created using templates that
we created to show proper markup, and
documentation imported from technology suppliers
is created from these suppliers' original documentation.
Often, documentation by technology suppliers is
translated from some other format to a \fBtroff\fP macro
package.  So, the templates that 
OSF writers use demonstrate proper mark-up for
various types of documentation.  The markup that appears
in translated versions depends heavily upon the markup
in the original text. Sometimes the machine-generated
markup, while it produces functional output, is clumsy. 
.P
Because of these diverse sources, OSF documentation
markup is not always consistent.  However,
we do try to follow certain guidelines, to aid portability
to various platforms.  This section describes some of those
guidelines.  Note that the templates themselves act as
guidelines for newly created documentation.  As a supplemental
aid, copies of those templates are kept in 
the \fBtools/dtedoc/templates\fP directory.
.P
At OSF, we use the Elan, Inc. Eroff\(tm package for text
processing.  To the best of our knowledge,
we do not rely on any nonportable
features of this package (except when there
is no alternative; see the subsections that follow.)
We hope to receive
bug reports when licensees discover additional portability problems. 
We have intentionally avoided the use of nonstandard
extensions, such as long macro names.
.P
The remainder of this section provides portability guidelines. 
.H 3 "Use of Macros Instead of Primitives"
.P
Whenever possible, we attempt to use macros instead of
.B "nroff/troff" 
primitives.  Macros are easier to use, produce
cleaner source files, and promote
a more semantic approach even when using standard
macro packages and not SML. 
.H 3 "Use of Macros Instead of Inline Font Changes"
.P
Where possible in standard
.B troff
markup, we attempt to use
.B troff 
macros in place of inline
font changes.  For example, we use the 
.B ".B" 
macro when possible, instead of an escape for inline
font changes.  This produces cleaner source files.
.H 3 "Fonts"
.P
When inline font changes are necessary, we specify
bold and italics, rather than a font name.  Font escapes should
go back to the previous font (\\fP), rather than back
to Roman font (\\fR).  
.P
We try not to use markup to change font size except   
where absolutely necessary; e.g. examples that are
too wide for the page.
.P
#ifdef OSF
#else
\fBeroff\fP refers to constant-width font as 
CW, so a change to constant width font may
be marked as follows:
.BR ".ft CW" .
Other versions of DWB refer to constant-width font
as C; check your documentation.  Change this font name, if
necessary, before rebuilding the OSF documentation. 
.P
We have also tried to avoid the use of the old-fashioned 
font numbers (ft1, ft2, ft3 and so on) and used font
names (R for Roman, H for Helvetica, etc.) instead, where
it is necessary to change fonts explicitly.  If your version of
DWB requires these numbers, you will need to do some
modification of our sources before attempting to rebuild
them.
#endif
.H 3 "Page Breaks"
.P
We refrain from hard-coding page breaks with a \fB.bp\fP
primitive, and try to use 
\fB\&.ne\fP 
instead.
.H 3 "PostScript Inclusion"
.P
Some OSF books include PostScript\(r 
illustrations.  We have found Postscript
inclusion to be very implementation-dependent.
If you are not using the Elan, Inc. version of DWB,
you may have to experiment in order to get the
PostScript files to be included properly when
you rebuild OSF books.
.P
Appendix B provides guidelines for addressing PostScript
inclusion problems.  Although much of this appendix provides
background information for creating PostScript screen dumps
in the OSF environment, the last sections discuss how you
include these files in documents.  Read this appendix 
before attempting to build with directories that includes
PostScript files, and extract the information that is useful for
your environment. 
.H 3 "Change to Footer Macro"
.P
In order to be able to build books with chapter-page
numbering (for example, 2-1) we had to make a change to
the 
.B man 
package's footer macro.  When you install the
DTE and run 
.B book-format, 
this additional macro redefines the existing
man macro, so books built as books process as books.
Of course, manpages processed with the 
.B man 
command still get sequential numbering.
See Appendix A for information about where this change
was made.
.H 2 "OSF Macro Extensions (SML and non-SML)"  
.P
This section describes such features as
predefined strings, conditional markup,
index generation, and glossary features, 
which are available
both in SML, and in the standard additional macro files 
that OSF provides to licensees.  We provide these
because they do not exist in DWB, and because this
functionality is required to produce technical manuals.
This section describes this markup.
.P
Note that we use this markup in manpage material
as well as text material, but the OSF/1 \fBman\fP
command, and other man commands, cannot handle
this special markup.  So, before manpages are
installed on an OSF/1 system, a preprocessing step
in the installation program does tasks such as running
the \fBtbl\fP table preprocessor, resolving string definitions
and conditional markup, and so on.  Licensees who
wish to install manpages on a non OSF/1 system may
need to do similar work.
.H 3 "Conditional Markup" 
.P
Conditional markup allows you to
conditionally include text.  The markup
is the same as that you would use in a C
program, for processing by the C preprocessor.
The DTE tool that processes this markup behaves slightly
differently in that the DTE tool does not add blank
lines, and does not do substitution of symbols
in the text.  Chapter 3 explains the options
you use to make the DTE tools process
conditional markup. 
.P
To use the markup in your source files, you include 
in a block of comment text at the top of
your source file the line \fB\&...\e"build rmifdef\fP.
You then use the
.BR #ifdef , 
.BR #else ", and" 
.B #endif 
directives in your text.
The comment line tells the book-processing tools to
resolve \fBifdefs\fP based on a particular symbol definition. 
Symbol definition takes place at processing time, based
on your build-time directions (see Chapter 3 for information
about the commands you use to give these directions).
.P
The markup looks like this:
.P
.DS I  
\fB#ifdef\fP \fISYMBOL\fP
Text you want included if SYMBOL is defined 
.B #else
Text to include if SYMBOL isn't defined 
.
.
.
.B #endif
.DE
.P
.I SYMBOL
is a symbol for one branch of the condition.  For
example, if you want to conditionally include
material for one release or another release,
your symbols might be \fBRELEASE1\fP and \fBRELEASE2\fP.  In the
markup for this book,
the symbol \fBOSF\fP defines material provided only for OSF
documentation suppliers (OSF internal and external
writers providing documentation for use in
OSF offerings).
.P
You can define multiple symbols for one document, so
you might need multiple
.B #ifdef
statements. 
You need not use the 
.B #else 
branch if there is no text to include when the condition is 
not met.
.P
OSF has used this mechanism instead of relying on 
\fBtroff\fP string-definition features 
because this mechanism is powerful enough for 
large blocks of text, because it does not risk running out of
registers, and because it is flexible enough to outlive
the use of 
.B "troff" 
at OSF. 
.H 3 "String Definitions"
.P
We have provided predefined string definitions
in the \fBbookdefs\fP file, which  
currently cover all the titles in the OSF/1 book set.
In the future,  we will add definitions to cover all the titles
in the total OSF document set.  Books in the OSF/1 document
set use these strings to refer to other titles in the set. 
#ifdef OSF
#else
.P
As a licensee, you can change OSF book names in this file to
your own book or module names.  You can also add to this
file; you are limited only by the \fBtroff\fP limitation
on the number of names.  (Too many string definitions,
macros and/or text diversions, as in
table entries, can cause \fBtroff\fP processing problems.)
If you do ADD entries to the file, make sure that you
check for these definitions in future DTE releases, to avoid multiple
definitions for the same string.
#endif
.H 3 "Index Markup"
.P
Documenter's Workbench does not provide any
standard indexing macros; documentation organizations
have had to write their own.  OSF provides an indexing
macro with features for three-levels of index
entries, page-range specification, and "see-also"
references.  This macro is integrated
into the book-building tools. 
This section describes how you mark up documents using 
the indexing macro.
.P
The indexing macro is 
.B  ".iX ." 
#ifdef OSF
It replaces any existing
macros like .IX (if anyone has that) or an existing .iX.  It's also
backwards-compatible with the current .iX, but has extra features. 
#endif
Its syntax is as follows:
.DS I
\fB\&.iX \fP [\fI"-flags reference"\fP] 
\fB"\fIprimary\fB"\fR \fB["\fIsecondary\fP\"] ["\fItertiary\fP"]\fR
.DE
where primary, secondary, tertiary are index entry levels. 
You must provide a primary entry; "-flags reference" and other entries
are optional.  
.P
The "-flags reference" features allow you to:
.BL
.LI
highlight an entry as the main entry for this topic.  The
page number appears bolded in the index.
.LI	
specify a page range for the entry.  Instead of a single
page number, a page range appears, such as:
3-4 to 3-8. 
.LI
specify use of "See other_entry_name" instead of a page number 
.LI
specify use of "See also other_entry_name" instead of a page number 
.LE
.P
The flags are as shown in this table:
.ne 10
.TB "Index Flags"
.TS
center,box;
l | l.
\fBFlag	Description\fR 
_
!	highlight an entry as the main entry for this topic
[	start a page range for this topic.
]	end a page range for this topic.
:	specify use of "See other_entry_name" instead of a page number 
;	specify use of "See also other_entry_name" instead of a page number 
.TE
If used, 
.B : 
or 
.B ; 
must appear last.  
.B ! 
may appear with 
.B [ 
, 
.B : 
, or
.B ; 
\(em no other combination is meaningful.
.P
Here's a sample set of tags, showing how you'd use these index
entry features.  Input is:
.DS I
.ft CW
\&.iX "-![" "commands" "cat"
\&.iX "-[" "commands" "cat" "in scripts" 
\&.iX "-; Shell programming" "commands" "cat" 
\&.iX "-]" "commands" "cat" "in scripts" 
\&.iX "-: Commands, cat" "cat"
\&.
\&.
\&.
\&.iX "-!]" "commands" "cat"
.ft R
.DE
.P
Output is:
.DS I
.ft CW
cat, 
  see Commands, cat 

Commands,
 cat, 3-8 to 3-14
   in scripts, 3-10 to 3-11
   See also Shell Programming
.ft R
.DE
.H 3 "Glossary Markup"
.P
Consistent glossaries are important in OSF books because of their
importance in translation, and because they promote
consistency across a document set.  We also feel that they
are the foundation 
of a documentation database from which hypertext retrieval
systems can extract information.   
For these reasons, we have created an OSF
glossary database for internal use.  The
database is built from a set of
normalized glossary files 
that we ship with our offerings to our
licensees.  The book-building tools use the
glossary markup and the glossary files
to produce a glossary for each book,
built with common terms from the glossary database. 
.P
Note that, in addition to glossary entries that are
used in OSF books, the normalized glossary files
currently contain old, unedited entries from a
source database.  We will eventually clean these
entries up; for the time being you can ignore them
as they do not show up in any book unless the
book title is added to the entry.   
.P
To use the glossary markup, you need to edit both
your source files and the normalized glossary files.  (OSF licensees
may not need to edit either, but we provide this information
in case you do.)
.P
To use the glossary markup,
add references to the terms 
that you want to appear in the
glossary to your book.  
When a term is introduced, include
markup such as the following:
.DS I
.ft CW
and then, the \e*Lglossary term\e*O provides
\&.gL "glossary term"
useful functionality for the ...
.ft R
.DE
The .gL does NOT generate any text in your document by itself,
but causes the build tools to add that term to the book's glossary.
Therefore, to highlight the word in text,
you must still mark the term in your text with SML 
.B "\*L"
or \fBtroff\fP 
emboldening markup. 
(The example shows SML.)
.P    
You can have multiple .gL's for the same term (they only cause
one glossary entry), but you have to spell the term the same
way each time.  Also, you have to make sure that you spell it
the same way that it appears in the glossary flat files/database.
.P
To edit the normalized glossary files,
use the directions in the glossary(4) manpage.
If you add a new term
to the glossary, it must use the format described in this man
page; copy an existing entry and modify.  Be sure that you have
one or more accurate definitions for each term that
you have in a .gL macro.  Also, make sure that you specify the 
book's title ID (as found in the \fBtools/macros/bookdefs.mac\fP
file).  Make sure that you specify your book's
identifier in a .BOOK entry following EACH definition that
you want in your glossary.  
#ifdef OSF
.P
The glossary files are under RCS
control, so writers at OSF need to do the 
following to edit your glossary
entries that start with the letter Q:
.AL
.LI
cd /project/docsrc/src/glossary
.LI
co -l glossQ (where X is an uppercase character)
.LI
use your favorite editor to edit the file
.LI
ci -u glossQ
.LE
.P
For non-OSF writers producing information for OSF books
(as in the DCE project), we will provide special 
instructions.  Your glossary files may be produced on
a branch, and merged back into the standard OSF 
glossary tree. 
#endif
