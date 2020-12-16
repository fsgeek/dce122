...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c3.BC.mm,v $
.\" Revision 1.1.2.7  1994/06/24  15:15:13  fred
.\" 	free copyright
.\" 	[1994/06/23  20:21:25  fred]
.\"
.\" Revision 1.1.2.6  1994/06/23  18:39:08  fred
.\" 	free copyright
.\" 	[1994/06/22  19:09:09  fred]
.\" 
.\" Revision 1.1.2.5  1993/06/11  19:39:41  josh
.\" 	Fixed typo
.\" 	[1993/06/11  19:39:21  josh]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:05:49  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:02:19  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:35:46  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:32:49  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:04:45  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:57:21  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
.H 2 "Braces, Brackets, Parentheses"
.P
Follow these guidelines for brackets, braces, and parentheses:
.iX "braces"
.iX "parentheses" 
.iX "-: braces" "curly braces"
.BL 
.LI
Use the term
.I braces 
{\|\|}, not the term
.I "curly braces" .
.LI
In syntax diagrams, braces indicate required elements of the syntax. 
.iX "brackets"
.iX "parentheses"
.iX "-: brackets" "square brackets" 
.LI
Use the term
.I brackets
[\|\|], not the term
.I "square brackets" .
.LI
In syntax diagrams, brackets indicate optional elements of the syntax.
.LI
If required by the context, place a comma after the closing bracket.
.LI
If brackets or parentheses enclose a sentence, place the period inside the 
closing bracket or parenthesis.
.LI
If brackets or parentheses enclose a phrase that ends a sentence, place the
period outside the closing bracket or parenthesis.
.LI
If you cannot avoid nested parenthetical remarks, use brackets for the
inner remark and parentheses for the outer remark.
.LE
.P
See also \fBtypographic and keying conventions\fR.
.H 2 "Can, May, Might, Should"
.\" 
.\" ***PIP Rev. B***
.\" 
.iX "may, might, should, can"
.iX "might, may, should, can"
.iX "should, might, may, can"
.iX "can, may, might, should"
.iX "auxiliary, verbs"
.iX "verbs, auxiliary"
.iX "internationalization" "can"
.iX "internationalization" "may"
.iX "internationalization" "might"
.iX "internationalization" "should"
.P
Use the active voice whenever possible.  Avoid qualifying sentences
with
.I may ,
.I might ,
and
.I should .
.P 1
.I Use
.DS 1
Use the active voice whenever possible.
.DE
.P 1
.I "Do not use"
.DS 1
You should use the active voice whenever it may be possible.
.DE
.P
Auxiliary verbs, such as
.I may ,
.I might ,
and
.I should
are ambiguous in English.  In particular,
.I may
is confusing, because it can either mean
.I "is allowed to be"
or
.I "could possibly/probably be" .
(Can, on the other hand, implies having
.I ability
to be.)
.DS 1
You can run the program by pressing \fB<Return>\fR.
You may turn the system off after you log out.
.DE
.P
This confusion can cause translation errors.  Avoid this problem by using
the imperative.
.P 1
.I "Original Text" :
.DS 1
No initial value may be specified.
.DE
.P 1
.I "Possible Misinterpretation and Translation" :
.DS 1
You may not specify an initial value.
.DE
.P 1
.I "Intended Meaning" :
.DS 1
Do not specify an initial value.
.DE
.P
\fBException:\fR You can use \fIcan\fR, \fImay\fR, \fImight\fR, and 
\fIshould\fR provided you accurately define their usage as it applies to 
your document. For example, these terms had specific applications 
in the \fIOSF/Motif Style Guide\fR and were clearly defined in 
the text preceding their use.
.P
.H 2 "Capitalization"
.iX "capitalization"
.iX "captions"
.iX "headers"
.iX "word list" "capitalization"
.iX "dictionaries" "rules for capitalization"
.iX "capitalization" "initial capital letters"
.iX "initial capital letters"
.P
All sentences begin with a capital letter.  Do not begin a sentence with
the name of a command, program, utility, file, directory, or other name if
that name begins with a lowercase letter.  In general, nouns that refer to
a specific person, title, or thing begin with a capital letter.
.P
\fBException:\fR  OSF manpage rules require that each paragraph begin with capitalization; however, sentences within a manpage paragraph can and often do begin with lowercase names of commands, programs, files, directories, or similar terms.
.P
Nouns that refer to generic or nonspecific people or things are written in
lowercase.
.DS 1
system manager
computer
program
.DE
.BL 
.LI
'B "Use initial capital letters in the following situations" :
.iX "key names" "capitalization of"
.iX "capitalization" "key names"
.DL 
.LI
For specific product names.
.LI
For key names that are labeled on the keyboard.
.DS 1
Press \fB<Return>\fR.
.DE
.iX "screen objects" "capitalization rules"
.iX "capitalization" "of screen objects"
.LI
For names of objects capitalized  on the screen.  
.DS 1
The Clear menu item deletes the correct selection.
.DE
.P 
If an object is not labeled on the screen, normal 
capitalization rules apply.  
.DS 1
To shrink a window to an icon, click on the shrink-to-icon button.
.DE
.LI
For specific register names, bit names, signal line names, and transaction
names.  However, if these are used generically, use lowercase letters.
.LI
In titles and section heads, use initial capitals for the following:  
.iX "titles and section heads" "capitalizing"
.iX "capitalization" "titles and section heads"
.iX "headings" "capitalizatiing"
.ML -
.LI
All elements of a hyphenated term (except articles, coordinating
conjunctions, prepositions with four or fewer characters, and commands that
are case-sensitive). 
.DS 1
Single-Call Subroutine
Search-and-Replace
.DE
.LI
Abbreviations, even if they are normally in lowercase letters.
.LI
All words except articles, coordinating conjunctions, the word
.I to
in infinitives, prepositions with four or fewer
characters, and commands that are case-sensitive.
.LE
.LI
For cross-references by title.
.iX "capitalization" "cross-references"
.iX "cross-referencing" "titles"
.P
When you refer to the title of a manual, chapter, or
appendix, follow the guidelines for capitalizing titles.
.P 
For more information about cross referencing, see
\fBcross-references\fR.
.LI
For cross-references by number.
.iX "cross-referencing" "numbers"
.iX "cross-referencing" "steps"
.iX "cross-referencing" "columns"
.iX "cross-referencing" "lines"
.P 
When you refer to a chapter, section, appendix, figure, table, or example by
number, use an initial capital letter for the manual part. (Exceptions are
references to
.I step ,
.I line ,
and
.I column ,
even when followed by a number.) 
.DS 1
See Section 3.1.
Refer to Table 4-2, column 3.
See Appendix A. 
.DE
.iX "vertical lists" "capitalizing"
.iX "lists" "capitalizing"
.iX "capitalization" "vertical lists"
.iX "capitalization" "lists"
.LI
For the first word of every element in vertical lists.
.P
Use initial capital letters for the first word of every element in a vertical
list, whether it is in text, a table, or an example, unless the element is
case-sensitive.  See \fBlists\fR for more information.
.iX "capitalization" "text in art"
.LI
For the first letter of every word of text used in art, following the
capitalization guidelines for titles and section heads.  The exceptions are
flowcharts and data structures, where just the first word is capitalized.
.iX "capitalization" "initial capital letters"
.iX "initial capital letters"
.iX "lowercase letters"
.iX "capitalization" "lowercase letters"
.iX "lowercase letters"
.LE
.LI
'B "Use all lowercase letters in the following situations" :
.iX "screen objects" "capitalizing"
.iX "capitalization" "screen objects"
.DL 
.LI
For OSF/1 commands, pathnames, and functions.  For example:
.DS 1
% \fBlogin\fR
# \fBMAKEDEV lta16\fR
% \fBcd /usr/staff/r2/kafka\fR
.DE
.LI
For names of objects on the screen that are not
labeled on the screen. 
.DS 1
To reduce a window to an icon, click on the shrink-to-icon 
button.

