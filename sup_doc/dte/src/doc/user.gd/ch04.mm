...\"
...\"  @OSF_FREE_COPYRIGHT@
...\"
...\" HISTORY
...\" $Log: ch04.mm,v $
...\" Revision 1.1.2.7  1994/06/24  15:16:25  fred
...\" 	free copyright
...\" 	[1994/06/23  20:15:48  fred]
...\"
...\" Revision 1.1.2.6  1994/06/23  18:40:24  fred
...\" 	free copyright
...\" 	[1994/06/22  19:34:57  fred]
...\" 
...\" Revision 1.1.2.5  1992/06/29  18:53:53  bowe
...\" 	Type-o in RSML table (.G, should be .E,).
...\" 	[1992/06/29  18:53:31  bowe]
...\" 
...\" Revision 1.1.2.4  1992/05/28  18:20:48  bowe
...\" 	Fix botched initial check-in.
...\" 	[1992/05/28  18:16:41  bowe]
...\" 
...\" Revision 1.1.2.3  1992/05/28  17:56:24  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:53:37  bowe]
...\" 
...\" Revision 1.1.2.2  1992/05/28  16:50:16  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:47:40  bowe]
...\" 
...\" $EndLog$
...\" _________________________________________________________________
...\"
.H 1 "Technical Description of the Semantic Markup Language (SML)"
.P
This chapter describes the Semantic Markup Language (SML) 
for technical documentation preparation.
SML is based on the semantic elements used
today in Open Software Foundation\(tm (OSF\(tm) technical documentation.
The motivation for SML was an OSF Documentation Special
Interest Group (SIG) Information Architecture Task Force meeting in
November 1989.  The meeting participants asked OSF to specify
such a language, based on the existing 
.BR nroff/troff
macro packages
in use in OSF documents, as the first of five phases in the
migration to a more generic document interchange
mechanism.  This first phase, which generalizes and standardizes
the current markup in OSF documents, 
will make it simpler for OSF licensees to create documentation from
OSF source, and will set the stage for the next phase, in which
complete document models will be identified.  (See
.I
OSF Requirements for Information Architecture and Communications
.R 
for a description of these phases.)
.P
This chapter is a revised and updated version of the
document first released in February, 1990, and updated
in June, 1990, entitled
"Proposal for Semantic Mark-up Language."  There are 
a few macros that we never implemented and have removed
from the specification; this chapter identifies those. 
.H 2 "Introduction"
.P
This section defines the terms used in the chapter,
summarizes the design principles, explains structure and syntax of SML,
and describes the relationship of SML 
to the existing
.BR nroff/troff
macro packages.  In this section, as in the rest of the chapter,
we assume readers have some familiarity with the
.BR nroff/troff
processors and macro packages.
.H 3 "Definitions" 
The term \fIsemantic markup\fR means
that each markup directive in this language describes an 
element with a specific meaning in the context of the document.
This meaning can be understood and recognized by
different text processing systems in the same way. 
For instance, the text element marked as 
a 
.I header 
is always interpreted as a header.  The text element marked 
as an 
.I example
is always interpreted as an example.  Because 
semantic markup is free of any formatting information, each
text processing system and each recipient of documentation
source is able to translate the semantic elements
to any format or layout style.  In contrast, a directive 
to "indent five spaces" in completely non-semantic; it
dictates only format and layout.
.P
.H 3 "The Basis of SML"
SML is based on the
.BR nroff/troff
.B mm
and
.B man
macro
packages, and
.BR nroff/troff
are the processors used to process documents marked up with SML.
Our approach in creating SML was to survey existing OSF documentation and the
macros and low-level primitives it contained.
We divided all 
.B mm
and
.B man
macros 
into two categories: semantic and nonsemantic. 
.I Semantic
macros only dictate meaning; they do not enforce any format.
\fINonsemantic\fR macros
only produce formatting actions and do not represent any structural
text elements.
.P
For example, the \fBmm\fR macro \fB.P\fR is semantic 
because it describes a paragraph, but does not enforce any layout for
the paragraph.  The macro \fB.BL\fR is not
completely semantic.  It is semantic in that it marks the beginning of a
list of items; however, it is not semantic because
it specifies the format of the list markers (bullets).
The low-level primitive 
.B .sp 
is not semantic at all because it controls  
spacing between lines.  Spacing information is formatting information only.
.P
Semantic 
.B mm
and
.B man
macros currently used in OSF documentation became the basis for SML.
In general, if the existing macros provided a semantic method, we included these
existing macros in SML instead of inventing new ones.  We did this
even if the semantics provided by the current macros
were not as general as they could have been. 
Deciding on a full set of semantics and full Document Type Definitions (DTDs)
is the task of Phase 2; we did not want to make unnecessary design decisions in
Phase 1 that we may need to revisit in Phase 2.  We also want to 
minimize the amount of translation and conversion required for us to
generalize and standardize our existing documents.  For these reasons,
we used existing semantic macros whenever possible.
.P
The next step was to define new semantic equivalents for
nonsemantic macros, and for the combinations of 
.BR nroff / troff 
primitives that writers have used when no appropriate
macros existed.  
As part of the work of preparing the SML specification, the OSF documentation
tools group correlated all the new semantic macros with
existing nonsemantic macros, and with 
.B troff 
primitives.  We have not included
the correlation
table in this document, but it is the beginning of the specification
for the translator that will translate today's markup into SML.
.P
Because SML is based on 
.BR nroff / troff
and because we must translate existing
.BR nroff / troff
documents cleanly to SML, we have sometimes provided semantic
macros that are necessary only because of the
peculiar characteristics of
.BR nroff / troff .
While this is not elegant, it is necessary given the purpose of
SML. 
.P
During discussions of SML within OSF, we also discussed
a number of new features, not currently supported within OSF documents,
that we might want to provide in SML.  In many cases, we did not
include these because they are Phase 2 work.  In other cases,
we included 
them marked clearly as "New Features."  If we
do implement
"New Features" macros, we will do so after we implement
the basic features.  Features such as support for
hypertext are not in this Phase 1 implementation at all, although
one set of new features allows us to preserve rudimentary browsing
information found in one of the sets of source documentation that we are
using.
.P
Because the macros are implemented using 
.BR nroff / troff 
macros, 
error messages and "debugging" support
from the language are limited or non-existent.  For this reason,
OSF is writing a syntax checker to ensure correct use of semantic
macros within documents.  This checker will run automatically as
part of our documentation build process. 
.H 3 "Contents of this Chapter"
.P
Section 2 of this Chapter describes the design of SML.  Sections
3 and 4 describe the 
two macro sets that comprise the language:
.BL
.LI
The general-purpose SML macro set GPSML (based
on \fBmm\fP with semantic extensions) and 
.LI
The reference SML macro set RSML (based on \fBman\fP
with semantic extensions).  
.LE
.P
Each subsection in sections 3 and 4 provides a table of the macros, with a discussion following the table.  
In some subsections, a "New Features" discussion 
describes additional macros that provide functionality not currently
found in OSF documents.
.H 2 "Design of SML"
.P
This section describes the design of SML, including the
.BL
.LI
Structure and syntax
.LI
Document model and context
.LI
Escape and extension mechanisms
.LE
.P
.H 3 "Structure and Syntax of the SML Macros"
.P
The semantic markup language consists of two intersecting macro sets.
Each set includes existing semantic
.B mm
or 
.B man
macros, as well as the
new macros we have defined to provide semantic constructs that
the current sets did not provide.
.P 
The first macro set is based on the 
.B mm 
macro language and our semantic extensions.
The second set is based on the \fBman\fP macro language.  The \fBman\fP-based set includes, as semantic
extensions, several macros that currently exist in \fBmm\fP but not \fBman\fP.  OSF will
need to do original work to
implement these \fBmm\fP macros in \fBman\fP because they are not part of
the \fBman\fP set, as we will for the rest of our
semantic markup.  However, we feel that the work required to implement
all the new macros will be offset by the added functionality, simplicity, and convenience
that these new macros will provide.
.P
The \fBmm\fP-based macro set is for use in general-purpose documents: guides,
architecture descriptions, and tutorials.  We call it General-Purpose
SML (GPSML).  The \fBman\fP-based set is
for use in reference documents; it provides semantic constructs useful
in creating reference pages.  We call it Reference SML (RSML).   As part of
OSF's build process, RSML source must translate to standard \fBman\fP macros and 
.B nroff
primitives so that the 
.B man
command will properly format the man page shipped in the
.B man 
directories with OSF's offerings.  This means that documentation groups modifying 
OSF documents start with RSML source, but translated source goes into the
build directories when OSF prepares an offering.
.P
.P
Certain
.B nroff/troff
escape sequences are used to provide an extended character set, for example, symbol
fonts or em dashes.  SML does not provide translations for these, since they
are not formatting directives per se.
.P
Wherever possible, the new macros we created 
use the format:
.BR .xX .
We use this format to make these macros easy to recognize, and to avoid
collisions with existing \fBmm\fP macros.  (They may collide with proprietary macros at
licensee sites, however.)  Inasmuch as possible with two-character names, we have 
tried to make the macros mnemonic, and given attention to their ease-of-use,
and to the readability of documentation source.
.H 3 "SML Design and Context"
.P
It is important to understand the documentation build environment
within which the SML macros are intended to operate.
The macros defined as part of SML are intended for use with 
a structure we call a 
.BR "description file" . 
The description file lists the files that make up a particular book,
and the order in which they will appear in the book.
A description file can be a DTE description
file like that described in Chapter 3,
or, it can be a script that also invokes the formatters
used to build the book (make file, a build script,
or some other structure.)  The
only requirement is that the description file contains information
about the files that comprise the book, and the order in which
they appear.  
.P
It is important to note that
the knowledge about the organization and sequence of the book is 
in the description file, not in the source files themselves.  Depending
on the granularity of the reorganization, writers can sometimes 
reorder major sections of a book just by reordering the sequence
of files in the description file.  
.P
We provide OSF documentation
with a build environment called Documentation Tools Environment
(DTE).  The DTE consists of build scripts and macro files that operate
on source files, and description files that are separate from
the build scripts.  Writers
use description files only to describe the structure of their documents, and the  
location of their source files.  When OSF 
licensees install DTE at their sites, the installation
program will put the OSF-supplied macro files 
(such as the ones containing the SML definitions)
in place.  The build tools also rely on the standard \fBmm\fP and \fBman\fP macro files
'ne 5v
provided by the Documenter's Work Bench* (DWB) packages at licensee sites. 
.FS *
Documenter's Work Bench is a trademark of AT&T, Inc.
.FE
.P
The DTE build scripts
take care of the synchronization required to create full books 
from multiple source files
with continuous page numbers, front matter, 
back matter, and so on.  Writers do not put synchronization information 
in any of their source files.  For this reason, description of SML does
not include constructs for synchronization, since
these constructs will not be found in OSF source files.  Likewise,
conditional building of source documents is part of the build environment
(implemented with C preprocessor directives and scripts);
we do not specify semantic macros for it.  Also, we do not specify
semantic constructs for elements that are built automatically by our
(or anyone's) build scripts, such as a table of contents. 
.P
.H 3 "SML Extensions and Escapes"
.P
In discussing the SML macros in the OSF Documentation group, several questions arose:
.BL
.LI
How do we provide a means of extending the macros to deal with cases that we do not know
of today, but that may come up as we continue our writing projects?
.LI
Are any 
.BR nroff / troff
primitives ever allowed in a document marked up with SML?
.LI
What do we do about the inevitable occasional situation in which we cannot make the 
SML macros translate to nicely formatted output?  
If we need to massage the source slightly in final production of
a book, for example, how do we indicate to SML that we have
added nonsemantic formatting information?  Obviously, such information should not
become part of the SML source; it is not semantic at all. 
.LE
.P
We believe that the need for extensions can be solved by our internal process,
in which a small committee reviews the need for additions to the macro set, and
we maintain the set and its documentation.  We also agreed that there might
be certain semantic
.BR nroff / troff
primitives that should be allowed.  One example that came up was the
define string
.RB ( .ds )
directive.  Rather than create a semantic macro to duplicate its
function, we decided that it was reasonable to allow the use of this
semantic primitive.  Another example was a one-line comment sequence.
.P
During the Information Architecture meeting, we came up with a number
of "allowable" escapes to pure formatting directives.  These are
based on the escapes allowed by Hewlett Packard's set of SGML
DTDs: HP-TAG.  The allowable escapes, many of which are
just 
.BR nroff / troff 
primitives used in defined ways, are described in
this chapter.
.ig yy
Instead of defining new macros 
We did not resolve the question about the occasional need to escape SML to add formatting
directives.  We 
.I could 
surround such sets of formatting directives with special
comments, and provide a script for removing them from SML source.  This is
an open question and we would like some ideas from SIG reviewers, based on
their plans for using OSF documentation source.
.P
Other than necessary escapes and semantic primitives like
.BR .ds ,
both of which should be exception cases,
writers producing documents with SML should not
use low-level 
.B nroff/troff
primitives.  Obviously, the formatting tools will accept them, but their existence
will make the source documents no longer semantic.
.yy
.H 2 "General-Purpose SML (GPSML) Macros"
.P
The macros in this section are for use in general-purpose, nonreference
text.  These macros are either existing \fBmm\fP macros that are already 
semantic, or new semantic macros 
that OSF has defined.
.P
The following sections describe groups of GPSML
macros for
.BL
.LI
Defining overall document structure
.LI
Delimiting titled elements within documents
.LI
Delimiting untitled elements within documents
.LI
Marking meaningful text strings
.LI
Marking index, key, and glossary entries
.LI
Providing inclusion, string expansion, and page markup information
.LI
Escaping semantic markup and providing formatting directives
.LE
.P
A table in each subsection lists the macros, their functions,
and their origin
(existing \fBmm\fP macro with semantic characteristics, or a new semantic
macro).  
Explanations follow many of the tables. 
.H 3 "GPSML Document Structure Definitions"
.P 
The GPSML macros in this section define the structure of
a document; they deal with the sections that
comprise a document.  Note that the structures in
this section are more oriented to hardcopy books than
to online document retrieval or instructional systems.
.P
.P
.ne 30
.TB "GPSML Macros That Define Overall Document Structure"
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
\&.H 1	First-level head (Chapter in a book)	Existing \fBmm\fP macro
\&.H 2	Second-level head (1st-level head in a book)	Existing \fBmm\fP macro
\&.H 3	Third-level head (2nd-level head in a book)	Existing \fBmm\fP macro
\&.H 4	Fourth-level head (3rd-level head in a book)	Existing \fBmm\fP macro

\&.zS	Appendix begins	New semantic macro
\&.zE	Appendix ends	New semantic macro

\&.xS	Title page begins	New semantic macro
\&.xE  	Title page ends	New semantic macro

\&.yS	Disclaimer (copyright) page begins	New semantic macro
\&.yE	Disclaimer (copyright) page ends	New semantic macro

\&.qS	Preface begins	New semantic macro
\&.qE	Preface ends	New semantic macro
.TE
.B .H 
.I number
macros mark sections that are sequential and hierarchical.  They delimit
sections of a document that have a structural relationship to one another.
These headers display an alphabetic character,
numeric character, or no character depending on the particular formatting
system.  (Rather than specifying a set of hierarchical unnumbered head macros to
match the numbered head macros, we will implement this as a variant of the
numbered head macros.)
Depending on documentation conventions, writers can use either unnumbered 
or numbered heads in chapters or appendices. 
.P
At OSF, we use keywords in our description files to identify parts
of the book as disclaimer, appendix, etc.   So as to provide an equivalent
structure for documentation groups that don't use our tools, or who
are translating our documents, our build
tools will put the appendix, title, disclaimer, and preface
in appropriate places in our documents, so that translators
can find them.  However, these macros won't provide any particular function in
our documents; they are there to be picked up by translators or groups that
want an in-document method of identifying the beginning and end of such
sections.
.P
Note that previous definitions of SML had a glossary (wordlist) macro pair:  
.BR (.wS/.wE) .
We have not implemented this macro pair, because it does not fit 
into the tools we provided for an automatically generated glossary. 
.ig ++
A better semantic representation of sequential hierarchical relationships
would likely not include any number specifiers, or tie sections so closely
to the model of a hard-copy book.  This is an instance where we used
existing macros rather than inventing new ones that would be more general.
\fBREVIEWERS:\fR Is this true? Is the number or letter in a numbered head
really part of the semantic of the head?  Or is this formatting information
that should be left out?  The way it is written is to be consistent with
the approach to lists, in the next section.  
.++
.H 3 "Delimiters of Titled Document Elements in GPSML"
.P
The macros in this section delimit one set of the
elements that make up a document.  The elements
in this set all have titles associated with them.
.P
.ne 23
.TB "GPSML Macros That Delimit Titled Elements of a Document"
.TS H
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status\fR 
_
.TH
_
\&.TB	Table title	Existing \fBmm\fP/\fBman\fP macro
\&.TS	Start table	Existing \fBmm\fP/\fBman\fP macro
\&.T&	Table continue	Existing \fBmm\fP/\fBman\fP macro
\&.TE	End table	Existing \fBmm\fP/\fBman\fP macro
\&.TH	Table header ends	Existing \fBmm\fP macro
\&.tH	Table header ends	New semantic macro (equiv. to .TH) 
			
\&.FG	Figure title	Existing \fBmm\fP/\fBman\fP macro
\&.PS	\fBpic\fP drawing start	Existing \fBmm\fP/\fBman\fP macro
\&.PE	\fBpic\fP drawing end	Existing \fBmm\fP/\fBman\fP macro
			
\&.pR "procedure_name"	Procedure title	New semantic macro
\&.pS	Procedure start	New semantic macro
\&.pE	Procedure end	New semantic macro

\&.EC	Equation caption	Existing \fBmm\fP/\fBman\fP macro
\&.EN	End equation	Existing \fBmm\fP/\fBman\fP macro
\&.EQ	Start equation	Existing \fBmm\fP/\fBman\fP macro

\&.EX	Exhibit caption	\fBmm\fP macro
.TE
.P
Note that previous definitions of SML provided an artwork region
macro pair:  
.BR (.aS/.aE) .
We did not implement this macro pair, because we could
not find any use for it; the pic and Postscript*
.FS *
Postscript is a registered trademark of Adobe, Inc.
.FE
inclusion macros seemed adequate for our purposes.
.P
Writers often want to list in the table of
contents the titles of titled elements. 
The titles must also
stay with the material in the element.  Semantically, there
must be a link between the title and the element; it should
be known that a particular title goes with a particular
element.  In our current
implementation, the formatting tools will derive the link from
the context in which the title appears.  The title will directly
precede the start of the element in the source code, although
this is not a required part of the layout.
.P
This is
another case in which we could have provided a more general semantic
structure (element with title) and allowed it to have various   
attributes (figure, table, etc.).  However, we did not because
existing \fBmm\fP mechanisms already existed.
.P
Note that the
.B .tH
macro is equivalent to the  
.B .TH
macro.  We are going to attempt to implement this function in RSML
as well as GPSML; it attaches table headers to split tables.
To avoid conflict with the existing
.B man
.B .TH
macro, we will call the RSML macro
.BR .tH .
In GPSML either
.B .tH
or
.B .TH
are permitted.  
.ig ++
\fBREVIEWERS:\fR Are these stipulations too format-oriented, or
are they really semantic? 
.++
.ig ++
.P
Because it is very common in documents to cross-reference
titled elements, the need for a cross-reference
scheme often comes up when discussing such elements.  Because
the formatters and the macro sets do not currently provide
cross-references, we are investigating development of tools
that would support them.  The tags used in cross references
would not be part of the macro set; rather, they might be
a special type of comment that the tools could recognize.  We
did not enhance titled elements to provide cross-references to them;
rather this will be part of a general cross-referencing scheme. 
.++
.H 3 "Delimiters of Untitled Elements in GPSML"
.P
This section discusses elements that are typically untitled:
paragraphs, lists, and special-purpose elements we call
.IR regions .
.P
.ne 40
.TB "GPSML Macros That Delimit Untitled Elements of a Document"
.TS H
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status\fR 
.TH
_
\&.P	Paragraph	\fBmm\fP macro
\&.PP	Paragraph	\fBman\fP macro; we add to \fBmm\fP
_
\&.ML	Start nonsequential invariant list	Existing \fBmm\fP macro
\&.VL	Start nonsequential variant list	Existing \fBmm\fP macro
\&.AL	Start sequential invariant list	Existing \fBmm\fP macro
\&.LI	List item	Existing \fBmm\fP macro
\&.LE	End of list	Existing \fBmm\fP macro
_
\&.iS	Start user input example region	New semantic macro
\&.iE	End user input example region	New semantic macro

\&.oS	Start system output example region	New semantic macro
\&.oE	End system output example region	New semantic macro

\&.tS	Start set-off text piece region	New semantic macro
\&.tE	End set-off text piece region	New semantic macro

\&.gS	Start glossary entry region	New semantic macro
\&.gE	End glossary entry  region	New semantic macro
			
\&.FS	Start footnote region	Existing \fBmm\fP macro
\&.FE	End footnote region	Existing \fBmm\fP macro
\&\e*F	Place footnote here	\fBmm\fP macro
				
\&.RS	Start reference region	Existing \fBmm\fP macro
\&.RF	End reference region	Existing \fBmm\fP macro
			
\&.nS 	Start note region	New semantic macro
\&.nE	End note region	New semantic macro
			
\&.cS	Start comment region	New semantic macro
\&.cE	End comment region	New semantic macro
\&...\e"	One-line comment	Existing markup

\&.lS	Start localization region	New semantic macro
\&.lE	End localization region	New semantic macro
_
\&.mA	Manual title (for title page)	New semantic macro
\&.rV	Manual revision (for title page)	New semantic macro
\&.cO	Manual copyright (for disclaimer)	New semantic macro
\&.aU	Manual author (for title page)	New semantic macro
\&.oN x	Manual order number (for title page)	New semantic macro

.TE
.H 4 "Paragraphs"
The 
.B .P
macro defines a paragraph, and, more generally, a separation
between the current element and the previous element.  As such, it
might replace the
.B .sp
.B troff
primitive in situations where the writer wants to physically force
separation of two contiguous elements. 
.H 4 "Lists"
The next block in the table provides list macros.
The list macros defined here are \fBmm\fP macros, used with 
a specific semantic meaning.  Lists can be variant
or invariant, and sequential or nonsequential.
.P
An
.I invariant
list is one in which the list marker does not change
from item to item.  Bulleted and dashed lists are 
invariant lists.  However, rather than use the
.B .BL
or
.B .DL
macros, which dictate a particular formatting style for
the list (bullets or dashes), we used the more general
.B .ML
macro.  A translation of the semantic construct would 
allow this macro to default
to the particular layout style that an organization uses.  For
example, according to the OSF Style Guide, the coding
.DS I  \e"*** I=standard indent
.ft CW
\&.ML
\&.LI
An item 
\&.LI
Another item
\&.LI
Another item
\&.ML
\&.LI
An item  
\&.LI
Another item
\&.LI
Another item
\&.LE
\&.LE
.DE
.ft R
translates to the following list because our conventions
dictate bulleted lists with dashed lists for nested lists:
.BL
.LI
An item 
.LI
Another item
.LI
Another item
...\e"**************************************************
...\e"		Dashed list (within the bulleted list)
...\e"**************************************************
.DL
.LI
An item  
.LI
Another item
.LI
Another item
.LE      \e"*******end of dashed list
.LE      \e"*******end of bulleted list
.P
A
.I variant
list is one in which the list marker changes from item
to item.  The variable list macro 
.B .VL 
provides this functionality.
.P
The variable list macro takes the same text-indent,
mark-indent, and [1] (tighten) arguments as in \fBmm\fR.
Although these are not semantic, they are necessary escapes. 
.P
A sequential list is one in which the list markers show
the sequence (depending on formatting conventions,
the list might translate to numbers or letters).  Markers
in a nonsequential list do not provide sequencing information.
.P
List items also can take the mark-text and tighten arguments,
as in
.BR mm . 
.H 4 "Regions"
.I Regions
are places in a document for 
specialized types of information.  This section describes
the regions listed in the table, which are those that
currently exist in OSF documents.
.P
The output example macro pair 
.RB ( .oS 
and
.BR .oE )
delimits an example system output display.  In
layout terms, this might translate to a monospace font, screen
display, or some other convention.  Manuals
often use such a construct for displaying code samples or
screen output.
For example:
.P
.DS I  \e"*** I=standard indent
.ft CW
12345678902234567890234567890423456789052345678906234567890
12345678902234567890234567890423456789052345678906234567890
.ft R
.DE
The input example macro pair 
.RB ( .iS 
and
.BR .iE )
delimits an example system input display.  In
such displays, the writer is showing how to invoke a
particular attribute of the software or hardware.
For example:
.P
.in +2
.RB % "ls -a"
.I directoryname 
.in -2
.P
Documents often combine input and output examples to show
the results of a certain input.  For example:
.P
.in +2
.RB % "ls -l"
.I directoryname 
.in -2
.P
.DS I  \e"*** I=standard indent
.ft CW
a.out
example.c
example1.c
.ft R
.DE
In the input example region, there is often a requirement to
show many keywords, variable names, and sometimes system
prompts.   Section 2.4 discusses in detail the
markup requirements for such semantic constructs in
the input region.
.P
The set-apart text macro pair 
.B .tS 
and
.B .tE 
delimits text that
does not change appearance to show meaning, but that
the writer wants to set apart somehow from other
text.  This might be used in informal lists of words, such 
as:
.P
.DS I   \e"*** I=standard indent
red
green
blue
purple
gray
.DE
.P
The note macros
.RB ( .nS 
and
.BR .nE )
start and end an advisory to the reader.  Technical documents contain advisories
of various types: notes, cautions,
and so on.  The macro argument allows you to specify the
type of advisory.  
For example,
.B .nS
.B caution
starts a caution.
.P
The localization macro
pair
.RB ( .lS 
and
.BR .lE )
indicates that the material inside the region 
is locale-dependent.  This is used in documenting 
software, such as OSF/1, that provides the
ability to localize for various locales (national and linguistic
regions).  When a writer marks text as locale-dependent,  it
flags writers who are creating localized versions of the documentation. 
The macro has no meaning except as a flag.
.P
The term
.I footnote
to describe the footnote macro is less than semantic.  The semantic construct
might be a note that is in a different location than the text, such as a gloss
or even a note linked in a hypertextual fashion.  However, the existing 
.B mm
construct is simply a footnote. 
.H 4 "One-Line Regions"
We provide several macros for elements of the title and disclaimer
page.  The text appears on the line with the macro, so no ending
delimiter is needed. 
.H 4 "New Features for Untitled Elements"
.P
The
.BR .RS \/ .RF
macro pair currently marks text that creates a reference list
in the back of a document.  As a new feature, we may reimplement
this macro to make it provide primitive cross-referencing support.  
.P
Another set of new features macros we will consider are those
that mark information that comes from a database that we use
to track information about the functionality in OSF offerings.
Over time, we hope to generate more and more pieces of
our documentation offering directly from this database
(because the database will expand to include more and
more documentation).
.H 3 "Marking Meaningful Text in GPSML"
.P
The macros in the previous sections delimit 
elements of a document.  In typical use, macros delimit 
a section, block of text, illustration, etc.
The macros in this section,
however, tag elements that always occur within other 
elements.  They may occur within lines of
text, and need to be associated with punctuation.
The elements may be individual words
or phrases, such as names for commands or subroutines within
a software product.  
We call these elements
.IR "meaningful text" .
.P
Development of the meaningful text macros was
difficult because of the limitations imposed by
the 
.BR nroff / troff
processors and the different contexts in which 
meaningful text occurs.  Also, 
because meaningful text 
appears so frequently, this markup must be very easy to use.
Meaningful text markup should not be implemented as start/end
pairs, for example, because meaningful text occurs so frequently that
it would be very cumbersome to use two marks for
each occurrence.
.P
In this section, we discuss the
concepts before introducing the markup in the table. 
.H 4 "The Regions in Which Meaningful Text Occurs"
.P 
In considering the marking of meaningful text, we considered
the types of elements in which this text usually occurs.  Most
common are 
.BL
.LI
Paragraphs of text that mention the meaningful word
within a sentence.  We call these in-line text markings. 
.LI
Input examples, as discussed in Section 2.3.3.
.LI
Synopses of software or hardware elements that define syntax.
In these cases, there are semantic relationships among meaningful
elements, such as inclusion or exclusion, required or
optional usage, and either/or relationships. 
.LE
.P
Each region has different requirements.  For in-line text,
it must be easy to combine punctuation with the marked text.  For
input examples, it must be easy to combine marked text of different
types, such as literal keywords with symbols for variable names with
output display types.  For synopses, it must be easy to show
inclusion or exclusion, required or optional status, and either/or
relationships. 
.P \" fld
.B
NOTE:
This description does not provide a semantic markup for 
required/optional,
either/or, etc relationships.
.R
.P
We discuss synopses as part of GPSML, although the most
common use of synopses is in reference documents.  All the
concepts discussed in this section also apply to
RSML.
.H 4 "Types of Markings for Meaningful Text"
.P
We have identified
.I atomic
meaningful text markings,
which mark basic semantic elements.  Note that 
instead of marking
text with macros, we do so with strings.  The advantage
of this technique is that writers can use the
same markup in tables and equations as they use
in text.  (Dealing with tables was one of the major
open issues of the initial SML proposal.)  One
change is that we no longer provide semantic macros for
required/optional,
either/or and other such relationships.  Rather, we
use the standard symbols, such as [ ] and | with their
built-in semantic meanings.
.P
The atomic text markings proposed here are the following:
.BL
.LI
.I literal
.LI
.I variable
.LI
.I constants
.LI
.I "system output"
.LI
.I "ordinary text"
.LE
.P
The basic construct for all text elements is as follows, where 
X symbolizes the initial letter of the markup:  
.br
.IB \e*Xtext-element \e*O
.P
A
.I literal
is the actual name of an atomic entity in the
software or hardware product.  
Users must name the entity literally.
Another possible use of a literal is
for a real name in an example.  Commands, command
options, literal command arguments, 
file or directory names, and keywords in
a programming language are all examples of literals
(e.g.,
.B grep
is a literal).
These appear in synopses, input
examples, and in-line text.  
The markup that marks a literal is
.B \e*L
.I literal-name 
.BR \e*O ,
where the
.B \e*L
introduces the literal, and the
.B \e*O
returns to ordinary text.
.P
A 
.IR variable ,
in contrast to a literal, is a symbol for a value that  
is not invoked literally, but for which a user 
substitutes the appropriate value.  Most command arguments and function call parameters
are variables
(e.g.,
.I filename
is a variable).
These appear in synopses, input
examples, and in-line text.  
The markup that marks a variable is
.B \e*V
.I variable-name 
.BR \e*O .
.P
See Section 2.4.5 for a discussion of additional requirements,
as yet unspecified, for marking literals and variables.
.P
.I Constant
markings show that a piece of text is an alphabetic or
numeric constant.  It must be invoked literally, but it
is not interpreted by the system as a keyword in a
programming language.  
These appear in synopses, input
examples, and in-line text.  
There are two constant markups:
.B \e*A
.I constant-name 
.B \e*O
for alphabetic constants,
and
.B \e*N
.I constant-name 
.B \e*O
for numeric constants.
.P
.I "Computer output"
markings show that a piece of text shown in an
input example or in a sentence 
is output by the system.  These are not whole
sections, but usually a piece of text that is part of another
element.  The system output markup is
.B \e*C
.I "computer output"
.BR \e*O .
.P
The atomic markings may be used anywhere within a document,
and may take on special appearances within certain contexts.
An important context for
use of meaningful text markup is in synopses lines, 
both for shell commands and function declarations.
.P
A "command synopsis grouping"
is a construct for delimiting the extent of text and markup codes
that represent a shell command and its arguments.
Within this context,
the semantic markup for atomic markup produces an appearance
appropriate for the traditional UNIX-style synopsis line.
The specific macros for delimiting a synopsis context are
.DS I F
.B \&.sS
(start a synopsis definition)

.B \&.sE
(end a synopsis definition)
.DE
.P
Between these macros,
the writer may place text combined with the atomic markup introduced above.
Synopses markup should indicate
.I either/or
of arguments with the traditional vertical bar,
.BR | ,
and
.I optional
arguments with the traditional square braces,
.B [
and
.BR ] .
Note that documentation groups may choose to reproduce
these characters exactly in the output
to show traditional synopses lines,
or may choose to translate them into other formats.
For example,
if XYZ Corp.
wishes to reformat OSF's documents,
but doesn't want to use the
.BR | ,
.BR [ ,
and
.B ]
characters,
they may freely translate those characters,
.IR "within the \fB.sS\fR to \fB.sE\fR context" ,
to their own layout style.
.P
A
.I "function declaration grouping"
is a common construct in the
description of functions (programming interfaces) 
in programming documentation.  Typically, these
appear in synopses, although function names
appear frequently in running text.  A function description
must show the function name, and the declaration of
the types of function parameters.  Literals, variables,
and constants appear with the function declaration
grouping macro because they are the atomic
elements that comprise the function declaration.
.P
The macros used for describing
relationships within functions are
.P
.DS I F
.B .fS
(start a function definition)

.B .fE
(end a function definition)

.B .dS
(start a type declaration)

.B .dE
(end a type declaration)
.DE
.P
Note that these macros are based on common usage in
OSF documents, which describe C-language based
programming interfaces.  We welcome any feedback
from organizations that provide documentation in other
languages because we would like even these macros
to be as general-purpose as possible; we do not want
to limit their use to documentation for systems based on
a particular programming language.
.H 4 "Meaningful Text Markup Summary"
.P
The following table summarizes the meaningful text macros and markup.
The first block shows atomic macros and markup.  The second and third
blocks show grouping macros.
.P
.ne 20
.TB "GPSML Meaningful Text Markup"
.TS H
center,box;
l | l | l.
\fBMarkup code	Function	Macro Origin and Status \fR 
.TH
_
\&\e*Lname\e*O	Literal	New semantic markup
\&\e*Vname\e*O	Variable	New semantic markup
\&\e*Aname\e*O	Alphabetic constant 	New semantic markup
\&\e*Nname\e*O	Numeric constant 	New semantic markup
\&\e*Oordinary text	Ordinary Text 	New semantic markup
\&\e*ISystem input\e*O	System Input 	New semantic markup
\&\e*CComputer output\e*O	Computer Output	New semantic markup
_
\&.sS	 Start synopsis definition	New semantic markup
\&.sE	 End synopsis definition	New semantic markup

\&.fS	 Start function definition 	New semantic markup
\&.fE	 End function definition 	New semantic markup

\&.dS [opt]	Start type declaration 	New semantic markup
\&.dE	End type declaration 	New semantic markup
.TE
.P
Note that when one type of semantic element abuts another of a different type,
the intervening \e*O need not occur.
So, for example,
consider a literal flag that takes a variable argument,
such as a flag that names a filename.
It could be encoded as
.P
.ft CW
.in +2
\&\e*L-f\e*O\e*Vfilename\e*O
.P
.in -2
.ft R
or, more concisely, as
.ft CW
.in +2
.P
\&\e*L-f\e*Vfilename\e*O
.in -2
.ft R
.P
Note also that,
by convention,
any atomic elements on a line must always return to the ordinary text
type on that same line of input.
Put another way,
any line that contains atomic element markup must include a \fB\e*O\fR
as the last atomic markup on the line (although it may itself be followed by text).
.H 4 "Meaningful Text Macro Examples"
.P
The next few paragraphs show examples of the use of these macros.
The examples use the OSF conventions, in which a literal is formatted in bold, 
a variable in italics, and the output in constant width,
although, obviously, since this is semantic markup, 
these conventions are not enforced by the
use of this markup.
.P
In this first example, we want to produce a
sentence with a list of keywords and
variable names mixed with punctuation, as follows:
.P
.in +2
The commands
.BR cp , 
.BR mv ,
and
.B rm
all use 
.I name
as an argument,
where
.I name
can be a file or directory
name.
.in -2
.P
To code this sentence with GPSML, we would use the following coding:
.ig ++
.DS I  \e"*** I=standard indent
.ft CW
The commands \e*(L)cp\e*(O), \e*(L)mv\e*(O), and \e*(L)rm\e*(O)
all use \e*(V)name\e*(O) as an argument,
where \e*(V)name\e*(O) can be a file or directory name.
.ft R
.DE
.++
.DS I  \e"*** I=standard indent
.ft CW
The commands \e*Lcp\e*O, \e*Lmv\e*O, and \e*Lrm\e*O
all use \e*Vname\e*O as an argument,
where \e*Vname\e*O can be a file or directory name.
.ft R
.DE
.P
The next example shows the use of the literal, variable, and system
output markup in an input
example.  Using our conventions, we want to produce the following output:
.P
.in +2
.ft CW
%
.ft R
.B "ls -l"
.I directoryname 
.in -2
.P
The coding is
.DS I
.ft CW
\&\e*S)% \&\e*Lls -l \&\e*Vdirectoryname\e*O 
.DE
.P
The next example shows a synopsis for a command with two mutually exclusive, nonrequired
options, and one required option.
In the OSF style, this would display as follows:
.P
.in +2
.B command
.B -option1 
.I filename
.RB [ -option2
.I some_value 
\fR|
.B option3
.IR some_other_value ] 
.in -2
.P
The GPSML coding is;
.oS
\&\e*Lcommand -option1 \e*Vfilename \e*L[ -option2 \e*Vsome_value \e*O|
\&\e*L-option3 \e*Vsome_other_value \e*L \e*O]
.oE
.P
The next example shows a more complex command synopsis.  It has
two nonexclusive, nonrequired options, and some nested optional relationships.
In the OSF style, this would display as follows:
.P
.in +2
.B command
.RB [ -option1 
.IR filename ]
.RB [ -option2 
.IR some_value ] 
.RB [ -option3 
.RB [ -option 4
.IR some_other_value "] ]"
.in -2
.P
The GPSML coding is;
.oS
\&\e*Lcommand [-option1 \e*Vfilename\e*L] [-option2 \e*Vsome_value \e*O
\&[\e*L-option3 [-option4 \e*Vsome_other_value\e*O] ]
.ft R
.oE
.P
Note that the default output behavior for command synopses is for fill mode.  However, the
default output for function synopses is no-fill mode. 
.P
The final example shows a synopsis for a function.  It combines a number
of literals and variables with function definitions and declarations.
The output is
.P
.in +2
.B "#include <header_filename>"
.br
.B function_name( 
.IR arg1 ,
.IR arg2 )
.br
.BI "arg1_type " "arg1"
\fR;
.br
.BI "arg2_type " "arg2"
\fR;
.in -2
.P
The GPSML coding is
.DS I
.ft  CW 
\&\e*L#include <header_filename>\e*O
\&.fS function_name
\&\e*Varg1\e*O, \&\e*Varg2\e*O
\&.fE
\&.dS arg1_type
\&\e*Varg1\e*O
\&.dE
\&.dS arg2_type
\&\e*Varg2\e*O
\&.dE
.ft R
.DE
.P
We optimized this coding for function prototypes in
the C language.  So,
with function prototypes, 
the coding is simpler:
.DS I
.ft CW
\&.fS function_name
\&.dS arg1_type
\&\*Varg1\*O
\&.dE
\&.dS arg2_type
\&\*Varg2\*O
\&.dE
\&.fE
.DE
.H 3 "Tagging Index, Key, and Glossary Entries"
This section provides macros for tagging index, key,
and glossary entries.  Note that the break macro constructs
described previously combine with some of the macros in this group.
.P
.ne 22
.TB "GPSML Macros for Tagging Index, Key, and Glossary Entries"
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
\&.kY "key"	Name of keyboard key	New semantic macro
\&.K, "key" "text"	Keyboard key name + ordinary text	New semantic macro
\&.,K "text" "key"	ordinary text + keyboard key name	New semantic macro

\&.gL "term" 	Glossary term	New semantic macro
\&.G, "term" "text"	Keyboard key name + ordinary text	New semantic macro
\&.,G "text" "term"	ordinary text + keyboard key name	New semantic macro

\&.eM "phrase"	Emphasized phrase	New semantic macro
\&.G, "phrase" "text"	Emphasized phrase + ordinary text	New semantic macro
\&.,G "text" "phrase"	ordinary text + emphasized phrase	New semantic macro

\&.OK	Key words	Existing \fBmm\fP macro

\&.iX	Index entry	New semantic macro
.TE
.H 4 "Descriptions of Tagging Macros"
.P
The 
.BR .kY , 
.BR .gL , 
and
.B .eM
macros all mark text set apart because it has a special use.
The 
.BR .kY
macro shows a keyboard key.
The 
.BR .gL
macro shows a word that is defined in the book's glossary.
(This might work with a tool that actually placed the word in
the book's glossary.)
The
.B .eM
macro shows text included for emphasis.
Examples of the use of these macros follow.
.P
To show that the next word is a keyboard key, writers would use
the following coding:
.DS I
.ft CW
Use 
\&.kY "Return"
to enter the data.
.ft R
.DE
.P
To show that the next word or phrase is defined in the
glossary, writers would use the following coding: 
.DS I
.ft CW
The next section discusses the socket interface
\&.gL "socket interface"
in detail
.ft R
.DE
.P
To emphasize the word 
.I meaning
in the
next sentence, writers would use the following coding:
.DS I
.ft CW
This method of coding documents emphasizes the
\&.eM "meaning" 
of each element in the document.
.ft R
.DE
.P
See Chapter 2 for a description of the index macro.
.ig yy
.H 4 "New Tagging Features"
.P
In addition to the extensions to the existing index macro,
an additional semantic macro is planned.  (This may not be implemented
until after the rest of the semantic 
.B troff 
macros have been implemented.)
The
.B \&.pX
macro will mark a privileged index entry.  This entry will work with tools
that do defined kinds of permutations to produce "templates" for index
entries.  For example, the template might automatically create an inverted
reference in addition to the existing reference.  When a writer uses
a privileged index tag, a separate tool would automatically create permuted index
entries such as the following:
.P
.in +2
ls, 2-3
.P
commands,
.br
.in +2
ls, 2-3
.in -4
.yy
.H 3 "Inclusion, String Expansion, and Page Mark Up in GPSML"
.P
The macros in this subsection provide functions for
including entities of different types, for string expansion and
for specifying the text for inclusion in headers and footers.  The
"New Features" section describes additional macros we might add
after the initial implementation.
.P
.ne 10
.TB "GPSML Macros That Include, Define Strings, and Mark Up Pages" 
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
\&.dI subdocument_name	Include subdocument of same type	New semantic macro
\&.eI subdocument_name	Include subdocument of example type	New semantic macro
\&.pI subdocument_name	Include PostScript subdocument	New semantic macro

\&.ds	Define string for expansion	Existing markup

\&.pM	Page markup information	New semantic macro
.TE
.FS *
PostScript is a registered trademark of Adobe Systems, Inc.
.FE
.H 4 "Inclusion, Definition, and Page Markup Macro Descriptions" 
.P
All of the inclusion macros tell the formatter to bring in material from
a separate file.  There are two special-purpose inclusion macros:
.B .eI 
and
.BR .pI .
The
.B .eI
macro
tells the formatter that the document being included is an output example
that is to be displayed
in monospace font without
formatting information.  This is useful, for example, for including programming
examples that are stored in separate files.
The PostScript inclusion macro 
.B .pI
tells the formatter that the included document
is an encapsulated PostScript document.
.P
The 
.B .ds
.BR nroff / troff
primitive
provides string expansions.  The syntax for its use is 
.P 
.in +5
.B .ds 
.I stringname
.I string_to_be_expanded
.in -5
.P
.I stringname
must be no more than two characters.
.P
The
.B .pM
macro delimits page markup information the writer 
wants to specify.  Page markup information is a semantic
way of describing the information that is included in
headers, footers, and other "margin" information.
Unlike the header and footer macros that
it replaces, this macro does not delineate the format and layout
of headers and footers, or even, theoretically, the fact
that they are headers and footers.
.P
Note that this macro is not implemented yet, but is
reserved for future use.
.H 4 "New Features"
We are reserving the following special comment names to allow us
to preserve constructs provided in 
.B texinfo
documentation that comes with
the GNU programming environment.  These comments will
allow us to
preserve the texinfo information as comments in our
translations.  The comment forms are
.BL
.LI
.B ...\e\\" 
.BR node / .node
.EM  
translate the 
.B texinfo 
command 
.BR @node ,
that marks a node of information
.LI
.B ...\e\\" 
.BR menu / .menu
.EM  
translate the
.B texinfo 
command 
.B @menu
that sets up a menu
.LI
.B ...\e\\" 
.BR setf / .setf
.EM 
translate the
.B texinfo
command
.B @setfilename
that produces a
.BR texinfo -
readable output file named 
.I filename
.LI
.B ...\e\\" 
.BR summ / .summ
.EM 
translate the
.B texinfo
command
.B @summarycontents
that produces a
summary table of
contents.
.LE
.H 3 "Escape Mechanisms"
.P 
This section describes the allowable escape mechanisms
in GPSML.  Escapes allow a writer to insert formatting
directives.  These escapes are a combination of macros
and primitives
from
.BR nroff / troff .
.P
.ne 8 
.TB "GPSML Markup For Escapes" 
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
\&.nP	Force a page break here	New "semantic" macro
\&.ne x	Reserve x lines on one page	Existing markup
\&.nL	Force a line break	New "semantic" macro	

\&.wH	Tag text converted from another language, not recognized	New semantic macro
.TE
.H 2 "Reference Page Macros (RSML)" 
.P
The RSML macros in this section are for use in reference
text.  These macros are either existing \fBman\fP macros to which OSF 
gives semantic meanings, \fBmm\fP macros with semantic meaning
that OSF will add to the \fBman\fP set, or new semantic macros 
that OSF will define.  Many of the macros discussed here
appeared in Section 2; we do not redefine them if their
use is the same.
.P
A table in each of the following sections lists macros, their functions,
and their origin
(existing \fBman\fP macro with semantic characteristics, or a new semantic
macro).
.H 3 "RSML Document Structure Definitions"
The macros in this section define the structure of
a document; they deal with headers and the table of
contents.  
.P
.ne 6
.TB "RSML Macros That Define Document Structure"
.TS
center,box;
l | l l.
\fBMacro Name	Macro Function	Macro Origin and Status\fR 
_
\&.TH	Top head in reference page	Existing \fBman\fP Macro
\&.SH	Text head in reference page	Existing \fBman\fP Macro
\&.SS	Subhead in reference page	Existing \fBman\fP Macro
.TE
.H 3 "Delimiters of Document Elements in RSML"
.P
The macros in this section delimit the various
elements that comprise a document: paragraphs, figures,
tables, and lists.   As in GPSML, we group
titled elements separately from untitled elements.
.P
.ne 23
.TB "RSML Macros That Delimit Titled Elements of a Document"
.TS H
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status\fR 
_
.TH
_
\&.TB	Table title	Existing \fBmm\fP/\fBman\fP macro
\&.TS	Start table	Existing \fBmm\fP/\fBman\fP macro
\&.TE	End table	Existing \fBmm\fP/\fBman\fP macro
\&.T&	Table continue	Existing \fBmm\fP/\fBman\fP macro
\&.tH	Table header ends	New semantic macro (equiv. to .TH) 
			
\&.FG	Figure title	Existing \fBmm\fP/\fBman\fP macro
\&.PS	\fBpic\fP drawing start	Existing \fBmm\fP/\fBman\fP macro
\&.PE	\fBpic\fP drawing end	Existing \fBmm\fP/\fBman\fP macro
			
\&.EC	Equation caption	Existing \fBmm\fP/\fBman\fP macro
\&.EN	End equation	Existing \fBmm\fP/\fBman\fP macro
\&.EQ	Start equation	Existing \fBmm\fP/\fBman\fP macro

\&.EX	Exhibit caption	\fBmm\fP macro
.TE
.P
For information about the macros in this table, refer
back to Section 2. 
.P
.ne 35
.TB "RSML Macros That Delimit Untitled Elements of a Document"
.TS H
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status\fR 
.TH
_
\&.P	Paragraph	\fBmm\fP macro
\&.PP	Paragraph	\fBman\fP macro; we add to \fBmm\fP
_
\&.ML	Start nonsequential invariant list	\fBmm\fP macro; we add to \fBman\fP
\&.VL	Start nonsequential variant list	\fBmm\fP macro; we add to \fBman\fP
\&.AL	Start sequential invariant list	Existing \fBmm\fP macro; we add to \fBman\fP
\&.LI	List item	\fBmm\fP macro; we add to \fBman\fP
\&.LE	End of list	\fBmm\fP macro; we add to \fBman\fP
_
\&.oS	Start system output example region	New semantic macro
\&.oE	End system output example region	New semantic macro
			
\&.iS	Start user input example region	New semantic macro
\&.iE	End user input example region	New semantic macro

\&.RS	Start reference region	\fBmm\fP macro; we add to \fBman\fP
\&.RF	End reference region	\fBmm\fP macro; we add to \fBman\fP

\&.rS	Start indent region	Equivalent to .RS* 
\&.rE	End indent region	Equivalent to .RE
			
\&.cS	Start comment region	New semantic macro
\&.cE	End comment region	New semantic macro
\&...\e"	One-line comment	Existing markup

\&.lS	Start localization region	New semantic macro
\&.lE	End localization region	New semantic macro
.TE
.P
*We do not recommend the use of .rS/.rE.
.P
For information about the macros in this table, refer
back to Section 2. 
.H 3 "Marking Meaningful Text in RSML"
.P
The macros in the previous two sections delimit 
elements of a document.  In typical use, a macro starts
and ends a block of text, illustration, etc.
The macros in this section,
however, mark elements that usually occur within lines
of text, for example, individual words.  
.P
.ne 20 
.TB "RSML Meaningful Text Markup"
.TS H
center,box;
l | l | l.
\fBMarkup code	Function	Macro Origin and Status \fR 
.TH
_
\&\e*Lname\e*O	Literal	New semantic markup
\&\e*Vname\e*O	Variable	New semantic markup
\&\e*Aname\e*O	Alphabetic constant 	New semantic markup
\&\e*Nname\e*O	Numeric constant 	New semantic markup
\&\e*Oordinary text	Ordinary Text 	New semantic markup
\&\e*ISystem input\e*O	System Input 	New semantic markup
\&\e*CComputer output\e*O	Computer Output 	New semantic markup
_
\&.sS	 Start synopsis definition	New semantic markup
\&.sE	 End synopsis definition	New semantic markup

\&.fS	 Start function definition 	New semantic markup
\&.fE	 End function definition 	New semantic markup

\&.dS [opt]	Start type declaration 	New semantic markup
\&.dE	End type declaration 	New semantic markup
.TE
.P
.ne 35 
.H 3 "Tagging Text in RSML"
.P
These macros tag text in RSML.  For more information,
see Section 2.
.P
.ne 22
.TB "RSML Macros for Tagging Index, Key, and Glossary Entries"
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
\&.kY "key"	Name of keyboard key	New semantic macro
\&.K, "key" "text"	Keyboard key name + ordinary text	New semantic macro
\&.,K "text" "key"	ordinary text + keyboard key name	New semantic macro

\&.gL "term" 	Glossary term	New semantic macro
\&.G, "term" "text"	Keyboard key name + ordinary text	New semantic macro
\&.,G "text" "term"	ordinary text + keyboard key name	New semantic macro

\&.eM "phrase"	Emphasized phrase	New semantic macro
\&.E, "phrase" "text"	Emphasized phrase + ordinary text	New semantic macro
\&.,E "text" "phrase"	ordinary text + emphasized phrase	New semantic macro

\&.OK	Key words	Existing \fBmm\fP macro

\&.iX	Index entry	New semantic macro
.TE

.H 3 "Inclusion, String Expansion, and Page Mark-up Information in RSML"
.P
The macros in this subsection provide functions for
including entities of different types, for string expansion and
for specifying the text for inclusion in headers and footers.
.P
.ne 15 
.TB "RSML Macros That Include, Define Strings, and Mark Pages" 
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
\&.dI subdocument_name	Include subdocument of same type	New semantic macro
\&.eI subdocument_name	Include subdocument of example type	New semantic macro
\&.pI subdocument_name	Include PostScript\u*\d subdocument	New semantic macro

\&.ds	Define string for expansion	Existing markup

\&.pM	Page markup information	New semantic macro
.TE
.ne 12 
.H 3 "Escape Mechanisms in RSML"
.TB "RSML Markup For Escapes" 
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
\&.nP	Force a page break here	New semantic macro
\&.ne x	Reserve x lines on one page	Existing markup
\&.nL	Force a line break	New semantic macro	

\&.wH	Tag text converted from another language, not recognized	New semantic macro
.TE
.SK
.H 2 "References"
.P
.VL .5i
.LI [1]
.I "Markup Systems and the Future of Scholarly Text Processing;"
James H. Coombs, Allen H. Renear, Steven J DeRose;
Communications of the ACM;
Volume 30, Number 11, November 1987.
.LI [2]
.I "Information Processing\*(EMText and Office Systems\*(EMStandard"
.I "Generalized Markup Language (SGML);"
American National Standards Institute;
ISO 8879;
New York;
1986.
.LI [3]
.I "Literary Machines;"
Ted H. Nelson;
Nashville, Tenn.;
1981.
.LI [4]
.I "Text, Context, and Hypertext.  Writing with and for the Computer;"
Barrett, editor;
the MIT Press;
1988.
.LI [5]
.I "OSF Requirements for Information Architecture and Communications;"
Fred Dalrymple, Open Software Foundation, 1990.
.LI [6]
.I "Document Representation;"
Vania Joloboff, in
.I "Structured Documents,"
Andre, Furuta, and Quint, Cambridge University Press, 1989. 
.LE
