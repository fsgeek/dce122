...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c3.P-S.mm,v $
.\" Revision 1.1.2.6  1994/06/24  15:15:30  fred
.\" 	free copyright
.\" 	[1994/06/23  20:21:56  fred]
.\"
.\" Revision 1.1.2.5  1994/06/23  18:39:25  fred
.\" 	free copyright
.\" 	[1994/06/22  19:09:55  fred]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:06:01  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:02:41  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:35:58  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:33:09  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:05:37  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:57:54  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
.H 2 "Periods"
.iX "periods" "using"
.iX "-: lists" "periods" "in list"
.iX "punctuation" "periods"
.P
Follow these guidelines for periods:
.BL 
.LI
Use periods after every complete sentence in a vertical list.  Do not
use periods after phrases or single words in a vertical list.
.LI
If a complete sentence is enclosed in parentheses or brackets, place the period
.I inside
the closing parenthesis or bracket.  
.DS 1
(For a complete description of the CREF command, see the
.I "TOPS-20 Commands Reference Manual" .)
.DE
.LI
If a sentence ends with a phrase or clause that is enclosed in
parentheses or brackets, place the period
.I outside
the closing parenthesis or bracket.  
.DS 1
The subprograms do not require use of the terminal on
the lower portion of the module (called the \fBevent\fP terminal).
.DE
.LI
If a short sentence is enclosed in parentheses within a longer sentence,
omit the period.  For example:
.DS 1
RCLOKB (see Section 7.5) reads the software clock as the
floating-point representation of the unsigned integer value.
.DE
.LI
Place periods
.I inside
closing quotation marks at the end of a sentence.
.LI
Use initial periods in referring to a file type.
.P 1
.I Use
.DS 1
Arguments ending with .c are interpreted as C source programs.
Type or print the .LIS file to see a list of your errors.
.DE
.P 1
.I "Do not use"
.DS 1
Arguments ending with c are interpreted as C source programs.
Type or print the LIS file to see a list of your errors.
.DE
.LE
.P
See also 
.B Lists
for information on using a period to punctuate list items.
.H 2 "Plurals"
.iX "plurals"
.P
Follow these guidelines for plurals:
.BL 
.LI
Form the plural of most single and multiple letters and 
numbers written as figures, 
symbols, mnemonics, or acronyms by adding a lowercase
.I s . 
.DS 1
OEMs
4s
1920s
.DE
.P
Exceptions can occur with lowercase letters used as nouns because such
combinations may be mistaken for other words.  In such cases, form the plural
with an apostrophe and a lowercase
.I s .  
For example: 
.DS 1
a's
s's	
x's
y's
.DE
.\".LI
.\"Do not enclose an
.\".I s
.\"in parentheses
.\".RI ( s )
.\"to form plurals.  The plural form of a noun (such as
.\".I files )
.\"includes the singular form 
.\".I (file) .
.\"If it is necessary to stress, for example,
.\"that an operation can be performed on both one file and more than one file,
.\"use the phrase
.\".I "file or files" .
.\".P 1
.\".I Use
.\".DS 1
.\"When you modify files, do not specify a version number for the 
.\"output file.

