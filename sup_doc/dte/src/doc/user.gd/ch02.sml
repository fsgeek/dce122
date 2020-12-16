...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\"  @OSF_FREE_COPYRIGHT@
...\"
...\" HISTORY
...\" $Log: ch02.sml,v $
...\" Revision 1.1.2.7  1994/06/24  15:16:17  fred
...\" 	free copyright
...\" 	[1994/06/23  20:15:35  fred]
...\"
...\" Revision 1.1.2.6  1994/06/23  18:40:14  fred
...\" 	free copyright
...\" 	[1994/06/22  19:34:37  fred]
...\" 
...\" Revision 1.1.2.5  1993/04/10  01:22:47  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  01:20:32  bowe]
...\" 
...\" Revision 1.1.2.4  1992/05/28  18:20:38  bowe
...\" 	Fix botched initial check-in.
...\" 	[1992/05/28  18:08:17  bowe]
...\" 
...\" Revision 1.1.2.3  1992/05/28  17:56:15  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:53:37  bowe]
...\" 
...\" Revision 1.1.2.2  1992/05/28  16:50:00  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:47:17  bowe]
...\" 
...\" $EndLog$
...\" _________________________________________________________________
...\"
...\"build tbl
...\"
.H 2 "Semantic Markup Language"
...\" overview stuff
.iX "Semantic Markup Language"
.iX "SML"
.P
This section describes the OSF\(tm Semantic Markup Language (SML)
for technical documentation preparation.
.P
The intended audience for this section is a writer who is familiar
with \*Lnroff\*O, \*Ltroff\*O, the \*Lmm\*O macros, and the \*Lman\*O
macros. The focus of this section is how to use SML in writing a
document. It does not attempt to provide the additional information 
needed by software engineers who are writing translators for 
SML and does not provide a
complete description of the intended semantic meaning of the elements
of the language.  See Chapter 4 for an introduction to SML
concepts, and history, and a technical description
of SML.  The following markup guidelines assume you
are familiar with the concepts presented in Chapter 4. 
.cS
Commented this out because it's redundant w/ch4
.H 3 "Introduction to SML"
.P
The purpose of SML is to generalize and standardize the current
markup in OSF documents and to be the first phase in the migration to a
more generic document interchange mechanism.  The SML is based on
existing \*Lnroff\*O/\*Ltroff\*O macros with additional new macros.
OSF developed SML in response to a request by the 
OSF Documentation Special Interest Group (SIG) Information 
Architecture Task Force.
See Chapter 4 for information about the background of
SML. 
.P
There are two macro sets in SML: the general purpose semantic
markup language (GPSML) and the reference semantic markup language
(RSML). Whenever possible we have made the markups identical in these
two macro sets.
.P
SML includes \*Lmm\*O and \*Lman\*O macros, \*Ltbl\*O and
\*Lpic\*O and \*Leqn\*O macros, and \*Ltroff\*O primitives. You need to use the 
\*Ltroff\*O primitives to get special characters (such as \e(em and \ee),
explicit spacing control (such as \e(space), \e0, and \ec),
and the
zero-length space (\e&) to allow example lines that begin with a dot (.).
You should only use the explicit spacing control when it is
unavoidable (such as to insert spaces into a variable list .LI
argument.
.H 3 "Definitions" 
.P
The term 
\*Lsemantic markup\*O
.gL "semantic markup"
means
that each markup directive in this language describes an 
element with a specific meaning in the context of the document.
This meaning can be understood and recognized by
different text processing systems in the same way. 
For instance, the text element marked as 
a 
\*Lheader\*O 
is always interpreted as a header.  The text element marked 
as an 
\*Lexample\*O
is always interpreted as an example.  Because 
semantic markup is free of any formatting information, each
text processing system and each recipient of documentation
source is free to translate the semantic elements
to any format or layout style.  In contrast, a directive 
to "indent five spaces" in completely non-semantic; it
dictates only format and layout.
.P
.cE
.H 3 "General Purpose Document Structure"
.P
This section describes chapter, appendix, preface, and header macros.
.P
To start a chapter, appendix, or preface, use the .H 1 macro. (As
described in Chapter 3, the
\*Lbook-format\*O command uses the \*LPREFACE\*O and \*LAPPENDIX\*O
keyword in the \*LDescription\*O file to distinguish prefaces and
appendixes from chapters.  The DTE tools and Description file
also let you specify the order of
chapters, and generate indexes and tables
of contents.  
.nS note
You must start the first appendix with a command to reset chapter
numbering to 0. We plan to eliminate this requirement in a future
enhancement to SML macros. To reset the chapter numbering, insert
the following line at the beginning of Appendix A:
.oS
\&.nr H1 0
.oE
.P
We recommend that title pages and copyright pages be done with
standard \*Lmm\*O macros instead of the GPSML macros. The macros
needed for these pages are almost entirely concerned with final-form
output and have very little semantic content. You should use the \*LFRONT\*O
keyword in the \*LDescription\*O file for these sections.
...\" Provide templates
.P
Within the Preface, you should use the GPSML markup, but you do not
have to use the \*L.qS\*O/\*L.qE\*O markup to begin and end the preface.
You do need to set the page number to be the first odd number after
the table of contents, for example, if the table of contents is 4
pages long, the command:
.oS
\&.nr P 4
.oE
.P
sets the first page of the preface to 5. The \*Lbook-format\*O command
will set the Preface page number format to lowercase roman numerals.
.P
To set the page number for the preface, you must first run \*Lbook-format\*O 
to know the last page of the table of contents. Also be sure that the
command to set the register is at the top of the file above the .H 1 macro.
.nE
.P
Header levels within a chapter, appendix, or preface use the standard
\*Lmm\*O .H 2, .H 3, and .H 4 commands. Although you can use .H
sections greater than 4, avoid it when possible.
.P
The following table summarizes SML macros that define the overall
document structure (these are valid in GPSML only).
.ne 30
...\" This is very ugly is there another way to keep table title with table?
.TB "GPSML Macros That Define Overall Document Structure"
.TS
center,box;
lfB | lfB | lfB
l | l | l.
Macro Name	Macro Function	Macro Origin and Status
_
.TH
\&.H 1	First-level head (Chapter in a book)	Existing \fBmm\fP macro
\&.H 2	Second-level head (1st-level head in a book)	Existing \fBmm\fP macro
\&.H 3	Third-level head (2nd-level head in a book)	Existing \fBmm\fP macro
\&.H 4	Fourth-level head (3rd-level head in a book)	Existing \fBmm\fP macro
.TE
.oS
\*&...\e"**********************************
\&...\e"            Title of the Chapter
\&...\e"**********************************
\&.H 1 "This is the Title of this Chapter"
\&.P
\&This chapter is self referential.
\&.H 2 "This is a Header in Chapter"
\&.P
\&Chapter text can include paragraphs, 
\&lists, tables, figures, and many
\&other components.
\&.H 3 "This is a Lower Level of Header in Chapter"
\&.H 4 "This is an Even Lower Level of Header in Chapter"
\&.H 5 "This is Getting Ridiculous, But You Get the Idea"
\&.H 2 "Not Another Header?"
\&...\e" Chapter is terminated by the next .H 1
.oE
.nS note
Although it would be preferable to have the terms
.E, "first level head" ","
.E, "second level head" ","
and
.eM "third level head"
refer to the section levels within a chapter (that is \*L.H 2\*O,
\*L.H 3\*O, and \*L.H 4\*O), this is too confusing as long as we are
using \*Lnroff\*O/\*Ltroff\*O macros. To avoid confusion, this
document will refer to the explicit \*L.H\*O macros with the
appropriate number and avoid the term
.E, "first level head" "."
We may revisit this issue in a future phase of OSF's document
interchange mechanism.
.nE
.H 3 "Tables"
.P
Both GPSML and RSML use the standard \*Ltbl\*O markup. You use the
following markups:
.ML
.LI
\*L.TB\*O markup to give a title to a table
.LI
\*L.TS\*O markup to start a table
.LI
\*L.TH\*O or \*L.tH\*O to indicate the end of the table heading
.LI
\*L.TE\*O to end a table
.LI
\*L.T&\*O to continue a table
.LE
.P
To bold the title of a table, you need to use the \*LB\*O markup in
the table column specification. You should not use the \e*L markup.
For example, the following markup:
.oS
\&.ne 15
\&.TB "Title of Table"
\&.TS
center,box,tab(@);
lB | lB | cB
lB | lB | cB
l | l | c.
Column 1@Column 2@Column 3
Title@Title@Title
_
\&.TH
entry 1@entry 2@entry 3
more entries@and more@etc.
\&.TE
.oE
.P
produces the following table:
.ne 15
.TB "Title of Table"
.TS
center,box,tab(@);
lfB | lfB | cfB
lfB | lfB | cfB
l | l | c.
Column 1@Column 2@Column 3
Title@Title@Title
_
.TH
entry 1@entry 2@entry 3
more entries@and more@etc.
.TE
.nS note
The \*L.tH\*O macro is defined for RSML to have the equivalent effect
of the GPSML \*L.TH\*O table header macro. \*L.TH\*O in RSML is used
to start a manpage.
.P
Do not use font changes in the \*L.TB\*O table title. A restriction in
\*Ltroff\*O produces errors in the table of contents when there is a
font change in the table (or figure) title. Although the OSF
Documentation Style Guide says that command names should be in bold in
table and figure titles, you should avoid this markup because of the
\*Ltroff\*O restriction.
.nE
.P
You should not put a table in a display unless it is an short table
(under 20 lines). Putting a table in a display makes it impossible for
\*Ltroff\*O to include the table headings on tables that extend over a
page break. You may need to use the \*L.ne\*O markup to ensure that
the table title is printed on the same page as the table.
.H 3 "Figures, Illustrations, and Equations"
.P
The standard \*Lmm/man\*O macros are used for figures, illustrations,
and equations.
.ML
.LI
\*L.FG\*O\(emfigure title (do not use font changes in figure title)
.LI
\*L.PS\*O and \*L.PE\*O\(em\*Lpic\*O drawing start and end. These macros
are often in included files that contain the \*Lpic\*O drawings.
.LI
\*L.EC\*O\(emequation caption (title)
.LI
\*L.EQ\*O/\*L.EN\*O\(emequation start and end
.LI
\*L.EX\*O\(emexhibit caption (title)
.LE
.P
.nS note
To include a \*Lpic\*O drawing from a separate file,
use the standard
\*L.PS\*O
command markup:
.oS
\&.PS < filename
.oE
The specified file should start with
a
\*L.PS\*O and end with
a
\*L.PE\*O.
Do not include a file with the SML
\*L.dI\*O 
markup or the 
\*L.so troff\*O
primitive. 
.nE
.H 3 "Paragraphs"
.P
You can use the \*L.P\*O or \*L.PP\*O macros to start a new paragraph.
For historical reasons, we suggest that you use the \*L.P\*O macro in
GPSML and the \*L.PP\*O macro in RSML. You should not use any explicit
vertical space markup.
.H 3 "Lists"
.P
There are three kinds of lists available in GPSML and RSML:
.ML
.LI
\*L.ML\*O marked lists.
.LI
\*L.AL\*O numbered lists.
.LI
\*L.VL\*O variable lists\(emamong other uses, variable lists are used
to describe the elements in manpages synopses.
.LE
.P
You do not explicitly specify the mark in a marked list. The sml
macros will choose the appropriate mark based on the level of list nesting.
For example, the following list markup:
.oS
\&.ML
\&.LI
<An item >
\&.P
<More information about the item>
\&.LI
<Another item>
\&.LI
Another item
\&...\e"**************************************************
\&...\e"		Nested marked list (within marked list)
\&...\e"**************************************************
\&.ML
\&.LI
<An item in nested marked list>
\&.LI
<Another item>
\&.LI
<Another item>
\&.LE      \"*******end of nested marked list
\&.LI
<Another item in outer list>
\&.LE      \"*******end of outer marked list
.P
.oE
will produce the following output:
.ML
.LI
<An item >
.P
<More information about the item>
.LI
<Another item>
.LI
Another item
...\"**************************************************
...\"		Nested marked list (within marked list)
...\"**************************************************
.ML
.LI
<An item in nested marked list>
.LI
<Another item>
.LI
<Another item>
.LE      \"*******end of nested marked list
.LI
<Another item in outer list>
.LE      \"*******end of outer marked list
.P
In a similar manner, you do not specify the mark for numeric lists
(and if you do explicitly specify it, it is ignored). For example, the
following markup:
.oS
\&...\e"**************************************************
\&...\e"		Numbered list
\&...\e"**************************************************
\&.AL
\&.LI
<Item 1>
\&.LI
<Item 2>
\&...\e"**************************************************
\&...\e"		Numbered list (within a numbered list)
\&...\e"**************************************************
\&.AL
\&.LI
<Item 2.a >
\&.LI
<Item 2.b>
\&.LE
\&.LI
<Item 3>
\&.LE
.oE
.P
produces the following output:
...\"**************************************************
...\"		Numbered list
...\"**************************************************
.AL
.LI
<Item 1>
.LI
<Item 2>
...\"**************************************************
...\"		Numbered list (within a numbered list)
...\"**************************************************
.AL
.LI
<Item 2.a >
.LI
<Item 2.b>
.LI
<Item 3>
.LE
.P
The .VL macro requires an argument that specifies the indent used for
the body of the text.  We recommend that you specify the indent in
\*Li\*O (inches), \*Lc\*O (centimeters) or \*Lm\*O (ems). 
Although you can use \*L\ew\*O to get the 
width of some text, we recommend not using 
this feature because of the difficulty of
translating this into some formatting languages.
.P
The backslashes in the .LI phrases (which specify 
unpaddable spaces) prevent the formatter from using
those spaces when it calculates the justification for 
that first line.
.P
The following markup:
.oS
\&.VL 7m
\&.LI "\e*Llogin\e*O\e command\e information"
\&.nL
Explanation of the phrase. Note that any spaces 
in the .LI mark must be quoted with \e (backslash) 
to prevent troff from expanding them.
\&.LI "\e*Ltelnet\e*O"
Explanation.
\&.LI "Word"
Explanation.
\&.LE
.oE
.P
produces the following output:
.VL 7m
.LI "\*Llogin\*O\ command\ information"
.nL
Explanation of the phrase. Note that any spaces in the .LI mark must
be quoted with \e (backslash) to prevent troff from expanding them.
.LI "\*Ltelnet\*O"
Explanation.
.LI "Word"
Explanation.
.LE
.nS note
If the list entry text extends past the space allocated, you can use
the \*L.nL\*O page markup escape to force the text onto a new line.
.H 3 "Examples and Displays"
.P
There are four sml macros that you can use to create regions where
the input line breaks are significant:
.VL 6m
.LI "\&\*L.iS\*O/\*L.iE\*O\"
Command input region\(emdefault font is \e*L (GPSML and RSML).
.LI "\&\*L.oS\*O/\*L.oE\*O\"
System output/file listing region\(emdefault font is \e*C (GPSML and RSML).
.LI "\&\*L.tS\*O/\*L.tE\*O\"
Text display\(emdefault font is \e*O. Can also be used for simple,
unmarked lists. (GPSML only)
.LI "\&\*L.DS I N\*O/\*L.DE\*O\"
Text display\(emdefault font is \e*O. (GPSML only)
.LE
.P
When a region is primarily user command input, use the \*L.iS\*O markup.
When a region is primarily command output or a file listing, use the
\*L.oS\*O markup. When a region does not contain command input or
output (or a translating program cannot distinguish the context), use
either the \*L.tS\*O or the \*L.DS I N\*O markups.
.nS note
The command input region (\*L.iS\*O) and the system output region
(\*L.oS\*O) are not
displays, that is they will start on the current page and continue on
the next page, if needed. The text display (\*L.tS\*O) is a display
and will only appear on the current page if the entire display region
fits. If you want to ensure that a command input region or system
output region is not continued over a page boundary, you should use
the \*L.ne\*O command to ensure that there is enough space on the
current page.
.P
The indentation is slightly different in the current macro implementations.
These macros should all produce the same indentation.
.nE
.P
In addition, you may use the \*L.DS I F\*O markup when you want to
create a display (which will stay on the same page if possible) but do
not want input line breaks to be significant.
.H 3 "Procedures"
.P
Procedures (available in GPSML only) 
allow you to define named and numbered procedures.
Use the 
\*L.pR\*O macro for a named, numbered, procedure
title.  The 
\*L.pS/.pE\*O macro pair are implemented today
to behave like a numbered list 
(\*L.pS\*O is equivalent to
\*L.AL\*O, and 
\*L.pE\*O is equivalent to
\*L.LE\*O.)  Inside a procedure,
use list items.
For example, the markup:
.oS
\&.pR "Loading the Tape"
\&.pS
\&.LI
Open the tape box.
\&.LI
Find the tape.
\&.LI
Put the tape in.
\&.LI
Press the button and go to lunch.
\&.pE
\&.pR "Building the System"
\&.pS
\&.LI
Log in to the build machine.
\&.LI
Determine your target system.
\&.LI
Read the directions on the target system.
\&.pE
.oE
.P
produces the following output:
.P
.pR "Loading the Tape"
.pS
.LI
Open the tape box.
.LI
Find the tape.
.LI
Put the tape in.
.LI
Press the button and go to lunch.
.pE
.pR "Building the System"
.pS
.LI
Log in to the build machine.
.LI
Determine your target system.
.LI
Read the directions on the target system.
.pE
.H 3 "Notes and Cautions"
.P
The \*L.nS\*O/\*L.nE\*O markup (GPSML only) 
allows you to create notes or cautions.
The \*L.nS\*O macro has an argument that can either be "note" or "caution."
You can have multiple notes by including a \*L.P\*O paragraph markup
between the notes. You can use notes within list items.
.oS
\&.nS note
<Text of the note.
more text>
.P
<Second paragraph of the note (if any).>
\&.nE
.oE
.oS
\&.nS caution
<Text of the caution.>
\&.P
<Second paragraph of the caution (if any).>
\&.nE
.oE
.P
These \*L.nS\*O macros produce the following output.
.nS note
<Text of the note.
more text>
.P
<Second paragraph of the note (if any).>
.nE
.nS caution
<Text of the caution.>
.P
<Second paragraph of the caution (if any).>
.nE
.H 3 "Footnotes"
.P
SML uses the standard \*Lmm\*O macros for footnotes (available
in GPSML only).
.oS
This system uses the Snerkgjk\e*F option.
\&.FS
Snerkgjk is a registered trademark of the Snerkgjk Corporation.
\&.FE
.oE
.H 3 "Comments"
.P
SML provides a single-line and multi-line comment specification.
This markup is available in GPSML and RSML.
.P
To enter a single-line comment, use the \*L...\e"\*O markup at the
beginning of the line.
.oS
\&...\e" <Comment text>
.oE
.P
To enter a multi-line comment, use the \*L.cS\*O/\*L.cE\*O markup.
.oS
\&.cS
<comment text>
<more comment text>
\&.cE
.oE
.H 3 "Meaningful Text Markup"
.P
This section describes the markup that you can use in paragraphs, lists,
displays, etc. to describe the semantic meaning of text.
.ne 14
.TB "Meaningful Text Markup"
.TS
center,box, tab(@);
lfB | lfB | lfB | lfB
lfB | lfB | lfB | lfB
l l l.
@@@Font Produced
Markup@Semantic Meaning@Examples@by Macros
_
.TH
\e*L@Literal text@user command input, command names@Bold
@@glossary term in text
\e*V@Variable text@user-supplied term@Italic
\e*O@Ordinary text@@Roman font
\e*C@Computer output@Command output, file listing@Constant width
\e*E@Emphasized text@book title, emphasized term@Italic
\e*A@Alphabetic constant@Error constants@Constant width
\e*N@Numeric constants@@Constant width
.TE
.P
These text markups change the font until the font is changed
again.  Consequently, you should use \e*O to revert back to ordinary text
(except in cases where the default font is something else).
For example:
.oS
To delete a file, enter the \e*Lrm\e*O command using the \e*L-f\e*O
switch.
\&.iS
rm -f \e*Vfilename\e*L
\&.iE
.oE
.P
This markup produces the following output:
.P
To delete a file, enter the \*Lrm\*O command using the \*L-f\*O
switch.
.iS
rm -f \*Vfilename\*L
.iE
.P
In addition, you can use the \*L.kY\*O, \*L.K,\*O, and \*L.,K\*O
macros to specify keyboard keys. The \*L.kY\*O command takes a single
argument and causes it to be enclosed in angle brackets and printed in
the bold font. The \*L.K,\*O macro is used when you have text
immediately following the keyboard key name without an intervening
space.
The \*L.,K\*O macro is used when you have text immediately preceding
the keyboard key name without an intervening space.
For example, the markup:
.oS
If you don't want to press
\&.K, "Return" ","
you can always press the
\&.kY "Ctrl-c"
key. However, you should be worried when a user says,
\&.,K "``" "Ctrl-c"
is what I always type when I'm unsure.''
.oE
.P
produces the following output:
.P
If you don't want to press
.K, "Return" ","
you can always press the
.kY "Ctrl-c"
key. However, you should be worried when a user says,
.,K "``"" "Ctrl-c"
is what I always type when I'm unsure.''
.P
Although the \*L.kY\*O markup is preferable, you can use the \e*L
markup if you are translating source from another text processing language.
For example:
.oS
If you don't want to press \e*L<Return>\e*O, you can always
press the \e*L<Ctrl-c>\e*O key.
.oE
.P
In addition to the \e*E emphasized text inline markup, you can also
use the \*L.eM\*O, \*L.E,\*O, and \*L.,E\*O markup for emphasized
text. These three macros are analogous to the \*L.kY\*O macros in
handling text immediately before or after the emphasized text.
.H 3 "Localization Regions"
.P
The \*L.lS\*O and \*L.lE\*O macros,
available in both GPSML and RSML, start and end a localization region.
A localization region has no impact on the appearance of the printed
document. It is intended as a comment to identify a region that will
require changes when a document is customized for a specific locale or
language. 
.H 3 "Reference Document Structure"
.P
RSML uses standard \*Lman\*O macros to define the document
structure. These macros are:
.VL 5m
.LI "\*L.TH\*O"
Starts the manpage and specifies the command, function, or file that
is described and the section number of the reference manual. See the
templates for more information.
.LI "\*L.SH\*O"
Specifies a section heading. See the templates for the \*L.SH\*O
titles (required and optional) and their order for your document set.
.LI "\*L.SS\*O"
Specifies a subsection heading. See
the templates for guidelines on using \*L.SS\*O.
.LE
.H 3 "Reference Function Synopsis Macros"
.P
The SML specification and the SML language provides three
pairs of macros for use in synopses.  They appear in the
following table.  As the comments in the table note,  
in practice, we have found the function
and datatype pairs to be somewhat cumbersome and 
difficult for automatic translation programs.
So we are encouraging use of a simpler coding standard 
that produces the same output.  But both the function
and datatype macro pairs, and the simpler coding standard,
are valid SML usages. 
.
.ne 10 
.TB "Reference Function Macro Pairs "
.TS H
center,box;
l | l | l.
\fBMarkup code	Function	Comments \fR 
_
.TH
_
\&.sS	Start synopsis definition	Useful markup
\&.sE	End synopsis definition	Useful markup

\&.fS	Start function definition 	Cumbersome markup; see alternative
\&.fE	End function definition 	Cumbersome markup; see alternative

\&.dS [opt]	Start type declaration 	Cumbersome markup; see alternative
\&.dE	End type declaration 	Cumbersome markup; see alternative
.TE
.P
The subsections that follow describe use of the function and
datatype macro pairs first, and the simpler coding alternative second. 
.H 4 "Creating Synopses Using the Function and Datatype Pairs" 
Synopsis coding depends on whether
or not your document uses ANSI C function prototypes.
If you are using function prototypes, you embed the
datatype specification between the function start and
function end.  For non-prototype C function synopses,
the datatype specification follows the function end.  Within
the datatype specification, the parameter name goes on a line between
the .dS and .dE markups. 
.P
Here is the markup for documents using function prototypes. 
.oS
\&.sS
\e*L#include <header_filename>\e*O
\&...\e" If there are two include lines, the second requires 
\&...\e" a .PP or a .nL
\&.PP
\e*L#include <header_filename>\e*O
\&.fS "<type_name> <function_name>"		
\&.dS "<arg1_type>"
\e*V<arg1>\e*O
\&.dE
\&.dS "<arg2_type>"
\e*V<arg2>\e*O
\&.dE
\&.fE
\&...\e" If there are two functions described in the same 
\&...\e" synopsis, you should use .PP to put a vertical 
\&...\e" space between them.
\&.sE
.oE
.P
This markup produces the output:
.ne 5
.sS
\*L#include <header_filename>\*O
...\" If there are two include lines, the second requires a .PP or a .nL
.PP
\*L#include <header_filename>\*O
.fS "<type_name> <function_name>"		
.dS "<arg1_type>"
\*V<arg1>\*O
.dE
.dS "<arg2_type>"
\*V<arg2>\*O
.dE
.fE
...\" If there are two functions described in the same synopsis, you
...\" should use .PP to put a vertical space between them.
.sE
.P
The following example illustrates how you can use this markup style:
.oS
\&.sS
\e*L#include <sys/vmount.h>\e*O
\&.fS "int umount"
\&.dS "char *"
\e*Vdevice\e*O
\&.dE 
\&.fE
\&.PP
\&.fS "int uvmount"
\&.dS "int"
\e*Vvirtual_file_sys_id\e*O
\&.dE
\&.dS "int"
\e*Vflag\e*O
\&.dE
\&.fE
\&.sE
.oE
.P
Here is the output from the example:
.sS
\*L#include <sys/vmount.h>\*O
.fS "int umount"
.dS "char *"
\*Vdevice\*O
.dE 
.fE
.PP
.fS "int uvmount"
.dS "int"
\*Vvirtual_file_sys_id\*O
.dE
.dS "int"
\*Vflag\*O
.dE
.fE
.sE
.P
.H 4 "Alternative Function Synopsis Markup"
.P
This section shows a simpler markup style,
which is easier for translators to generate,
and may be less cumbersome to code.  In this
style, you embed a user input region (using the
\*L.iS/.iE\*O macro pair) within
a synopsis region (using the synopsis macro pair).  
.P
In the user input region,
text is interpreted as literal markup,
and processing is in no-fill mode; you
escape from that literal markup to show
variables.  
.P
For example, without function prototypes,
a synopsis might be written:
.ne 10
.oS
\&.sS    \" begin a (logical) synopsis
\&.iS    \" begin an input region
\&#include "stdio.h"

\&int printf(\e*Vformat\e*L, \e*Vstring, ...\e*L)
\&char * \e*Vformat\e*L,
\&char * \e*Vstring, ...\e*L;
\&.iE    \" end of input region 
\&.sE    \" end of synopsis
.oE
.P
The output is:
.sS    \" begin a (logical) synopsis
.iS    \" this is a user input example
#include "stdio.h"

int printf(\*Vformat\*L, \*Vstring, ...\*L)
char * \*Vformat\*L,
char * \*Vstring, ...\*L;
.iE    \" end input region 
.sE    \" end synopsis
.P
Using function prototypes, the example is:
.ne 10
.oS
\&.sS    \" begin a (logical) synopsis
\&.iS    \" begin an input region
\&#include "stdio.h"

\&int printf(
	\&char * \e*Vformat\e*L,	\"tab used for indent
	\&char * \e*Vstring, ...\e*L);
\&.iE    \" end of input region 
\&.sE    \" end of synopsis
.oE
.P
The output is:
.sS    \" begin a (logical) synopsis
.iS    \" this is a user input example
#include "stdio.h"

int printf(
	char * \*Vformat\*L,
	char * \*Vstring, ...\*L);
.iE    \" end input region 
.sE    \" end synopsis

.P
.H 3 "Reference Command Synopsis Macros"
.P
Command synopses are simpler.  You do not need
to embed an input region, you just use the
synop sis pairs (.sS/.sE).  Fill mode and meaningful
text markup (for literals and variables) are used 
instead.
.P
.ne 5
Here is how to use the \*L.sS\*O/\*L.sE\*O macros for 
command synopses markup:
.oS
\&.sS
\e*Lcommand \e*O[ \e*L-option1 \e*O| \e*L-option2 \e*Vvariable \e*O] 
\&.sE
.oE
.P
The output from this markup is:
.sS
\*Lcommand \*O[ \*L-option1 \*O| \*L-option2 \*Vvariable \*O] 
.sE
.H 3 "Including Other Files"
.P
There are three markups for including other files in a document:
.VL 5m
.LI "\*L.dI\*O"
Include a subdocument. The subdocument can contain sml macros. (If the
\*L.dI\*O command is in a GPSML document, the subdocument must contain GPSML
commands and, if it is an RSML document, the subdocument must contain
RSML commands.) 
.LI "\*L.pI\*O"
Include an encapsulated PostScript\(rg illustration. See Appendix
B for information
about substitutions for this mark-up
that may be required in some versions of DWB.
.LI "\*L.eI\*O"
Include an example subdocument and do not process any \*Ltroff\*O
commands in the subdocument. The subdocument can contain \e characters
and lines beginning with ".". In addition, the subdocument is treated
as a display and line breaks in the subdocument cause line breaks in
the SML output document.
.LE
.H 3 "Defining and Expanding Strings"
.P
You can use the \*L.ds\*O \*Ltroff\*O primitive to define strings and the
\e* construct to expand the strings. Strings should be used for
product and book names that are used throughout a document set, especially
if the name is not final during the writing of the document or if a
licensee porting the offering could customize the name.
.nS note
Be careful not to use a string name that is already
used elsewhere in the DTE macro packages.  See Appendix A
for more information.
.nE
.H 3 "Page Markup Escapes"
.P
SML provides four page mark escapes that allow
some final form control when it is 
required to produce reasonable output.  These non-semantic
escapes, available in both GPSML and RSML, are: 
.VL 5m
.LI "\*L.nP\*O"
Forces a new page to start.
.LI "\*L.ne\*O"
Existing \*Ltroff\*O primitive that ensures that the number of lines
specified remains on the page. Otherwise forces a new page to start.
.LI "\*L.nL\*O"
Forces a line break.
.LI "\*L.wH\*O"
Has no effect on output but provides a comment mechanism to indicate
that a markup command in another language was ignored during the
translation to SML.
.LE
.H 3 "Additional SML Markups"
.P
This section describes markup commands that were included in the SML
specification but that we are not using in our
documentation at OSF, and also mentions unimplemented
macros that you can use if useful, but that will have
no effect.
.H 4 "Front and Backmatter Macros"
.P
The first set of macros that we are not using is for
frontmatter and backmatter formatting. 
.ne 25
.TB "Summary of Front and Backmatter Macros"
.TS
center,box,tab(@);
lfB | lfB | lfB
l | l | l.
Macro Name@Macro Function@Suggested Replacement
_
.TH
\&.zS@Appendix begins@Use \*LAPPENDIX\*O keyword in
\&.zE@Appendix ends@\*LDescription\*O file

\&.xS@Title page begins@Use standard \*Lmm\*O macros for
\&.xE  @Title page ends@title page

\&.yS@Disclaimer (copyright) page begins@Use standard \*Lmm\*O macros
\&.yE@Disclaimer (copyright) page ends@for copyright page

\&.qS@Preface begins@Use \*LPREFACE\*O keyword in \*LDescription\*O
\&.qE@Preface ends@file and \*L.H 1 "Preface"\*O macro

\&.mA@Manual title (for title page)@Use standard \*Lmm\*O macros
\&.rV@Manual revision (for title page)@for title and copyright
\&.cO@Manual copyright (for disclaimer)@pages
\&.aU@Manual author (for title page)@
\&.oN x@Manual order number (for title page)@
.TE
.P
.H 5 "Title and Copyright Page Structure"
The title and copyright page macros provide a boiler-plate with macros
to specify the book-specific information. We recommend that you not
use these macros, but rather code title and copyright pages in
standard
\*Lmm\*O macros.
.oS
\*C\&.xS
\*C\&...\e"Start title page
\*C\&...\e"***********************************************
\*C\&...\e"**********************************************
\*C\&...\e"          Enter the title of the book:
\*C\&...\e"*********************************************
\*C\&.mA "Documentation Tools Environment User's Guide/Reference"
\*C\&...\e"********************************************
\*C\&...\e"          Enter the book's revision number
\*C\&...\e"********************************************
\*C\&.rV "Revision 1.0"
\*C\&...\e" Should this be .rV "1.0"
\*C\&.aU "Some Author's Name
\*C\&.xE
\*C\&...\e"End title page
\*C\&.yS
\*C\&...\e"Start copyright page
\*C\&.cO "Long_widget_name is a trademark of Some Software Company"
\*C\&.cO "Copyright \e(co 1990 by Famous Technology Supplier, Inc."
\*C\&.yE
\*C\&...\e"End copyright page
.oE
.H 5 "Preface Structure"
.P
The Preface
structure macros ensure that section is formatted in the Preface style
(lower-case letter page numbers and unnumbered sections). We recommend
that you omit the \*L.qS\*O and \*L.qE\*O macros.
.oS
\&...\e"       Specify beginning page number (first odd page after toc);
\&...\e"       Here, the page number is set to begin at 5 (1+4). 
\&...\e"       The page number will be displayed in lowercase
\&...\e"       roman numerals.
\&...\e"******************************************
\&.nr P 4
\&...\e"*****************************************
\&...\e"       Fill in the sections as appropriate for your document.
\&...\e"******************************************
\&.qS
\&...\e" Preface start
\&.H 1 "Preface"
\&.P
\&The
\&...\e"#doctitle
\&.eM "Documentation Tools Environment User's Guide/Reference"
   .
   .
   .
\&.H 2 "Audience"
\&This document is written for OSF writers.  It assumes you
\&are a technical writer well-versed in technical writer's jargon.  It
\&.H 2 "Document Usage"
\&This document is organized into four chapters and one appendix.
\&.ML
\&.LI
\&For an introduction to the Documentation Tools 
\&Environment (DTE), see Chapter 1.
   .
   .
   .
\&.LE
\&.qE
\*&...\e" Preface ends
.oE
.H 4 "Unimplemented Macros/Reserved For Future Use"
.ne 8
.TB "Summary of Unimplemented SML Macros"
.TS
center,box,tab(@);
lfB | lfB | lfB
l | l | l.
Macro Name@Macro Function@Suggested Replacement
_
.TH
\&.OK@Keywords for hypermedia@Future enhancement

\&.RS@Reference start@Future enhancement for cross-
\&.RE@Reference end@reference.  Currently exist
@@as standard mm and man
@@macros, with different
@@meaning.

\&.pM@Page markup@Future enhancement for including
@@page markup information
.TE
.H 5 "Hypermedia Support"
.P
Although it will not have any effect on the documentation output, you
can put \*L.OK\*O keywords into your documents,
in both RSML and GPSML. For example, if a
section was describing shell command entry, you could insert the
following commands:
.oS
\&.H 3 "Entering Shell Commands"
\&.OK "shell commands" "command entry"
<text>
.oE
.P
These tags will allow some future documentation tools to create an
entry into the document at this point using "shell commands" and
"command entry" as hypertext tags.