The work area is the portion of the main window in which users 
perform most of their application-related work.
.DE
.LI
For generic register names, bit names, signal line names, and transaction
names. However, if you are referring to a specific name, use initial
capital letters.
.LI
In titles and section heads, use all lowercase letters for the
following:
.iX "capitalization" "titles and section heads"
.iX "titles and section heads" "capitalizing"
.ML -
.LI
Articles (a, an, the)
.LI
Coordinating conjunctions (and, but, or)
.LI
The word
.I to
in infinitives (to Be or Not to Be)
.LI
Prepositions with four or fewer characters (with, from)
.LI
Commands that are case-sensitive.
.LE
.LI
For generic software items without a model number, a type number,
or other specific identification. 
.DS 1
terminal
assembler
computer
breakpoint switch
.DE
.LI
For generic titles.
.iX "generic titles" "capitalizing"
.iX "capitalization" "generic titles"
.DS 1
system manager
server administrator
user
operator
.DE
.iX "switches" "capitalizing"
.iX "controls" "capitalizing"
.iX "capitalization" "controls"
.iX "capitalization" "switches"
.LI
For variable elements of program statements or commands. For
example:
.DS 1
argument
variable
command line
.DE
.LI
For step, line, and column, even when followed by a number. For
example: 
.DS 1
Refer to line 3 of the program.
See Table 6-7, column 3.
Repeat steps 2 and 3.
.DE
.LI
For concepts of online help.
.LI
For keys that are not labeled on the keyboard.
.LE 
.iX "lowercase letters" 
.iX "uppercase letters"
.LI
'B "Use all uppercase letters in the following situations" :
.iX "capitalization" "logical operations"
.iX "logical operations" "capitalizing" 
.iX "Boolean expressions" "capitalizing" 
.iX "capitalization" "Boolean expressions" 
.DL 
.LI
For logical operations (Boolean expressions), unless referring to the Ada
language, which uses lowercase keywords.
.DS 1 
AND
OR
NOT 
.DE 
.iX "acronyms" "capitalizing" 
.iX "Mnemonics" "capitalizing"  
.iX "Key names" "capitalizing" 
.iX "elements of programs" "capitalizing"
.iX "capitalization" "key names
.iX "capitalization" "elements of programs"
.iX "capitalization" "commands" 
.LI
For specific commands or qualifiers.
.iX "abbreviations" "in titles"
.iX "abbreviations" "capitalizing" 
.LI
For abbreviations used in a title, even if they are normally
in lowercase letters. 
.DS 1 
Figure 3-2 illustrates a dc regulator.
Figure 3-2: DC Regulator
.DE 
.iX "filenames" "capitalizing"  
.iX "capitalization" "file names" 
.LE
.LI
.H 2 "Case-Sensitivity"
.P
keywords. When you discuss case-sensitivity issues in your document,
keep in mind that there is a technical difference between 
case-sensitivity and case-correctness. For example, a facility
is case-sensitive or case-insensitive, a word or pathname is case-correct
or not case-correct. All commands, calls, and keywords must be 
case-correct.  Only use uppercase when uppercase is essential;
otherwise use lowercase.
Avoid starting a sentence with a command name or filename because
it may confuse your reader. For example:
.P 1
.I Use
.DS 1
The \fBprsvr\fR command executes the print server program.
.DE
.P 1
.I "Avoid"
.DS 1
\fBprsvr\fR executes the print server program. 
.DE
.P
\fBException:\fR However, if you must begin a sentence with the name of a command or
filename, do not change the way it is capitalized. (This usage is consistent
with our documentation conventions.) OSF manpage rules permit sentences within manpages that do not begin a paragraph to start with lowercase command names and filenames.  
.P
If a command name (or call or
keyword) that should be lowercase appears in the heading, do not
capitalize it just because the head is initial caps.
.P 1
.I Use
.DS 1
.B "-cond and -ncond: Conditional Compilation"
.sp
.B "The ld Utility"
.DE
.iX "Uppercase letters"
.iX "capitalization" 
.H 2 "Cautions and Notes"
.iX "cautions" "when to use"
.iX "notes" "when to use"
.iX "warnings" "when to use"
.P
Make sure that the type of notice you choose (\fBNOTE\fR or \fBCAUTION\fR) is appropriate for the information you are providing.
.BL 
.LI
A
note
contains information of special importance to the reader. 
.LI
A
caution
contains information that the reader needs to know to avoid damaging
the software. 
.LE
.H 2 "Chapter Table of Contents"
.P
Sometimes you will want to have a detailed table of contents (TOC)
immediately preceding each chapter in a document, in addition to a 
higher-level table of contents in the front matter of
the book.  A chapter table of contents is particularly useful
in command and call reference documents, for example, where you may
want to list the starting page for every command or call description.
Decide with your editor whether having chapter TOCs will add
value to your document.
.P
If you do use chapter TOCs, you should use them for all chapters in 
the document.  A chapter TOC always starts on the right-hand page
immediately before the first page of the chapter, which also
begins on a right-hand page. (The reverse side
of the chapter TOC will be either a continuation
of the chapter TOC or blank.)
.P
The first page of the chapter starts at page
.IR n -1 
as always.  The chapter TOC does not have
any printed page number.  This pagination scheme lets you add or
delete chapter TOCs at any time without having to renumber pages and
regenerate indexes and book TOCs.  However, you 
and your editor must ensure that chapter TOCs are 
included in camera-ready copy prepared for the publisher and you must 
check blues very carefully.
.H 2 "Colons"
.iX "for example" "using colons with"
.iX "colons"
.iX "punctuation" "colons"
.P
A colon directs the reader's attention to whatever follows it: a
list, a definition, an instruction, or important additional
information. 
.BL 
.LI
Use a colon when you use
.I "for example" ,
.I "the following" ,
.I follows , 
or
.I "as follows"
to lead in to a formula, line of code, or vertical list.
.DS 1
The formula follows:
.DE
.LI
Use a colon at the end of a sentence that introduces a list, if that sentence is
incomplete without the items in the list, or if the items are incomplete
sentences. (See \fBlists\fR for some exceptions to this rule.)
.DS 1
Your system contains three elements:
- Video screen
- Keyboard
- Printer
.DE
.LI
Do not use a colon at the end of a lead-in sentence to a formal table or
figure; use a period. 
.P 1
.I Use
.DS 1
Figure 3-4 is a diagram of the database.
.DE
.P 1
.I "Do not use"
.DS 1
Figure 3-4 is a diagram of the database:
.DE
.LE
See 
.B lists
for more information about using colons.
.H 2 "Commands"
.iX "commands"
.iX "commands" "in text"
.iX "-: commands" "command qualifiers" 
.P
Follow these guidelines when documenting commands:
.BL 
.LI
Use the verb
.I enter
rather than
.I type
when introducing a command.  
.DS 1
Enter the \fBlpr\fR command.
.DE
.LI
Use command names only as nouns or adjectives.  Do not use command names 
as verbs. 
.iX  "nouns" "commands as"
.iX  "adjectives" "commands as"
.iX  "verbs" "commands as"
.iX  "commands" "as nouns"
.iX  "commands" "as adjectives"
.iX  "commands" "as verbs"
.P 1
.I Use
.DS 1
To remove the files, use the \fBrm\fR command.
When you log out, the screen darkens.
.DE
.P 1
.I "Do not use"
.DS 1
You are finished after you have \fBrm\fR'ed your files.
When you \fBlogout\fR, the screen darkens.
.DE
.LI
If the commands you are documenting are case-sensitive, retain the
case everywhere, including chapter and section titles and figure 
and table titles.  For example:  
.iX  "commands" "case-sensitivity of"
.iX  "commands" "uppercase letters with"
.DS 1
To show your working directory, use the \fBpwd\fR command.
.SP
\fBFigure 2-6.\fR The \fIxmfonts\fR Widget Tree
.DE 
.LI
Do not put quotation marks around command names.
.iX  "commands" "with quotation marks"
.iX  "quotation marks" "with commands"
.P 1
.I Use
.DS 1
Enter the \fBlpr\fR command.
.DE
.P 1
.I "Do not use"
.DS 1
Enter the "\fBlpr\fR" command.
.DE
.LI
Italicize variables used with commands.  Do not hyphenate variable names.
.iX  "commands" "variables"
.iX  "variables" "italicizing"
.iX  "variables" "hyphenating"
.P 1
.I Use
.DS 1
\fBarp -f\fR \fIfilename\fB 
.DE
.P 1
.I "Do not use"
.DS 1
\fBarp -f\fR \fIfile-name\fR
.DE
.LI
Avoid beginning a
sentence or title with a lowercase command name.  Instead,
reword the sentence to avoid putting the command name first.
.iX "commands" "beginning sentences with"
.P 1
.I Use
.DS 1
The \fBpwd\fR command prints your working directory.
.DE
.P 1
\fIDo not use\fR
.DS 1
\fBpwd\fR prints your working directory.
\fBPwd\fR prints your working directory.
.DE
\fBException:\fR  OSF manpage rules require that each paragraph begin with capitalization; however, sentences within manpage paragraphs 
can and often do begin with lowercase names of commands, programs, files, directories, or similar terms.
.LI
Avoid referring to a command's manpage as if
it were the command name itself.  Instead, explicitly refer the reader to
the manpage.
.iX "-: reference page" "manual page"
.iX  "commands" "reference page reference"
.iX  "reference page" "reference to"
.iX  "cross-references" "to reference page"
.P 1
.I Use
.DS 1
You can use \fBuucpsetup\fR to add the modem.  See \fBuucpsetup\fR(8)
for more information.
.DE
.P 1
.I "Do not use"
.DS 1
You can use \fBuucpsetup\fR(8) to add the modem.
.DE
.LI
Many command options start with a - (dash) do not refer to this character as a hyphen in your documentation.
.iX  "commands" "options"
.iX  "command options"
.iX  "placement of options"
.iX  "options, command"
.LI
Do not start a sentence with a command option.
.P 1
.I Use
.DS 1
The \fB\-z\fR option lets you specify the page length.
.DE
.P 1
.I "Do not use"
.DS 1
\fB\-z\fR lets you specify the page length.
.DE
.LE
.P
See also \fBhelp\fR, \fBtypographic and keying conventions\fR, and \fBcase-sensitivity\fR.
.H 2 "Commas"
.iX  "commas"
.iX  "punctuation" "commas"
.P
A comma marks a pause, or a separation of ideas or elements, in a sentence.
.BL 
.LI
Use a comma to separate three or more elements in a series.  If
the last two elements are joined by a conjunction, place a comma before the
conjunction.  
.DS 1
This chapter discusses the PE, the PC, and the CPU.
.DE
.LI
Place a comma before the conjunction in a compound sentence (consisting
of two or more independent clauses), unless the clauses are short and
closely related.  
.DS 1
The system prints an error message, but you can continue processing the file.
.DE
.LI
Use commas to set off a nonrestrictive modifier (which provides
additional information but does not affect the meaning of the words it
modifies). 
.DS 1
A symbol value may be an absolute constant, expressed as a 32-bit
integer, or a relocatable value.
.DE
.LI
Do not use commas to set off a restrictive clause (which affects the
meaning), from the word it modifies.  
.DS 1
Table 6-1 describes the hardware that you need to complete your system.
.DE
.LI
Use commas to set off contrasting and opposing expressions within
sentences.
.DS 1
He changed the software, not the hardware.
.DE
.LI
Place a comma after an introductory clause or long introductory phrase.
.DS 1
To specify an output device, enter a name in the command line.
.DE
.LI
Use a comma after transitional phrases such as
.I "such as," 
.I "for example" ,
and
.I "that is" .
.DS 1
For example, there are over eight boards.
.DE
.LI
Place a comma after a closing parenthesis or bracket.  
.DS 1
With the \fBretrieve\fR option (see Section 8.9.4), you can retrieve files that you accidentally deleted.
.DE
.LI
Place a comma inside closing quotation marks, unless the quotation marks
are part of a literal string.
.DS 1
If you type "This is a string", the system displays it on the terminal without the quotation marks.
.DE
.LE
.P
See also
.B semicolons .
.H 2 "Conjunctions"
.iX  "and conjunction"
.iX  "or conjunction"
.\" 
.\" ***PIP Rev. B***
.\" 
.iX  "internationalization" "and"
.iX  "internationalization" "or"
.iX  "internationalization" "conjunctions"
To avoid ambiguous usage of conjunctions that can cause errors in translation, follow these rules for punctuating conjunctions:
.BL
.LI
When the elements in a series are very simple and are all joined by conjunctions, no commas should be used.
.LI
In a series consisting of three or more elements, the elements are separated by commas.  When a conjunction joins the last two elements in a series, a comma is used before the conjucntion.
.LI
When the elements in a series are long and complex or involve internal punctuation, they should be separated by semicolons.
.LI
When the clauses of a compound sentence are joined by a conjunction, a comma should be placed before the conjunction unless the clauses are short and closely related.
.LI
In a compound sentence composed of a series of short independent clauses the last two of which are joined by a conjunction, commas should be placed between the clauses and before the conjunction.
.LE
Editor's Note:  Please provide me with examples of each of these five rules.
.H 2 "Contractions"
.iX  "contractions"
.P
OSF prefers not to use contractions in its technical documentation.  
.H 2 "Copyrights"
.iX  "copyrights"
.P
Copyrights are legal rights to exclusive publication, sale, or
distribution of products.  Copyright information and regulations vary by
country.  
.BL 
.LI
All OSF documents are copyrighted.  According to current U.S. law,
the notice is required
to be on the front or back of the title page.  In OSF documents, it
appears on the back of the title page. 
.LI
Copyright notices must include the word
.I Copyright 
and the copyright symbol (\(co); the 
dates for the first release, all subsequent releases, and 
the current release; and the owner of the copyright. For example:
.P 1
Copyright\(co 1990, Open Software Foundation, Inc.
.LI
Copyright notices must be provided for information contained in
documents that has been taken from other vendor documents, along
with the ALL RIGHTS RESERVED statement.  For example:
.DS 1
Copyright\(co 1989, Digital Equipment Corporation
Copyright\(co 1987, 1988, 1989, Hewlett-Packard Corporation
Copyright\(co 1988, Massachusetts Institute of Technology
Copyright\(co 1988, Microsoft Corporation
ALL RIGHTS RESERVED
.DE
.LI
Published documents require the printed in USA statement.  Prentice-Hall
reconstructs our title pages and they do this for us.
.LE
Editor's Note:  In the future, we will research whether the following tiem is required for OSF documents.
.BL
.LI
Copyright notices must include a restricted rights legend. The U.S. government
takes the absence of this legend as an indication that 
OSF has no further claim to the documentation, and that it can be copied.  The
following legend must appear on all copyright pages:
.DS 1
Restricted Rights: Use, duplication, or disclosure by the
U.S. Government is subject to restrictions as set forth
in subparagraph 1ii of the Rights in Technical Data and
Computer Software clause at DFARS 252.227-7013.
.DE
See also
.BR "Trademarks".
.LE