.\"Select the file or files on which you want the command to act.
.\".DE
.\".P 1
.\".I "Do not use"
.\".DS 1
.\"Select the file(s) on which you want the command to act.
.\".DE
.iX "numbers" "plurals of"
.iX "forming plurals"
.LI
Form the plural of a number written as a figure by adding a lowercase 
.I s .
.DS 1
4s
10s
1920s
.DE
.LI
A symbol has no plural form.  Spell out the name of the symbol to
pluralize it.
.P 1
.I Use
.DS 1
Enter three slashes (///).
.DE
.P 1
.I "Do not use"
.DS 1
Enter three /'s.
.DE
.LI
Some nouns from other languages (especially 
Latin expressions) have two acceptable plural 
forms:  the original plural and a plural formed after English usage.  
In such cases, use the following forms:
.DS F
.TS  
center,box,tab(@);
lb |lb
l |l.
Singular@Preferred Plural
_
automaton@automatons
antenna@antennas
apparatus@apparatuses
appendix@appendixes
criterion@criteria
curriculum@curricula
formula@formulas
index@indexes (part of a document)
index@indices (signs in algebra)
matrix@matrices
memorandum@memoranda
parenthesis@parentheses
prospectus@prospectuses
.TE
.DE
.iX "data" "with a singular verb"
.iX "-: data" "datum"
.LI
Use
.I data
with a singular verb form; do not use the term
.I datum
at all.  For example:
.DS 1
The data is transferred along parallel lines.
.DE
.iX "media" 
.LI
Use 
.I media
with a singular verb.  For example:
.DS 1
The media is shipped separately from the documentation.
.DE
.LE
.H 2 "Pronouns"
.iX "pronouns"
.iX "gender neutrality" 
.P
Follow these guidelines when using pronouns:
.BL 
.LI
Do not use masculine and feminine pronouns if possible.  
Use a plural form or the imperative.  
.P 1
.I Use
.DS 1
Users can keep their documents in the file cabinet.
Keep your documents in the file cabinet.
.DE
.P 1
.I "Do not use"
.DS 1
The user can keep his documents in the file cabinet.
The user can keep his or her documents in the file cabinet.
S/he can keep his/her documents in the file cabinet.
.DE
.LI
Use a noun rather than a pronoun if the pronoun has more than one possible
antecedent.  
.P 1
.I Use
.DS 1
Remove the diskette from its holder; then place the
diskette in the disk drive.
.DE
.P 1
.I "Do not use"
.DS 1
Remove the diskette from its holder; then place it in
the disk drive.
.DE
.LI
The following pronouns are always singular: another, either, each, neither,
every, one, any, some, anybody, everybody, everything, someone, nobody,
nothing, no one.
.LI
The following pronouns are always plural: both, others, few, several, and many.
.LI
Note that when the word
.I each
follows a plural subject, the verb remains plural.
.DS 1
The departments each have their own system managers.
.DE
.LE
.\".H 2 "Qualifiers"
.iX "command qualifiers"
.iX "qualifiers"
.\".P
.\"Follow these guidelines for command qualifiers:
.\".BL 
.\".LI
.\"Precede a qualifier name with a slash (/).
.\".LI
.\"Use all uppercase letters when you refer to a command qualifier that is
.\"not case-sensitive. 
.\".LI
.\"Do not begin a sentence with a qualifier.
.\".LE
.\".P
.\"For example:
.\".DS 1
.\"The /NOLOG qualifier closes the current log file but does not open a new one.
.\".DE
.\".P
.\"See also
.\".B commands .
.H 2 "References"
.P
.iX  "cross-references"
.iX  "references"
.P
Use the following guidelines when making cross-references in your manuals.
.BL 
.LI
Be specific; use exact names or numbers.
.LI
Do not use page numbers.
.iX  "cross-references" "OSF documents"
.LI
Refer to other OSF manuals by document title.  Use
the italic font.  Do not refer to specific chapters, appendixes, or
sections in another book, even if the book is in the same document set.
Chapter and section numbers and titles often change from one version to the
next.
.iX  "cross-references" "text in same manual"
.LI
Refer to text in the same manual by chapter or section
number.  Use the smallest section number that applies to the text you want
to reference.  To refer to an unnumbered heading within a numbered section,
use the section number and the unnumbered heading title in quotation marks.
.DS 1
See Section 1.3.5 for information about the MWM.
See "Choosing the Appropriate Control" for more information.
.DE
.iX  "cross-references" "chapters"
.iX  "cross-references" "sections"
.iX  "cross-references" "appendixes"
.iX  "cross-references" "figures"
.iX  "cross-references" "tables"
.iX  "cross-references" "examples"
.iX  "cross-references" "steps"
.iX  "cross-references" "lines"
.iX  "cross-references" "columns"
.LI
When you refer to a chapter, section, appendix, figure, table, or
example by number, use an initial capital letter for the manual part.  The
only exceptions are references to steps, lines, and columns.  
.DS 1
See Chapter 5.
Refer to Table 4-2, column 8.
See Appendix A.
See step 2.
.DE
.LI
Refer to all figures, tables, and examples in the text
.I before
they appear.  Refer to these elements by number if they
are numbered, rather than by title.  Place the figure, table, or example as
closely as possible after its first reference in text.
.iX  "cross-references" "punctuating"
.LI
References can appear within a sentence, stand alone as complete
sentences, or appear in parentheses as either complete or incomplete
sentences.  
.DS 1
Help windows have an action bar that contains the Help menu (see Figure 1-2).
Chapter 7 contains a detailed discussion of dialog boxes.  Secondary windows 
are always related to a parent window.  (See Chapter 3 for more information.)
Use the Menu dialog box buttons (listed in Table 3-1) to save.
.DE
.iX  "above"
.iX  "below"
.iX  "previous"
.iX  "preceding"
.iX  "following"
.iX  "earlier"
.iX  "later"
.LI
Be specific when you point a reader to another section, figure, formal example, table, chapter, or appendix.  You can use the words
.I previous
and
.I following
when referring to an informal example, table, figure,
or list.  (Variants of
.I following
such as
.I follows
are also correct in this case.)
.P 1
.I Use
.DS 1
See Section 3.2 for more information.

See the section titled "Compiling Your Program" for more information.

This is explained in the following example:
.DE
.P 1
.I "Do not use"
.DS 1
See the previous section for more information.
.DE
.LI
When referring readers to non-OSF documents, provide complete
bibliographical information in a footnote. See \fIWords Into
Type\fR for information on how to format bibliographical 
information.
.FS
\fIWords Into Type\fR 3rd ed. rev. Englewood Cliffs, NJ: Prentice-Hall,
Inc., 1974.
.FE
.LE
.H 2 "Quotation Marks"
.iX "quotation marks" 
.iX "punctuation" "quotation marks"
.P
Follow these guidelines for quotation marks:
.BL 
.LI
Use quotation marks to enclose standard technical terms that
are used in a nonstandard way.
.iX "quotation marks" "with section titles"
.LI
Use quotation marks in describing section titles that are unnumbered.
.LI
Do not use quotation marks to lend emphasis to a word or phrase.  
Use italics instead.
.iX "quotation marks" "in examples"
.LI
Do not use quotation marks to indicate a direct quotation or literal response or
piece of code within text. Use constant width instead.  
.LI
Do not put quotation marks around command names, filenames, user
responses, or syntax. You can, however, use quotation marks within interactive
examples.  For example:
.DS 1
\fBset prompt = "`hostname` \! % "\fR
.DE
.LE
.H 2 "Screen Objects"
.iX "screen objects"
.iX "online" "screen objects" 
.P
A screen object is anything that appears on a screen, such as a box,
menu, control, icon, and so on.  Follow these guidelines when you refer to
screen objects:
.BL 
.LI
Capitalize the name of the object as it appears on the screen.  If a
screen object is not labeled, normal capitalization rules apply.
.LI
Do not use the names of screen objects as verbs.
.P 1
.I Use
.DS 1
To reverse the effects of your previous operation, choose the 
Undo menu item.
.DE
.P 1
.I "Do not use"
.DS 1
To Undo the effects of your previous operation, choose the Undo 
menu item.
.DE
.LI
Include the ellipsis (\|\ .\ .\ .\|) when it appears on the screen.
.DS 1
The Open\|.\|.\|. menu item displays the file selection dialog box.
.DE
.LI
Do not put quotation marks around items designated as screen objects.
.LI
Use the full name of a dialog box the first time you refer to it in
text.  Thereafter, you can use the short form.
.DS 1
This is the Print dialog box.  To close the dialog box 
without making any changes, click on Dismiss.
.DE
.LI
Use the verbs
.I display
and
.I remove
to refer to a dialog box.  
.DS 1
The File Selection dialog box is displayed.
The dialog box is removed from the screen.
.DE
.LI
Use the verbs
.I open
and
.I close
to refer to windows.  
.DS 1
To open the Chart Parts window...
To close the Chart Parts window...
.DE
.LE
.H 2 "Semicolons"
.iX "semicolons"
.iX "punctuation" "semicolons"
.P
Use the following guidelines for semicolons:
.BL 
.LI
Use a semicolon instead of a comma and conjunction to join closely
related independent sentences or clauses.  
.DS 1
The system automatically assigns the next available number
to your topic; the system does not reuse numbers of
deleted topics.

The first \fBif\fR command compares two integers; the second \fBif\fR
command compares two strings.
.DE
.LI
Use a semicolon when items in a series are long and complex or involve
internal punctuation.
.DS 1
The standard directory listing consists of the following
columns: the file name, including the file type; the
file length expressed in blocks; and the date of creation.
.DE
.\".LI
.\"If the number of items embedded in a series is large, consider using a
.\"vertical list without semicolons rather than an embedded list with
.\"semicolons.
.\".P 1
.\".I Use
.\".DS 1
.\"This chapter includes information about the following file types:
.\"   COM  Command procedure
.\"   DAT  Data file
.\"   DIS  Distribution list for MAIL
.\"   EDT  Startup command file for the EDT editor
.\"   EXE  Executable program image file
.\".DE
.\".P 1
.\".I "Do not use"
.\".DS 1
.\"This chapter includes information about the following file types: 
.\"COM, a command procedure; DAT, a data file; DIS, a distribution 
.\"list for mail; EDT, a start-up command file for the EDT editor; and 
.\"EXE, an executable program image file.
.\".DE
.LE
.H 2 "Slang"
.\".XX R "Slang"
.\".P
.\"Avoid the use of slang terms in documentation.
.\".TS H
.\"tab(@);
.\"lfB lfB
.\"lw(2.25i) l.
.\"_
.\".sp 4p
.\"Use@Do not use
.\"
.\".sp 4p
.\"_
.\".sp 4p
.\".TH
.\"Vertical bar@pipe
.\"Exclamation mark@bang, baseball bat
.\"Asterisk@star
.\".sp 6p
.\"_
.\".TE
.\".R
Avoid the use of slang terms, idioms, colloquialisms, and industry jargon in documentation.  Their use is inappropriate in literary language, difficult to understand even for an international audience familiar with English, and cannot be accurately translated into other languages.
.H 2 "Symbols"
.iX "Symbols" "how to write"
.P
Follow these guidelines when you use symbols:
.BL 
.LI
Use the symbol in text and write out the name in
parentheses.  You can use the symbol alone in tables and code examples to
conserve space.  
.iX "symbols" "in tables"
.iX "symbols" "in code examples"
.iX "tables" "symbols in"
.iX "examples" "symbols in"
.DS 1
The \|$\| (dollar sign) is the default prompt.
.DE
.\"\fBException:\fR OSF manpages show the symbol first and then enclose 
.\"the name of the symbols in parentheses. 
.LI
If there are only two items in a series, repeat the
symbol for a unit of measurement. 
.iX "abbreviations" "in series"
.iX "symbols" "in series"
.DS 1
10% to 50%
.DE
.LI
If there are more than two items in a series, place the symbol for a
unit of measurement at the end of the series.
.DS 1
12, 14, or 16 ft
.DE
.iX "symbols" "plurals"
.LI
A symbol has no plural form. Spell out the name of the symbol to
pluralize it.
.P 1
.I Use
.DS 1
Enter three slashes (///).
.DE
.P 1
.I "Do not use"
.DS 1
Enter three /'s.
.DE
.LE
.H 2 "System Names in Text"
.iX "names" "using system"
.P
For security information, never include names of actual system accounts and
passwords in documentation.  
It is not a security problem to use the names of real systems or
networks.  Remember to edit system and user information out of screen-captured
.\"For more information on symbols, see Chapter 5.
