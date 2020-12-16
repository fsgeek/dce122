...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c3.mm,v $
.\" Revision 1.1.2.6  1994/06/24  15:15:37  fred
.\" 	free copyright
.\" 	[1994/06/23  20:22:08  fred]
.\"
.\" Revision 1.1.2.5  1994/06/23  18:39:33  fred
.\" 	free copyright
.\" 	[1994/06/22  19:10:10  fred]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:06:07  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:02:49  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:36:03  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:33:17  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:06:00  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:58:06  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
.H 1 "Usage Guidelines"
This chapter contains miscellaneous guidelines on usage, arranged
alphabetically. It also contains extensive information pertaining to
translations considerations. Follow these guidelines whether or not
you think your documentation will be translated.
.Ns N
Considerations of
internationalization, online documentation, help, and human factors
are interspersed throughout this document, rather than appearing in discrete
appendixes.  In this way, we hope to make this information more usable and
more readily available.
.Ne
.H 2 "Abbreviations"
.XR "Internationalization, See Translation considerations"
.XX "Abbreviations, rules for using"
.P
Use the following guidelines for abbreviations:
.XX "Translation considerations, abbreviations"
.BL 
.LI
Whenever possible, avoid using abbreviations.  Abbreviations are easy
to misinterpret, especially abbreviations for words that are not
translated.  Also, users may encounter an
abbreviation after its definition, and must then search through previous
pages or screens to find the meaning.
.XX "Abbreviations, in text"
.XX "Abbreviations, first use"
.XX "Abbreviations, in long manuals"
.XX "Abbreviations, later occurrences of"
.LI
When you use an abbreviation, spell out the name and follow it with the
abbreviation in parentheses the first time you use it in each chapter. 
.DS 1
The Central Processing Unit (CPU) interprets the instruction.
.DE
.XX "Abbreviations, in titles"
.LI
Generally, avoid using abbreviations in chapter and section titles.  
When you must use an abbreviation in a title, define the abbreviation in the
text that follows.  In later occurrences, use either the spelled-out term or
the abbreviation, but be consistent throughout the manual.
.XX "Abbreviations, in tables"
.XX "Abbreviations, in figures"
.XX "Abbreviations, in examples"
.XX "Abbreviations, in footnotes"
.LI
You may use abbreviations in tables, examples, figures,
and footnotes.  Define abbreviations before using them in
tables; do not define abbreviations in tables.
.LI
Generally, avoid beginning sentences with abbreviations.
.LI
Do not use periods with abbreviations, unless the abbreviation can be
confused with an actual word (no. for number;  in. for inch).
.LI
Insert one space between a number and the abbreviation or unit
symbol it modifies.  Exceptions include KB, MB, kHz, MHz, GHz, and K
unless they are used as modifiers in which case insert a hyphen (for
example, a 512-MB memory).
.DS 1
6 ft	6MB	6KB	6MHz	6kHz
.DE
.XX "Abbreviations, plurals of"
.LI
Form plurals of most abbreviations by adding a
lowercase
.I s .  
.P
Plural abbreviations of units of measurement are exceptions to this
guideline. Singular and plural abbreviations of units of measurement are
identical.  
.DS 1
1 lb	10 lb
1 h	20 h
1 km	4 km
1 in.	6 in.   
.DE
.XX "Abbreviations, in a series"
.LI
When using abbreviations in a series with two or more items, place the
abbreviation for a unit of measurement at the end of the
series.
.DS 1
1200, 1400, or 1600MHz
.DE
.LI
If the series has only two items, repeat the abbreviation for a unit
of measurement. 
.\" 
.\" This material is duplicated in the "numbers" and  "symbols" entries.
.\" 
.DS 1 
10 ft to 12 ft
.DE
.LI
Avoid examples that require an alphabetically ordered list of abbreviations
to convey meaning.  This can cause translation difficulties because the
translated list will probably not be in alphabetical order.  If you cannot
avoid using an alphabetically ordered list, 
include a comment in the source file
indicating the purpose of the example so that the translators can
design an example that is appropriate for their country.
.LI
The abbreviation
.I K
can mean either 1024 (a binary
thousand) or Kelvin. The difference between these two uses of
K is usually clear in context.  
.DS 1
For proper operation, a superconducting board with 64K words of 
memory must be cooled to a temperature of 5K.
.DE
.LE
.P
See also
.B "acronyms, mnemonics" ,
and
.B  measurements.
.H 2 "Acronyms and Mnemonics"
.P
Acronyms are words formed from the initial letters  or parts of
compound terms.  Mnemonics are memory aids,  often created by
combining letters to form word-like expressions.
.XX "Acronyms, rules for using"
.XX "Mnemonics, rules for using"
.XX "Forming plurals, of acronyms"
.XX "Acronyms, translating"
.XX "Mnemonics, translating"
.BL 
.LI
Use acronyms to refer to product names.  Never spell out acronyms that
are trademarks.  If the acronyms are trademarks, acronyms may
include lowercase letters. 
.P 1
.I Use
.DS 1
LSE is a text editor.
.DE
.LI
Whenever possible, avoid using
acronyms or mnemonics unless referring to product names.
Acronyms and mnemonics are not directly translatable, and
can have negative connotations in other languages.  
.P 1
.I "Do not use"
.DS 1
Acronyms are an I18N concern.
.DE
.LI
When you use an acronym or mnemonic, spell out the word or phrase and 
follow it with the shortened form in parentheses the first time you use it.
In later occurrences, use the acronym or mnemonic.  Define acronyms in a
glossary.
.XX "Acronyms, in titles"
.XX "Mnemonics, in titles"
.LI
Whenever possible, avoid using acronyms and mnemonics in chapter and section
titles.  
When you must use an acronym or mnemonic in a title, define it in the
text that follows. In later occurrences, use the acronym or mnemonic. 
.XX "Acronyms, in tables"
.XX "Acronyms, in examples"
.XX "Acronyms, in figures"
.XX "Acronyms, in footnotes"
.XX "Mnemonics, in tables"
.XX "Mnemonics, in examples"
.XX "Mnemonics, in figures"
.XX "Mnemonics, in footnotes"
.LI
Use acronyms and mnemonics in tables, examples, 
figures, and footnotes, provided that you have explained them fully
in the preceding text.
.LI
Use acronyms and mnemonics to start sentences, provided that
you have explained them fully in the preceding text.
.XX "Acronyms, plurals of"
.XX "Mnemonics, plurals of"
.LI
Form plurals of acronyms and mnemonics by adding a 
lowercase
.I s .
.DS 1
OEMs
ACLs
PCs
Ns
.DE
.XX "Acronyms, alphabetizing"
.LI
Avoid examples that require an alphabetically ordered list of acronyms
to convey meaning.  This can cause translation difficulties because the
translated list will probably not be in alphabetical order.  If you must
use an alphabetically ordered list, include a comment in the source file
indicating the purpose of the list so that the translators can
design an example that is appropriate for their country.
.XX "Third-party trademarks"
.XX "Digital, trademarks"
.XX "Trademarks, third-party"
.XX "Trademarks, Digital"
.XX "Trademarks, handbook of"
.LI
Spell acronyms and mnemonics without periods or intervening spaces.
.LI
In general, use uppercase letters for acronyms and mnemonics.  Acronyms
can include
lowercase letters if the acronyms are trademarks.
.LI
Many product names are acronyms for longer phrases that describe
the product.  The derivation of the acronym may be of
little importance to the reader, or the acronym may be so commonly used that 
its expansion is unnecessary; for example, BASIC or FORTRAN.   In this case, 
omit the descriptive phrase.  Do not capitalize the letters of the
acronym in the spelled-out version unless their capitalization is required.
.P 1
.I Use
.DS 1
data exchange control (DXC)
Institute of Electrical and Electronics Engineers (IEEE)
.DE
.P 1
.I "Do not use"
.DS 1
Data eXchange Control (DXC)
.DE
.LE
.H 2 "Adjectives, Strings of"
.XX "Adjectives, strings of"
.XX "Translation considerations, adjectives, strings of"
.P
Do not overuse adjectives. A string of adjectives is difficult to follow
and can lead to misinterpretation and incorrect translation.
The following sentence is clearer (and the
hyphenation problem disappears) with the use of a wider variety of parts of
speech.
.P 1
.I Use
.DS 1
Four constants partition the range of the function; these 
constants are determined by the data type.
.DE
.P 1
.I "Do not use"
.DS 1
Four data-type-dependent constants partition the range of the function.
.DE
.P
.H 2 "Alphabetizing (International Issues Must be Addressed)" 
.P
Use the following guidelines for alphabetizing acronyms, symbols, and
numbers in the English language.  Use collating order for non-English languages.
.XX "Alphabetizing, lists"
.XX "Alphabetizing, tables"
.XR "Alphabetizing, indexes: See INDEXES"
.XX "Translation considerations, alphabetizing"
.BL 
.LI
Avoid examples that require an alphabetically ordered list or table to convey
meaning.  This can cause translation difficulties because the translated
list or table will
probably not be in alphabetical order.  If you must use an
alphabetically ordered list or table, include a comment in the source file
indicating the purpose of the list or table so that the translators can
design an example that is appropriate for their country.
.LI
Alphabetize acronyms according to their shortened form.
.LI
Alphabetize symbols as though they were spelled out. 
.DS 1
&	(ampersand)
@	(at)
%	(percent)
.DE
.LI
In an alphabetized list, arrange numbers in ascending order. 
.P 1
.I Use
.DS 1
18
24
56
89
.DE
.LE
.H 2 "And/or"
.XX "And/or"
.XX "Translation considerations, and/or"
.P
Use the and/or construction sparingly. It is preferable to rewrite the
sentence entirely, or to use the two
choices, followed by
.I "or both" .
.P 1
.I Use
.DS 1
File specifications or logical names, or both
.DE
.P 1
.I "Do not use"
.DS 1
File specifications and/or logical names
.DE
.H 2 "Apostrophes"
.XX "Apostrophes, to form possessives"
.P
Use the following guidelines when using apostrophes to form plurals:
.XX "Apostrophes, to form plurals"
.BL
.LI
Do not use an apostrophe to form the plural of an acronym, mnemonic, or
number.  Use
just a lowercase
.I s .  
.DS 1
OEMs
4s
1920s
.DE
.LI
Use an apostrophe and a lowercase
.I s
to form the plural of a
lowercase letter used as a noun. 
.DS 1
a's	s's	x's	y's
.DE
.LI
Use the term single quotes instead of apostrophe to describe syntax
for parallelism with double quotes.
.P 1
.I Use
.DS 1
Enclose a character string in single quotes or double quotes.
.DE
.P 1
.I "Do not use"
.DS 1
Enclose a character string in apostrophes or double quotes.
.DE
.LE
.H 2 "Articles"
.XX "Articles, use of"
.XX "The, use of articles"
.XX "Translation considerations, articles"
.XX "A, use of articles"
.XX "An, use of articles"
.P
In English, the articles are
.I a ,
.I an ,
and
.I the .
Omit articles only when limited by space considerations such as
in tables.  Otherwise, do
not use instructions that omit articles.  This telegraphic
style of writing can lead to misinterpretations and incorrect translation.
.P 1
.I Use
.DS 1
Remove \fIthe\fP diskette from \fIthe\fP envelope.
.DE
.P 1
.I "Do not use"
.DS 1
Remove diskette from envelope.
.DE
.H 2 "Braces, Brackets, Parentheses"
.P
Follow these guidelines for brackets, braces, and parentheses:
.XX "Braces"
.XX "Parentheses, braces"
.XX "Curly braces, Use braces"
.BL 
.LI
Use the term
.I braces 
{\|\|}, not the term
.I "curly braces" .
.LI
In syntax diagrams, braces indicate required elements of the syntax. 
.XX "Brackets"
.XX "Parentheses, brackets"
.XX "Square brackets, Use brackets"
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
.XX "May, might, should, can"
.XX "Might, may, should, can"
.XX "Should, might, may, can"
.XX "Can, may, might, should"
.XX "Auxiliary verbs"
.XX "Verbs, auxiliary"
.XX "Translation considerations, can"
.XX "Translation considerations, may"
.XX "Translation considerations, might"
.XX "Translation considerations, should"
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
.XX "capitalization"
.XX "Captions"
.XX "Headers"
.XX "Word list, capitalization"
.XX "Dictionaries, rules for capitalization"
.XX "Capitalization, initial capital letters"
.XX "Initial capital letters"
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
.XX "Key names, capitalization of"
.XX "Capitalization, of key names"
.DL 
.LI
For specific product names.
.LI
For key names that are labeled on the keyboard.
.DS 1
Press \fB<Return>\fR.
.DE
.XX "Screen objects, capitalization rules"
.XX "Capitalization, of screen objects"
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
.XX "Titles and section heads, capitalization rules"
.XX "Capitalization, of titles and section heads"
.XX "Header levels, capitalization of"
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
.XX "Capitalization, of cross-references"
.XX "Cross-references, by title"
.P
When you refer to the title of a manual, chapter, or
appendix, follow the guidelines for capitalizing titles.
.P 
For more information about cross referencing, see
\fBcross-references\fR.
.LI
For cross-references by number.
.XX "Cross-references, by number"
.XX "Cross-references, to steps"
.XX "Cross-references, to columns"
.XX "Cross-references, to lines"
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
.\*.XX "Digital, capitalization of"
.XX "Vertical lists, capitalization of"
.XX "Lists, capitalization of"
.XX "Capitalization, of vertical lists"
.XX "Capitalization, of lists"
.LI
For the first word of every element in vertical lists.
.P
Use initial capital letters for the first word of every element in a vertical
list, whether it is in text, a table, or an example, unless the element is
case-sensitive.  See \fBlists\fR for more information.
.XX "Capitalization, of text in art"
.LI
For the first letter of every word of text used in art, following the
capitalization guidelines for titles and section heads.  The exceptions are
flowcharts and data structures, where just the first word is capitalized.
.XX "Capitalization, initial capital letters"
.XX "Initial capital letters"
.XX "Lowercase letters"
.XX "Capitalization, lowercase letters"
.XX "Lowercase letters"
.LE
.LI
'B "Use all lowercase letters in the following situations" :
.XX "Screen objects, capitalization rules"
.XX "Capitalization, of screen objects"
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
.XX "Capitalization, of titles and section heads"
.XX "Titles and section heads, capitalization rules"
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
.XX "Generic titles, capitalization of"
.XX "Capitalization, of generic titles"
.DS 1
system manager
server administrator
user
operator
.DE
.XX "Switches, capitalization of"
.XX "Controls, capitalization of"
.XX "Capitalization, of controls"
.XX "Capitalization, of switches"
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
.XX "Lowercase letters" 
.XX "Capitalization, lowercase letters" 
.XX "Capitalization, uppercase letters" 
.XX "Uppercase letters"
.XX "Uppercase letters" 
.LI
'B "Use all uppercase letters in the following situations" :
.XX "Capitalization, of logical operations"
.XX "Logical operations, capitalization of" 
.XX "Boolean expressions, capitalization of" 
.XX "Capitalization, of Boolean expressions" 
.DL 
.LI
For logical operations (Boolean expressions), unless referring to the Ada
language, which uses lowercase keywords.
.DS 1 
AND
OR
NOT 
.DE 
.XX "Acronyms, capitalization of" 
.XX "Mnemonics, capitalization of"  
.XX "Key names, capitalization of" 
.XX "Elements of program statements, capitalization of"
.XX "Commands, of acronyms
.XX "Capitalization, of key names
.XX "Capitalization, of elements of program statements"
.XX "Capitalization, of commands" 
.LI
For specific commands or qualifiers.
.XX "Abbreviations, in titles"
.XX "Abbreviations, capitalization of" 
.LI
For abbreviations used in a title, even if they are normally
in lowercase letters. 
.DS 1 
Figure 3-2 illustrates a dc regulator.
Figure 3-2: DC Regulator
.DE 
.XX "Abbreviations, of Digital Equipment Corporation" 
.XX "Digital, abbreviation for" 
.XX "File names, capitalizing"  
.XX "Capitalization, of file names" 
.LE
.LI
.H 2 "Case-sensitivity"
 .P
Use the following guidelines for capitalizing commands, calls, and
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
.XX "Capitalization, uppercase letters" 
.XX "Uppercase letters"
.XX "Capitalization" 
.H 2 "Cautions and Notes"
.XX "Cautions, notes, warnings, when to use"
.XX "Notes, cautions, warnings, when to use"
.XX "Warnings, notes, cautions, when to use"
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
.XX "For example, using colons"
.XX "Colons"
.XX "Punctuation, colons"
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
.XX "Commands"
.XX "Commands, in text"
.XX "Command qualifiers, See also Commands"
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
.XX R "Nouns" "commands as"
.XX R "Adjectives" "commands as"
.XX R "Verbs" "commands as"
.XX R "Commands" "as nouns"
.XX R "Commands" "as adjectives"
.XX R "Commands" "as verbs"
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
.XX R "Commands" "case-sensitivity of"
.XX R "Commands" "uppercase letters for"
.DS 1
To show your working directory, use the \fBpwd\fR command.
.SP
\fBFigure 2-6.\fR The \fIxmfonts\fR Widget Tree
.DE 
.LI
Do not put quotation marks around command names.
.XX R "Commands" "with quotation marks"
.XX R "Quotation marks" "with commands"
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
.XX R "Commands" "variables"
.XX R "Variables" "italicizing"
.XX R "Variables" "hyphenating"
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
.XX R "Commands" "beginning sentences with"
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
.XX R "Commands" "manual page reference"
.XX R "Manual page" "reference to"
.XX R "Cross-references" "to manual page"
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
.XX R "Commands"
.XX R "UNIX" "command options"
.XX R "UNIX " "placement of options"
.XX R "Options" "UNIX command"
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
.XX R "Commas"
.XX R "Punctuation" "commas"
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
.XX R "And conjunction"
.XX R "Or conjunction"
.\" 
.\" ***PIP Rev. B***
.\" 
.XX R "Translation considerations" "and"
.XX R "Translation considerations" "or"
.XX R "Translation considerations" "conjunctions"
.XX R "Conjunctions" "avoid ambiguous use of"
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
.XX R "Contractions"
.P
OSF prefers not to use contractions in its technical documentation.  
.H 2 "Copyrights"
.XX R "Copyright"
.XX R "Digital" "copyrights"
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
.LE
See also
.BR trademarks .
.H 2 "Cross-references"
.XX R "Cross-references"
.XX R "References, cross-"
.P
Use the following guidelines when making cross-references in your manuals.
.BL 
.LI
Be specific in cross-referencing; use exact names or numbers.
.LI
Do not use page numbers when making cross-references.
.XX R "Cross-references" "to OSF documents"
.LI
Make cross-references to other OSF manuals by document title.  Use
the italic font.  Do not refer to specific chapters, appendixes, or
sections in another book, even if the book is in the same document set.
Chapter and section numbers and titles often change from one version to the
next.
.XX R "Cross-references" "to text in same manual"
.LI
Make cross-references to text in the same manual by chapter or section
number.  Use the smallest section number that applies to the text you want
to reference.  To refer to an unnumbered heading within a numbered section,
use the section number and the unnumbered heading title in quotation marks.
.DS 1
See Section 1.3.5 for information about the MWM.
See "Choosing the Appropriate Control" for more information.
.DE
.XX R "Cross-references" "to chapters"
.XX R "Cross-references" "to sections"
.XX R "Cross-references" "to appendixes"
.XX R "Cross-references" "to figures"
.XX R "Cross-references" "to tables"
.XX R "Cross-references" "to examples"
.XX R "Cross-references" "to steps"
.XX R "Cross-references" "to lines"
.XX R "Cross-references" "to columns"
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
.XX R "Cross-references" "punctuation of"
.LI
Cross-references can appear within a sentence, stand alone as complete
sentences, or appear in parentheses as either complete or incomplete
sentences.  
.DS 1
Help windows have an action bar that contains the Help menu (see Figure 1-2).
Chapter 7 contains a detailed discussion of dialog boxes.  Secondary windows 
are always related to a parent window.  (See Chapter 3 for more information.)
Use the Menu dialog box buttons (listed in Table 3-1) to save.
.DE
.XX R "Above"
.XX R "Below"
.XX R "Previous"
.XX R "Preceding"
.XX R "Following"
.XX R "Earlier"
.XX R "Later"
.LI
Be specific when you point a reader to another section, figure, formal example, table, chapter, or appendix.  You may use the words
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
See the above section for more information.
.DE
.LE
.H 2 "Dashes"
.XX R "Dashes" "en"
.XX R "Punctuation" "dashes"
.XX R "Dashes" "em"
.XX R "Hyphens" "See also Dashes"
.P
Dashes are used to indicate breaks in thought, breaks in the structure of a
sentence, and ranges of numbers.
.BL 
.LI
.I Em
dashes are used to indicate a break in thought or
in the structure of a sentence.  Em dashes can be used to set off parenthetical
material in a sentence, in place of parentheses or commas.  You can also use an em dash in place of a colon to introduce an embedded list or
to alert the reader than an important explanation, definition, or
qualification is to follow. 
.DS 1
The internal date and time format is a 36-bit quantity \*(EM one that
frequently occurs as an argument or is returned as a value.
.DE
.LI
.I En
dashes are shorter than em dashes, and are used to indicate page and section 
numbers, figure and table numbers, product names,
and ranges of numbers.  
.LE
.H 2 "Dates"
.\" 
.\" ***PIP Rev. B***
.\" 
.XX R "Dates"
.XX R "Month"
.XX R "Year"
.XX R "Translation considerations" "date"
.XX R "Translation considerations" "day"
.XX R "Translation considerations" "month"
.XX R "Translation considerations" "year"
.P
The format of dates varies from country to country.  The date 
January 4, 1989 is formatted 1/4/89 in the United States; 1989-01-04 in
Denmark; 89-01-04 in Sweden; and 4.1.89 in Italy.  Follow these guidelines:
.BL 
.LI
Spell out the month in all references to dates.
.LI
Do not abbreviate the year (for example, use 1990; do not use 90 or '90.)
.LI
If you use dates in examples, include a comment in the source file
indicating the purpose of the example so that the translators can
design an example that is appropriate for their country.
.LE
.H 2 "Displays"
.XX R "Display" "preferable to appear"
.XX R "Appears" "See Displays"
Follow these rules for the verb \fIdisplay\fR.
.BL 
.LI
Use the verb
.I display
rather than
.I appear .
You may use the word
.I appearance .
.P 1
.I Use
.DS 1
The prompt is displayed on the screen.
At the appearance of the prompt, enter your username.
.DE
.P 1
.I "Do not use"
.DS 1
The prompt appears on the screen.
.DE
.LI
The verb
.I display
requires an object.  Often, the phrase 
.I "is displayed"
is preferable to
.I displays .
.P 1
.I Use
.DS 1
The system displays a response.
The system response is displayed on the screen.
.DE
.P 1
.I "Do not use"
.DS 1
The system response displays on the screen.
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
.LE
.H 2 "Ellipses"
.XX R "Ellipses"
.XX R "Vertical ellipses"
.XX R "Horizontal ellipses"
.XX R "Dots" "ellipses"
.XX R "etc." "See Ellipses"
.P
An ellipsis is a series of vertical or horizontal dots.
.BL 
.LI
In code examples, a vertical or horizontal ellipsis indicates an omission of 
information. 
.LI
In syntax formats, a vertical or horizontal ellipsis indicates an item that
repeats.
.LI
When describing screen objects in text, include the
ellipsis if it is part of the object on the screen.
.DS 1
The Open... menu item displays the File Selection dialog box.
.DE
.LE
.H 2 "Emphasis"
.XX R "Font" "for emphasis"
.XX R "System messages" "emphasizing"
.XX R "Italic" "for emphasis"
.XX R "Boldface" "for emphasis"
.XX R "Emphasis"
.XX R "Defining new terms" "font for"
.XX R "New terms" "font for"
.XX R "Manual titles" "font for"
.XX R "Referencing titles of manuals" "font for"
.XX R "Titles of manuals" "font"
.XX R "Second color" "as emphasis"
.XX R "Color" "second"
.XX R "Translation considerations" "second color"
.P
Bold font, italic font, quotation marks, and monowidth font are different
ways of emphasizing terms and phrases within your documentation.  
The text-formatting tool you use determines whether the emphasized output
is bold or italic.  The following conventions are recommended:
.BL 
.LI
When you define a term in text for the first time, use a bold font for the term.
.LI
To indicate user input in examples, use a bold font.
.LI
To emphasize a term or phrase, use italic font.  Do not overuse italic font.
.LI
To indicate variables, use italic font.
.LI
To reference titles of manuals, use italic font.
.LI
To set off system messages that appear in text, use monowidth font.
.LE
.H 2 "Enter and Type"
.XX R "Enter"
.XX R "Enter" "a command"
Follow these rules for the verbs \fIenter\fR and \fItype\fR. 
.BL 
.LI
Use
.I enter
for invoking commands from the keyboard.  For example:
.XX R "Enter" "menu information"
.XX R "Enter" "form field information"
.DS 1
To set the file transfer type to binary, enter the \fBbinary\fR subcommand
after the \f(CWftp>\fR prompt.
.DE
.LI
Use
.I enter
for information you put into a menu or form field.
.DS 1
Enter your login name in the username field.
.DE
.XX R "Enter" "response to prompt"
.LI
Use
.I enter
for combinations of typing text and pressing keys.  
.in 2P
.sp 7p
Enter the following command line:
.sp
$ \fBrm myoldfiles*\fR
'BX <Return>
.in
.LI
Do not use
.I enter
to indicate the start up of an application.
.P 1
.I Use
.DS 1
Start the XYZ application.
.DE
.P 1
.I "Do not use"
.DS 1
Enter the XYZ application.
.DE
.LI
Use
.I type
for the operation of typing text.  For example:
.DS 1
Type your mail message.
.DE
.LI
Use
.I type
to indicate a response to a prompt.
.DS 1
Type \fBY\fR at the confirmation prompt.
.DE
.LE
.H 2 "Environment Names"
.P
Here are some guidelines for dealing with environment names.
.BL
.LI
Do not use sys5, sys5.3, bsd4.2, or bsd4.3 except when you
are referring to specific pathnames and systypes.
.LI
Do not use SYSV, Sys5, SysV.3, BSD4.3, BSD4.2, bsd.
.LI
Use 4.3BSD or 4.4BSD only if you must indicate
a specific Berkeley release.  This sequence conforms with
Berkeley usage.
.LI
Use System V Release \fIn\fR if you must indicate the specific release.
.LE
.H 2 "Fewer and Less"
.XX R "Fewer" "and less"
.XX R "Less" "and fewer"
Use \fIfewer\fR and \fIless\fR as follows:
.BL 
.LI
Use
.I fewer
when you are referring to countable items.  For example:
.DS 1
You will find fewer errors in the latest version.
.DE
.LI
Use
.I less
when you are referring to noncountable items or
when you are discussing something in terms of size or degree.  
.DS 1
This instruction set is less complicated than the other one.
.DE
.LE
.H 2 "File Specifications"
.XX R "File types" "and initial periods"
.XX R "UNIX" "pathnames"
.XX R "Periods" "with file types"
.XX R "Pathname" "specifications"
.P
Follow these pathname guidelines.
.BL
.LI
Retain the correct case throughout the pathname.  
.DS 1
$\fBln -s /u/user1/project project\fR
.DE
.LI
Do not end pathnames with a slash (/).
.LI
Use the word
.I root
rather than a standalone slash (/) to indicate the root directory in text.  
.P 1
.I Use
.DS 1
Change to the root directory and type \fBls\fR.
.DE
.P 1
.I "Do not use"
.DS 1
Change to the / directory and type \fBls\fR.
.DE
.LI
Use initial periods when referring to conventionally used file suffixes.
.P 1
.I Use
.DS 1
File names ending with \fB.c\fR are interpreted as C source programs.
.DE
.P 1
.I "Do not use"
.DS 1
File names ending with \fBc\fR are interpreted as C source programs.
.DE
.LI
If punctuation characters such as periods appear in the filename or
pathname, set the filename off from the text when its appearance in a
sentence might be confusing.  For example:  
.DS 1
The files are in the \fB/usr/spool/uucp\fR directory and
have names beginning with the following characters:

\fBSTST.\fR
.DE
.LE
.H 2 "Footnotes"
.P
Use superscript numbers to refer to a footnote in text and tables.  
Place the number after the key word in the text or table, and use the
same number with the footnote itself.
.P
Place footnotes for text at the bottom of the page. 
Use a 1-inch overscore to separate footnotes from the text.
For example: 
.DS 1
\s-1\u1\d\s+1
Two-word key names are separated by a double underscore.
.DE
.P
Place footnotes for a table below the table.  Rule the footnotes
as part of the table to avoid confusion
with footnotes for text.  For example:
.DS "" F
.TB "Table"
.TS
center,box,tab(@);
lb | lb | lb
l | l | l.
.SP .5
Head@Head@Head
_
.SP .5
My command\u\s-31\s0\d@Does this@And this
Your command\u\s-32\s0\d@Does this@And this
Our command@Does this@And this
_
.T& 
l s s.
.SP .5
\u\s-31\s0\d This does not apply to product Z.
\u\s-32\s0\d See Appendix F for syntax.
.TE
.DE
.H 2 "Glossaries"
.P
A glossary is a list of difficult or specialized words with their 
definitions, often placed at the back of a document.  It is important to recognize how vitally important glossaries are for nonative readers and translators.  The glossary is where they find out what new terms mean.
.P
The guidelines for creating glossaries focus on three things:
planning your glossary, whether it is new or a revision;
how your glossary entries should look and read, 
depending on the word or words you are defining; and some
reference books, which you can
use to help make your glossary entries as accurate
and useful as possible.
.H 3 "Planning Your Glossary"
.br
.P
First, decide whether your document warrants a glossary at all.
.P
You need to plan your glossary, much as you plan your index, while 
you are writing or revising your document.  If your document is new, you
must decide whether terms you are including
in text are likely to require more definition than their context
gives them\(emand if they do, you must come up
with definitions that are as accurate and contextually correct
as possible.  Equally, you must decide whether the terms are
.I difficult 
or 
.IR specialized .
If they are not, they should not be included in the glossary.  Keep in mind, too, that your audience is international. 
Terms that are 
.I not 
considered to be difficult or specialized among U.S. users may
seem arcane and awkward (particularly after translation) to
users in other countries.
.P
If your document is a revision, look at the current
glossary and decide what to keep, what to
revise (and perhaps correct), what to add, and what to cut\(emon the
basis that the terms are commonly defined in other glossaries, well-defined
within the document itself, or more elementary than the audience for
the document requires.
.P
You should include your glossary entries in your index: first,
index the term where it is defined within the text of your 
document and next, index the term where it is defined in the
glossary.  It is (theoretically) a simple matter to apply an
index token to your glossary 
entries at the same time you mark them with 
.B boldface
at the introduction of the terms in text.  
.P
You may include terms in your glossary that are
.I not 
included in the text of your document.  You should not, however, fill
your glossary with all the terms you can think of.  Add terms
that are synonymous with others in your glossary, or that
are informationally tied to other terms you have presented, and
cross-reference these terms to the ones you use 
in your document.
.H 3 "Creating Your Glossary Entries (Internationalization Issues Must be Addressed)"
.br
.P
Following are guidelines\(emprimarily grammatical\(emfor creating you
glossary entries.  This list includes guidelines most pertinent
to the glossaries we create to accompany our documentation.
The rules were culled from various reference documents.
.P
When creating or revising a glossary entry, adhere to the 
following guidelines:
.BL
.LI
Alphabetizing your English glossary, or using collating order for internationalization.
.P
Arrange your glossary in alphabetical order, ignoring spaces,
punctuation, and numbers in the entry titles.  Terms of two 
or more words should be alphabetized in the order
most familiar to the people who use them. For more information
about alphabetizing, see 
.B alphabetizing
earlier in this chapter.
.P
Here are two brief, alphabetically arranged lists that illustrate
some of these principles:
.DS 1
Clock cycle		DBMS
Clocked flip-flop	DC300, DC100 cartridges
Clocking		dc signaling
Clock pulses		DDC
Clock rate		DDCMP
.DE
.LI
Capitalizing your glossary
.P
Use either the initial-cap style or case-sensitive style of
capitalization (discussed in the 
.B capitalization
section), but whichever system you follow, use it 
consistently throughout the glossary.
.DS "" F 1i 
.in 1i
.ti -\w@\fBNOTE:\ \ \fR@u
.B "NOTE:\ \ \c"
The examples in this section follow the initial-cap style.
.DE
.LI
Using descriptive phrases
.P
Following the glossary term, provide a 
.IR "descriptive phrase" .
This phrase states, or provides an initial statement of, 
the definition of the term and may be assumed to be
preceded by the phrase "[term] is defined as."  The
descriptive phrase completes the initial sentence.  The part of 
speech of the term being defined is indicated by the introductory
words in the descriptive phrase, where the word "to" indicates a
.IR verb ,
"pertaining to" indicates a 
.IR modifier , 
and other words indicate a 
.I noun 
or 
.IR "noun phrase" .
.P
Here are some examples:
.VL .5i
.LI "\fBtransmit\fR"
.br
To move data from one location to another location.
.I See
.BR Transfer .
.RI ( "verb form" )
.LI "\fBtransmission\fR"
.br
The electrical transfer of a signal, message, or other form of
intelligence from one location to another.
.RI ( "noun form" )
.LI "\fBaerodynamic\fR"
.br
Pertaining to forces acting upon any 
solid or liquid body moving relative to a gas
(especially air). 
.RI ( "modifier form" )
.LE 
.P
Other, more pertinent modifier forms are terms like 
.B hard
and 
.B soft
defined alone (as in hard or soft error). You should
have few modifier form references 
.RB ( "hard error" ,
for instance, would be included in your glossary in full, 
not just listed as 
.BR hard ).
.LI
Expanding the definition
.P
Following your descriptive phrase, you may include a brief 
amplification of your initial definition.  In 
addition, you may provide references to other terms within
your glossary.
.P
Should your entry require that you give a generic definition
before you go on to provide your specific context for the term,
give the generic definition, then say something to this effect:
.IR "In networking terms" ,
or 
.IR "From a communications point of view" .
(Come up with a phrasing more elegant than this.) Here is 
an example:
.VL .5i
.LI "\fBapplication program\fR"
.br
A program written for or by a user that applies to the user's work.
In networking terms, a program used to connect and communicate.
.I See
.BR Transfer .
.RI ( "verb form" )
.LE
.LI
Making cross-references
.P
Use 
.I See 
references for multiple word terms that have the same last word or words.
Be judicious in your use of 
.I See
references for other kinds of terms.  Use 
.I "See also"
references for terms that have 
.IR similar ,
but 
.IR "not synonymous" ,
meanings.  Following are examples of uses of the 
.I See 
and 
.I "See also"
references:
.VL .5i
.LI "\fBtransmission gain\fR"
.br
.I See
.BR gain .
.br
(In this case, the main entry is listed under \fBgain\fR.)
.LI "\fBtransmitter-receiver\fR"
.br
.I See
.BR transceiver .
.br
(In this case, the \fISee\fR reference refers to the synonymous, widely used 
version
of the term.)
.LI "\fBopen circuit\fR"
.br
\fISee also\fB closed circuit\fR.
.P
The \fISee also\fR
reference is often used to contrast opposites: the meanings
of open and closed circuit, for instance, in that they describe
two states of a circuit; however, they are not synonymous
but opposite.
.LE
.LI
Defining acronyms and abbreviations
.P
Place the definition of an acronym or abbreviation in either its
spelled-out form
or shortened form, depending on how
it is better known in the industry, and put a 
.I See
cross-reference where you list the other form.
Another rule of thumb is this: if you can 
pronounce the acronym or abbreviation ("scuzzy" 
as opposed to "S-C-S-I"), define it under
the shortened form with a cross-reference at its spelled-out form.
.VL .5i
.LI "\fBASCII\fR"
.br
Acronym for American National Standard Code for Information
Interchange...
.LE
.P
In this case, ASCII (asky), like SCSI (scuzzy) and NASA, is an
acronym that is commonly pronounced as a word.  As such, the
entry for it should follow the term ASCII, with the
spelled-out term providing a 
.I See
reference to ASCII.
.P
The definition for an abbreviation or acronym should 
.I usually
be placed with the spelled-out form for the term,
which then makes a cross-reference to the
abbreviation or acronym.  However, if the shorter form is in
.IR "common use" ,
then treat it as a pronounceable term.
.P
For example, define IEEE and SNA, which are widely known acronyms in
the industry, as primary entries, and put a 
.I See
reference at the spelled-out versions.
.LI
Citing other sources
.P
Use glossary definitions that can be found in a definitive form in the standards and other 
dictionaries.  You can include these already-written and 
approved definitions in your glossary by prefacing your glossaries 
with a reference to the sources that you use.
.P
Following is the general phrasing you should use to introduce you
glossary when in contains borrowed glossary definitions:
.DS I F \"*** I=standard indent; F=fill
This glossary contains definitions from the following sources:
the 
.IR "American National Dictionary for Information Processing Systems" ,
copyright 1982 by the Computer and Business Equipment Manufacturers 
Association; the 
.IR "IBM Dictionary of Computing" ,
Eighth Edition, 1987; and published sections of the 
.IR "ISO Vocabulary of Data Processing" .
An asterisk indicates that the definition is from the first
source, two asterisks indicate the second source, and
the label (ISO) indicates the definition is from the
last source.
.DE
.P
Here are examples of some terms and their definitions (some of the
conventions used in differing sources have been ignored in transferring
the definitions to this document).  The term
illustrated is the same; the definitions, which come from various
sources, are not.
.VL .5i
.LI "\fB*attenuation\fR"
.br
A general term used to denote a decrease in
signal magnitude in transmission
from one point to another.  Attenuation may be
expressed as a scalar ratio of the input
magnitude to the output magnitude or in decibels.
.LE
.P
The preceding example is a fairly straightforward entry.
.VL .5i
.LI "\fB**attenuation\fR"
.br
The reduction in amplitude of a 
.B signal 
when it passes through a medium
that dissipates its energy.  It is usually measured in decibels 
(attenuation then being negative while gain is 
positive).
.LE
.P
This example included a reference to another term entered in the
glossary: 
.BR signal .
.P
Use an asterisk (*) or other tag (ISO, for instance, as shown in 
the disclaimer example) to 
mark the terms that are excerpted from published 
dictionaries and glossaries other than those of OSF.
Your reference to 
.I all
of the works from which you borrowed definitions covers us 
legally.  However, be aware that if you have a very small book with a 
very large, borrowed glossary, you risk exceeding the \fIfair use\fR limitations that
allow us to use these informational bits of copyrighted text without special
permissions.
.LE
.H 3 "Going to the Source"
.br
.P
You can verify the accuracy and the global meaning of your glossary
entries in any library that has copies of the following reference works:
.BL
.LI
\fIIEEE Standard Dictionary of Electrical and Electronics Terms 
(ANSI/IEEE Standard 100-1984)\fR
.LI
\fIThe Dictionary of Computing\fR (Oxford University Press)
.LI
\fIMcGraw-Hill Dictionary of Scientific and Technical Terms\fR, 
Third Edition
.LI
\fIThe Dictionary of Computing\fR, Eighth Edition (IBM\(rg)
.LI
\fIAmerican National Dictionary for Information Processing Systems\fR
.LE
.P
You may also choose to use one or more of the definitions of
terms used in these books in your glossary.  
You may use these definitions in the following different ways:
.BL
.LI
You may use the definition verbatim, as long as you include a prefacing 
notation to your glossary that says you have 
used a definition from that source and that
the definition (or definitions, if you use more than one of them) is
marked with an asterisk or other tag that identifies the 
excerpted definition. Refer to the example in "Citing other sources" in Section 3.31.2. 
.LI
You may reword the definition.  You should only choose to reword the
definition, however, if it is substantially different in tone from
the writing style used in your document, or if the definition is not specific to 
your product or technical area of discussion.
.LE
.P
In addition to providing you with industry-standard glossary definitions,
these reference works can give you some ideas for your own 
glossaries\(emideas for cross-references that you may
not have thought about, for instance.
.H 2 "Hyphens"
.XX R "Hyphens"
.XX R "Punctuation" "hyphens"
.XX R "Dashes" "See also Hyphens"
.P
Use hyphens in the following situations:
.BL 
.LI
Hyphenate an adjectival compound if it begins with 
any of the following combining forms: 
.TS 
tab(@);
lw(1.25i) l.
.sp 4p
quasi-@quasi-official document
all-@all-inclusive code
cross-@The listing is cross-referenced.
self-@The program is self-indexing.
half-@The code is half-written
.sp 6p
.TE
.R
.LI
Do not hyphenate an adjective and
noun used as an adjective if both parts have all uppercase letters.  
.DS 1
the ANSI COBOL standard
.DE
.LI
Hyphenate an adjectival phrase when it precedes
the noun it modifies.  
.DS 1
State-of-the-art design is a major objective in the plan.
.DE
.LI
Avoid using a prefix with hyphenated or compound words.  Rewrite
the sentence without the compound term.
.TS 
tab(@);
lw(2.5i) l.
.sp 4p
non-computer-using banks@banks that do not use computers
non-file-oriented device@a device that is not file-oriented
.sp 6p
.TE
.R
.LI
Do not hyphenate an adverb-adjective compound in
which the adverb cannot be misread as a simple adjective that modifies
the noun. 
.DS 1
less frequently used utility
.DE
.LI
Do not hyphenate a compound that is made up of an adverb that ends in
.I -ly
followed by a participle or adjective.
.DS 1
a frequently used utility
a highly complex program
.DE
.XX R "Numbers" "punctuating"
.XX R "Punctuation" "of numbers"
.XX R "Hyphenation" "of numbers"
.LI
Hyphenate a fraction written as words.
.XX R "Hyphenation" "of fractions"
.XX R "Fractions" "hyphenating"
.DS 1
three-fourths
one and one-half
one-third
.DE
.LI
In tables and figures, use a hyphen to indicate a range of numbers. 
.XX R "Numbers" "in tables"
.XX R "Numbers" "in figures"
.XX R "Tables" "numbers in"
.XX R "Figures" "numbers in"
.DS 1
12-20
.DE
.LI
Use a hyphen between a number and word combined to form a unit modifier.
.DS 1
4-digit format
24-hour notation
.DE
.LI
Do not use a hyphen with the following prefixes:
.TS 
tab(@);
lw(.5i) lw(2.0i) lw(.5i) l.
.sp 4p
anti@antilogarithm@multi@multiprogramming
bi@bidirectional@non@nonexistent
co@coexist@over@overlay
dis@disassemble@pre@preassembler
extra@extracurricular@pseudo@pseudodevice
infra@infrared@re@reedit
inter@interrecord@re@resubmit
intra@intrastate@sub@subprogram
macro@macrograph@super@superset
micro@microprocessor@ultra@ultrasound
mid@midrange@un@unconditional
mis@miscalculate@@
.sp 6p
.TE
.R
.LI
If the prefix ends in the same letter as the first letter of the
root word, retain the first letter of the root word.  Do not hyphenate.  
.TS 
tab(@);
lw(1.5i) l.
.sp 4p
enter@reenter
numeric@nonnumeric
record@interrecord
ride@override
satisfied@dissatisfied
.sp 6p
.TE
.R
.P
Exceptions to this rule are the prefixes
.I anti
and
.I multi .  
These two prefixes require a hyphen when the root word
begins with an
.I i .  
.TS 
tab(@);
lw(1.5i) l.
.sp 4p
inflation@anti-inflation
integration@anti-integration
industry@multi-industry
.sp 6p
.TE
.R
.LI
Hyphenate prefixed words if the root element is all uppercase letters,
an initial capital letter, a number expressed as a figure, or if 
the root element is a hyphenated compound.
.DS 1
non-ASCII code
non-English speaking
pre-200 series
non-direct-vector
.DE
.LI
Use a hyphen if adding a prefix to a word results in a homograph 
whose meaning would otherwise be unclear. 
.TS 
tab(@);
lw(1.25i) l.
.sp 4p
re-collect@recollect
re-cover@recover
re-create@recreate
re-search@research
re-solve@resolve
re-store@restore
.sp 6p
.TE
.R
.P
However, avoid using hyphenated constructions. These can cause 
problems in translation.
.LE
.H 2 "Imperative"
.XX R "Imperative"
.XX R "Tense" "See also Imperative"
.XX R "Mood"
.P
Use the imperative to give directions. 
.DS 1
Follow the steps outlined in Section 5.1.
Enter your username and password.
.DE
.H 2 "Its"
.XX R "Its"
.P
.I Its
is the possessive pronoun of it.  Use it when you are
referring to the possessive of a third person, singular, neuter pronoun.
.DS 1
The program is very big, so its execution time is long.
Because the disk is very sensitive, its protective envelope is lead-coated.
.DE
.P
.I It's
is a contraction for 
.I "it is" .
OSF documentation avoids the use of contractions; use
.I "it is" .
.H 2 "Indexes"
.P
Editor's Note:  OSF is rewriting the guidelines for indexes to show conformance to OSF's standards.  Therefore, you can ignore the information presently contained in Sections 3.35 through 3.35.9.
.H 3 "Scheduling"
.br
.P
You should create a preliminary version of the index to include
with the beta review of a document.  This is
important because users of the document can review the index.
The users also find the beta documentation easier to use.
You do not need to make the beta index as lengthy as the final index, 
and you do not need to do final formatting of
the index.  In the case of long documents especially, we encourage
you to begin work on the index well before beta; preferably, do your
indexing as you
write or revise your document.
.P
You must complete the index and final formatting of the index for
the production edit of the document.
.H 3 "Length"
.br
.P
For small books (fewer than 150 pages), a rule of thumb is to plan to
generate a 2-column index that is 10% of the book's length; for example,
if your book is 80 pages long, your index should be around 8 pages long.
As books get longer, the length of the index moves toward 5% of the book's
length; for example, the index for a 400-page book should be
about 20 pages long.
.H 3 "Creating the Index While Writing the Document"
.br
.P
With most text formatters you can create the index during the
writing process.  This index may be a preliminary pass in the sense that you 
do not address final format issues and alphabetization issues until 
the document is complete.  Early indexing gives you an overall
view of the document and can reveal flaws in the logical
organization of the document\(emin time to correct them.
Reviewers and editors can check the draft index during
the review process, giving them a chance to 
suggest new entries or enhance current entries from
their different perspectives.  You also have more time to
develop a rich network of cross-references, be more user-oriented
in your choice of descriptive phrases, and think creatively about 
possible ways different users might approach 
a given piece of information.  It is very difficult
to address these issues with the same thoroughness and quality 
if an index is done at the end of the process.
.H 3 "What to Index"
.br
.P
Index all parts of your document including the preface, 
glossary, and appendixes.  For example, for the preface include index 
entries for the Related Documents and Typographic Conventions sections.  If
documents are listed in the Related Documents section of the
preface, include entries for each one in the index.
.P
Index the information found in  figures and tables in 
addition to indexing the title
of the figure or the table.  You can use synonyms to summarize the
information.  If the figure or table is long or contains significant 
information, index individual words, phrases, or
concepts in the figure or table.  In some cases, significant
information appears only in a table or figure or the text may only refer to the
information in a cursory or summary fashion.
.P
Index concepts as well as terms.
.P
Include entries that readers might not go to the index for but 
will use once they get there.  For example:
.DS 1
audience
cautions
instructions
notes
procedures
recommendations (for certain procedures or configurations)
.DE
.P
Include psychological (or implied) references; that is, entries you think
readers may look for when they use your index, such as alternate names
or synonyms that do not actually appear in the text.
For example, even though the term 
.B "carriage return" 
never appears in your text, include the following index entry:
.DS 1 F
Carriage return 
.I see
Return key
.DE
.P
Include terms that readers might be familiar with from other companies.
For example, we use the term link, 
while many other companies use the term bind.
.P
Include acronyms under both the abbreviation and the full term.
If the acronym is more common than the spelled-out name, the 
acronym should be the main entry.  If the
acronym is the main entry, spell out the full term
in parentheses after the acronym.
.P
Include special characters under the character (in the Symbols section at 
the beginning of the index) and also under the spelled-out name (for example, 
ampersand, backslash, asterisk).  If there are several subentries for a symbol,
let the symbol be the main entry, and provide a cross-reference at the
spelled-out name.
.P
List keywords that begin with a punctuation mark (such as %include) in 
alphabetical order; for example, put %include among\(emnot at the 
beginning of\(emthe i words (that is, where include would go, if the % was
not there) and also under Symbols.
.P
Do not include trivial passing references as entries in the index.
.H 3 "Format"
.br
.P
Use bold alphabetic separators; for example, A, B, C, D. 
.P
Arrange entries and subentries alphabetically.
.P
Make sure that the first word is the most important.
.P
Use boldface for the page number, showing the primary
discussion for an entry (optional).
.P
Use boldface for literals that appear in the index.  However, if the index has
many bold entries, the editor and writer should print out sample pages
to see if individual pages are dominated by bold entries.
They can then make a judgment not to 
use bold for literals in the index.  If they make this decision, then it
should apply to all parts of the index; that is, all literals must then be in 
regular typeface.
.P
Do not use f (following page), or ff (following folio) to indicate
entries that span a range of pages; spell out 
.B to
(as in 3-3 to 3-14) rather than use an em dash.
.P
Capitalize entries as you normally use them.  For example, capitalize acronyms
and the first letter of proper nouns; do not capitalize command names
or ordinary words.
.P
Merge closely related entries together.  Use the plural form of the
noun if you have an entry under both the
singular and the plural.  In most indexes, the merging
of related entries is the most common kind of clean-up work
that must be done.
.P
Do 
.I not
do the following:
.DS 1
metafile, 3-2
metafiles, 6-5
.DE
.P 
Do the following:
.DS 1
metafiles, 3-2, 6-5
.DE
.P
Use a task-oriented entry, usually a participle, to merge related entries,
if this seems appropriate.
.P
Do 
.I not
do the following:
.DS 1
file, copies, 2-10
file, copy, 4-9
files, copying, 7-5
.DE
.P 
Do the following:
.DS 1
files, copying, 2-10, 4-9, 7-5
.DE
.P 
If you examine apparently related entries and feel that there is a 
legitimate reason not to merge, then do not.
.H 3 "Subentries"
.br
.P
Keep subentries as short as possible.
.P
Do not use more than three levels of entries.  For example, 
.DS 1
Creating
    processes, 4-4
        without pads and windows, 4-7
.DE
.P
Create subheadings when an entry lists more than five page
references.  For example, change the following entry:
.DS 1
messages, 4-14, 4-16, 5-21, 5-23, 6-17, 6-19
.DE
.P
to read as follows:
.DS 1
messages
    file not found, 6-19
    file in use, 6-17
    object not found, 4-16
    request to quit edit, 5-23
    searching for text, 5-21
    substitute in progress, 4-14
.DE
.H 3 "Cross-references"
.br
.P
Be sure that a 
.I "see also"
reference leads to additional information and not the
same information under a different heading.
.P
.I See
and 
.I "see also"
should appear in italics.
.P
.I "See also"
references should be an entry's final subheading.
.H 3 "Creating Balance"
.br
.P
Try to have a balance of entries in the index, 
throughout the list of topics. Try to avoid having a lot
of entries referring to the first few pages of the document and
then few on the last pages, because time constraints did not
allow you to index the last section as thoroughly as the first
section.  Here are some suggestions for creating balance:
.BL
.LI
Try creating the index from the first and last chapters, 
working in toward the center of the document.
.LI
Make one quick pass through the document, before doing the
in-depth work on the index.  During the quick pass, appraise
the selection of keywords, bold words, headings, paragraphs,
and topic sentences.  Also take note of any synonyms or 
cross-references that occur to you as you are going 
through the chapters.
This quick pass through the document can be the index for
the beta version of the manual.
.LI
Use a formula like the following for either the quick pass or
the final pass of creating an index.
.AL
.LI
Determine how much actual working time you have.
.LI
Divide the time period into two equal periods.
.LI
Use the first time period to enter in index entries.
.LI
Use the second time period to work on synonyms, 
merging related entries, cross-references, the
organization of the index, and so on.  Check for
areas of the document that may be under-indexed.
.LE
.LI
When entering index entries, use a formula like the following:
Find out the maximum amount of the time you can spend on each
page by dividing the length of the time period (for indexing)
by the total number of pages to be indexed.  This gives
you the amount of time you can spend creating entries for each
page.
.LE
.H 3 "Alphabetic Order"
.br
.P
After you have constructed your index, check the alphabetic order
of the entries.  The alphabetic order of most your index should be
correct; however, different indexing programs may alphabetize
differently.
.P
Our preferred method of alphabetizing in an index is letter-by-letter,
but you may alphabetize word-by-word if this is the method that
your indexing tool uses.  Use the same method (letter-by-letter 
or word-by-word) consistently within an index.
.BL
.LI
Make sure that capitalized entries are properly merged in with
other entries, and not, for instance, placed at the beginning of
a section.
.P
Do
.I not
do the following:
.DS 1
PHIGS, 2-1
PostScript, 3-3
packet interface, 5-1, 4-14
polymarker attributes, 4-8
.DE
.P
Do the following:
.DS 1
packet interface, 5-1, 4-14
PHIGS, 2-1
polymarker attributes, 4-8
PostScript, 3-3
.DE
.LI
Alphabetize index entries based on the first significant word.  
Do not alphabetize based on qualifying words or phrases such as
"and," "of," and "using."
.P
Do
.I not
do the following:
.DS 1
efficiency
    and built-in routines, 6-37
    and prototypes, 5-17
    of include files, 5-17
    register variables, 3-56
    using macros for, 4-70
.DE
.P
Do the following:
.DS 1
efficiency
    and built-in routines, 6-37
    of include files, 5-17
    using macros for, 4-70
    and prototypes, 5-17
    register variables, 3-56
.DE
.LI
Use letter-by-letter alphabetization (preferred)
or word-by-word alphabetization (if that is all your 
formatting tool generates) consistently throughout the index.
.P
Letter-by-letter approach:
.DS 1
database, 6-19
data formatting, 1-1
datatypes, 2-3
data undo command, 2-14
.DE
.P
Word-by-word approach:
.DS 1
data formatting, 1-1
data undo command, 2-14
database, 6-19
datatypes, 2-3
.DE
.LE
.P
See Section 18.92 of 
.I "The Chicago Manual of Style"
for a discussion of the letter-by-letter approach versus
the word-by-word approach.
.H 2 "Keyboards"
.\" 
.\" ***PIP Rev. B***
.\" 
.XX R "Keyboards"
.XX R "Translation considerations" "keyboards"
.P
A variety of keyboards are in use around the world. Functions 
bound to particular keys in the U.S. version of a product may be bound to
entirely different keys for products that
are localized for other countries.  Follow these guidelines when
documenting keyboards:
.BL 
.LI
Select a default keyboard to document, and develop a method for
providing information about alternative keyboards.
.LI
Put as much keyboard information online as possible.  It is easier
to modify keyboard information that is presented online than it is to
modify hard-copy information.
.LI
Use
.I "function names"
rather than
.I "key cap names"
in documenting software applications.
.LE
.H 2 "Keys"
.XX R "Keys"
.P
Follow these guidelines when referring to keys on the keyboard: 
.BL 
.LI
Always use the verb
.I press
when referring to keys. Do not use the verbs
.I strike ,
.I punch ,
.I depress , 
or
.I hit .
.LI
Always refer to keys on the keyboard as
.I keys ,
never as 
.I buttons .
.LI
Do not use the name of a key as an adjective if the name appears on the
keyboard.
.P 1
.I Use
.DS 1
Press \fB<Return>\fR.
.DE
.P 1
.I "Do not use"
.DS 1
Press the \fBReturn\fR key.
.DE
.LI
Use initial capital letters for the name of a key if the key is labeled on 
the keyboard. 
.DS 1
\fB<Delete>
<Return>
<Shift>
<Tab>\fR
.DE
.LI
Use lowercase letters when the key to which you are referring is 
.I not
labeled on the keyboard. 
.DS 1
space bar
comma key
period key
up arrow key
slash key
.DE
.LI
Use
.I x
to refer to a generic letter key; use 
.I n
to refer to a generic number key.
.LI
You can refer to keys in text in two ways: by enclosing the
name of the key in angle brackets (for example, \fB<Return>\fR)
or by placing the name of the key in a phrase (for example, 
the \fBReturn\fR key).
.DS "" F 1i 
.in 1i
.ti -\w@\fBNOTE:\ \ \fR@u
.B "NOTE:\ \ \c"
The angle brackets replace the word key; do not write
"the \fB<Return>\fR key."
.DE
.P
In running text, you may find that it is clearer to use 
"the ___ key," for example, 
.DS 1
The Shell key creates a new shell process.
.DE
.P
In command lines and tables, it is probably clearer to use the
angle bracket convention.
.LI
To indicate a sequence such as \fB<Ctrl-x>\fR, in which you must hold down the
control key while you press another key or a mouse button, use
a slash between the two key names.
.LI
Use a dash between the key names when you want the use to press keys
simultaneously.  For example, \fB<Ctrl-c>\fR indicates that the user holds
down \fB<Ctrl>\fR while pressing \fB<c>\fR.
.LI
In text, when you want the user to press two keys sequentially, write the
text to say so.
.DS 1
Press and release the \fBF1\fR key, and then press the \fBW\fR key.
.DE
.P
In command lines and tables, use the angle bracket convention:
.DS 1
Press \fB<F1>\fR and \fB<W>\fR.
.DE
.LE
.H 2 "Latin Expressions"
.XX R "Latin expressions"
.P
Do not use Latin expressions in technical documentation.
.I Versus ,
.I "vice versa" ,
.I per , 
and
.I via
are the only exceptions; they are commonly used in
technical documentation.  In general, substitute one of the 
corresponding English translations:
.XX R "ca" "See About"
.XX R "circa" "See About"
.XX R "cf." "See Compare"
.XX R "e.g." "See For example"
.XX R "et al." "See And others"
.XX R "etc." "See And so forth"
.XX R "i.e." "See That is"
.XX R "versus"
.XX R "via"
.XX R "vice versa"
.XX R "viz." "See Namely"
.TS H 
center,box,tab(@);
lb | lb
lw(1.5i) | l.
.sp 4p
Latin@English
.sp 4p
_
.sp 4p
.TH
ca, circa@About
cf.@Compare
e.g.@For example
et al.@And others
etc.@And so forth, and so on
i.e.@That is
viz.@Namely
.sp 6p
.TE
.R
.H 2 "Lists"
.br
.P
Begin the first word of each item (bulleted or enumerated) with a 
capital letter.
.P
Use 1. instead of 1.) in enumerated lists.
.P
Omit all ending punctuation (see Example A) unless an item is a complete
sentence.  If one item requires ending punctuation, then all
items should use ending punctuation (even if they are not
complete sentences\(emsee Example B).
.P
When introducing a list, do not use 
a colon to introduce a list that is a complement of the
introductory statement, as in Example B (in other words, do not put a colon
between a verb and its complement or object, or between a
preposition and its object). Do use a colon
when introducing a list by the words the following or 
as follows (see Example A).
.P
If you have to include sublistings to items in bulleted lists, 
start each sublisting with an em dash (see Example C.)
.P
If you include sublistings to items in enumerated lists,
number the sublistings alphabetically; do not use
bullets with an enumerated list (see Example D).
.P
If a list clearly indicates a sequence (for example, a
series of steps in a procedure) or a hierarchy, 
use an enumerated list (see Example D).  Otherwise, use
bulleted lists.
.P
.B "Example A: Bulleted List With No Periods, Introduced With a Colon
.P
The graphics primitives include the following capabilities:
.BL
.LI
Drawing lines, circles, and rectangles
.LI
Loading text fonts and manipulating text
.LI
Filling polygon areas
.LI
Setting attributes
.LI
Storing bitmaps externally
.LE
.P
.B "Example B: Bulleted List With Periods, Introduced Without a Colon
.P
For the application, OSF/1 enables you to 
.BL
.LI
Write less code.  Because OSF/1 handles interactions with the
user, the application designer does not have to provide the code for 
doing so.
.LI
Achieve a modular approach to writing code that promotes phased and
iterative application development independent of user-interface
development.
.LE
.P
.B "Example C: Bulleted List With Sublist, Introduced Without a Colon"
.P
The product lets you
.BL
.LI
Do this, which consists of 
.DL
.LI
This thing
.LI
This other thing
.LE
.LI
Do this
.LE
.P
.B "Example D: Enumerated List With Periods and Sublist, Introduced With a Colon"
.P
Perform these steps to move the printer:
.AL
.LI
Shut down the  workstation.
.LI
Turn off the printer.
.AL a
.LI
Press the OFFLINE switch to place the printer off line.
.LI
Set the power switch to the off position.
.LE
.LI
Unplug the workstation.
.LE
.H 2 "Measurements"
.XX R "Measurements"
.XX R "Translation considerations" "measurements"
.XX R "Height" "specifying"
.XX R "Weight" "specifying"
.XX R "Length" "specifying"
.XX R "Width" "specifying"
.XX R "Metric units"
.XX R "Precision" "in measurement"
.\" 
.\" ***PIP Rev. B***
.\" 
.P
.\"Software manuals often provide measurement information concerning bits,
.\"bytes, characters, lines, records, and blocks.  
.\"Hardware manuals, installation guides, and site set-up guides often provide
.\"information on height, length, width, and weight of products.  
Provide measurements in metric units and unit symbols.  When specifying product
requirements, use the following rules:
.BL 
.LI
Use the metric units first, followed by the U.S. equivalent in
parentheses.
.LI
Comment the source file indicating which units of measurement are
used.  That way, if the document is translated, the translator knows
which units of measurement were used.
.LI
Make sure that the precision of a converted measurement reflects the
precision of the original measurement. 
.DS 1
The data is from a body scan that is 3.05 meters (10.00 feet).
.DE
.LE
.P
See also
.B numbers .
.H 2 "Money"
.XX R "Money"
.XX R "Monetary values"
.XX R "Translation considerations" "money"
.\" 
.\" ***PIP Rev. B***
.\" 
.P
Monetary values are country-specific information.
.BL 
.LI
Avoid reference to monetary values of products or services in user
documents.
.LI
If you use monetary values in examples, include a comment in the source file
indicating the purpose of the example.  That way, if the document is
translated, the translator can design an appropriate example using local
currency.
.LE
.H 2 "Mouse"
.XX R "Mouse"
.XX R "Puck"
.XX R "Stylus"
.XX R "Pointing device"
.XX R "DECwindows" "mouse"
.XX R "Online" "mouse"
.P
Use the following guidelines in when refering to pointing devices, screen
buttons, and menu operations:
.BL 
.LI
You can use the term
.I mouse
to refer to any pointing device, such as graphic tablets, joy sticks, track balls, or special sets of graphics navigation keys. 
\".I mouse ,
\".I puck , 
\"or
\".I stylus .
.LI
If you use the term
.I mouse 
to refer to a 
.\".I puck
.\"or
.\".I stylus ,
one of the preceding devices,
you must define the usage in your document.
.LI
Always refer to a button on your pointing device as a
.I "mouse button" ,
.I "puck button" , 
or 
.I "stylus button" .
Avoid the generic 
.I button .
If it does not matter what pointing 
device is used, current documentation uses
.I "mouse button"
as the generic term.
.DL
.\".LI
.\"You can also use
.\".I MB1 ,
.\".I MB2 , 
.\"and
.\".I MB3
.\"for mouse buttons.
.\".LI
.\"You can also use
.\".I PB1 ,
.\".I PB2 ,
.\".I PB3 , 
.\"and
.\".I PB4
.\"for buttons on a puck.
.\".LI
.\"You can also use
.\".I SB1
.\"and
.\".I SB2
.\"for buttons on a stylus.
.LE
.LI
Always refer to a button on the screen as a
.I "screen button" ,
unless you are specifying a particular screen button.  
.DS 1
Click on the OK button.
Use your mouse to click on any screen buttons.
.DE
.LI
Use the verbs
.I click ,
.I "double-click" ,
.I drag ,
.I press ,
.I press
and
.I hold , 
and
.I release
when referring to mouse buttons. 
.DS 1
To move from one Calendar display to another, double-click
on the appropriate item in the current display.

Click on the OK button.
.DE
.LI
Use the verb
.I choose
when you refer to picking an operation from a menu.  
.DS 1
Choose Save from the File menu.
.DE
.LI
Use the verb
.I select
to designate information that will be
the object of a subsequent operation or operations. 
.DS 1
Select the text that you want to copy.
.DE
.LI
Use the verb
.I "click on"
when you refer to controls on the screen.  
.DS 1
Click on the help icon.
.DE
.LE 
.H 2 "\fIin, x\fR"
.P
Use the following guidelines for variable letters and numbers:
.XX R "Generic letters
.XX R "Letters" "generic"
.XX R "Numbers" "generic"
.XX R "Generic numbers"
.BL 
.LI
Use a lowercase, italicized
.I x
to represent a variable letter. 
.DS 1
The \fBsearch\fR \fIx\fP function searches the options for \fIx\fP, 
where \fIx\fP is the letter of the option you are selecting.
.DE
.LI
Use a lowercase, italicized
.I n
to represent a variable number.
.DS 1
At the menu prompt, type in a number from 1 to \fIn\fP, 
where \fIn\fP is the highest number on the menu you are using.
.DE
.LE
.H 2 "Names in Text"
.XX R "Names" "in text"
.P
Vary your use of names in documentation.  Use non-Anglo-Saxon names (such as
Akio Asada, Juanita Sanchez, Pat McCoy, Yehuda Goldman, Kim Tae Woh, and Antonia Siracuso)
as well as Anglo-Saxon names, and female names as well as
male names.  Look through a telephone directory for ideas.
.H 2 "Nodes in Text"
.XX R "Nodes" "in text"
.P
For security information, never include names of actual system accounts and
passwords in documentation.  
It is not a security problem to use the names of real systems or
nodes.  Remember to edit node and user information out of screen-captured
material.
.H 2 "Numbers"
.P
Follow these guidelines for using and punctuating numbers.
.XX R "Decimals"
.XX R "Numbers" "with decimals"
.XX R "Numbers" "using in text"
.XX R "Numbers" "written as figures"
.BL 
.LI
Do not use commas in binary, octal, hexadecimal, or 4-digital decimal
numbers.
.P 1
.I Use
.DS 1
0001111010101110
4000
.DE
.LI
'B "Express numbers as figures (numerals) in text in the following cases" :
.DL
.LI
If the number is 10 or more and does not begin a sentence.
.DS 1
This system supports 10 peripheral devices.
This program reports 15 system errors.
.DE
.LI
In a group of two or more numbers within a sentence when at least one of 
the numbers is 10 or more. 
.DS 1
3 nodes, 7 directories, and 15 files 
.DE
.LI
With units of measurement and time. 
.XX R "Units of measurement and time"
.DS 1
3 bytes
24 hours
4 characters
16 weeks
.DE
.LI
For memory descriptions.  
.DS 1
1 gigabyte = 1 GB
512-MB memory space
256KB
.DE
.LI
For a decimal, even if it is less than 10. 
.DS 1
5.5%
.DE
.LI
To identify objects by number. 
.DS 1
a value of 0
a value of 1
steps 3 and 4
bits 0 and 1
column 1
register 1
.DE
.LI
In a unit modifier. 
.DS 1
1/2-inch diameter
8-bit bytes
.DE
.LI
If the number precedes an abbreviation or symbol. 
.XX R "Abbreviations" "with numbers"
.XX R "Numbers" "with abbreviations"
.DS 1
8%
2 lb  
.DE
.LI
Rewrite sentences that include a spelled-out hyphenated number so that it
can be used as a numeral.  If the number does not include a hyphen, you may
spell it out.
.P 1
.I Use
.DS 1
The LAN operates with a maximum of 21 terminals.
Twenty people attended the meeting.
There were 20 people at the meeting.
.DE
.P 1
.I "Do not use"
.DS 1
Twenty-one terminals is the maximum allowed on the LAN.
.DE
.LE
.XX R "Numbers" "using as words"
.LI
'B "Write numbers as words in the following cases" :
.DL
.LI
If the number is the first element of a sentence or heading or closely
follows another number that is the first element of a sentence or heading. For
example:
.DS 1
Twelve terminals can operate at the same time.

Ten or twenty characters disappeared from the file.
.DE
.LI
If the number precedes a unit modifier that contains a number expressed as
a figure and if the number is less than 100.  
.DS 1
Three longwords contain twelve 8-bit bytes.
.DE
.P 1
.I But
.DS 1
A block contains 512 8-bit bytes.
.DE
.LI
If the number is used in expressions of complement. 
.DS 1
The program calculates the two's complement of the number.
.DE
.LI
If the number is a
.I one
or
.I zero
bit setting.
.LI
If the number is
.I zero , 
unless the information is in a table,
you are giving a range of numbers, or you are giving a specific value.  For
example:
.DS 1
This will indicate a zero to the counter.
Single byte transfers always occur on data lines 0 to 7; word transfers use data lines 0 to 15.
Supply a 0 as the third argument.
.DE
.LE
.XX R "Numbers" "forming plurals of"
.XX R "Forming plurals" "of numbers"
.LI
'B "Form the plural of a number written as a figure by adding a lowercase"
.I s .
.DS 1
4s
10s
1920s
10,000s
.DE
.XX R "Numbers" "punctuating
.XX R "Punctuation" "of numbers"
.LI
'B "Use the following guidelines when punctuating numbers" :
.DL
.LI
Use a comma in a whole decimal number that contains five or more digits.
.DS 1
  9000
10,000
.DE
.LI
Hyphenate unit modifiers.
.DS 1
512-MB memory space
8-bit data transfers
\"6-character file name 
.DE
.LI
Hyphenate a fraction written as a word. 
.DS 1
three-fourths
.DE
.LI
Insert one space between a number and the abbreviation or unit symbol it 
modifies, as a general rule.  
.\"Hyphenate when used as a unit modifier.
.TS 
tab(@);
nw(1.0i) n.
.sp 4p
4 ft@250 Btu
3 mm@6 kHz
6758 A
\"@512-MB memory space
.sp 6p
.TE
.R
.P
Exceptions are as follows:
.TS 
tab(@);
lw(2.25i) l
lw(2.25i) l
l s
l s.
.sp 4p
binary thousand (64K)@degrees centigrade (20\(deC)
percent (9%)@degrees Fahrenheit (85\(deF)
degrees Kelvin (5K)
degrees, minutes, and seconds of an angle; and multiples of bytes.
.sp 6p
.TE
.R
.LE
.XX R "Numbers" "ranges of"
.XX R "Ranges of numbers"
.LI
.B "Use the following guidelines when handling numbers that span a range" :
.DL
.LI
Use the word
.I to 
rather than 
.I through
for inclusive
ranges of numbers written as words or figures and for numbers in a range that
are part of a modifier containing a hyphen.
.DS 1
Enter one to three bytes.
Enter a 1-byte to 6-byte string.
.DE
.LI
In tables and figures, use a dash to indicate a range of numbers.  
.XX R "Numbers" "in tables"
.XX R "Numbers" "in figures"
.XX R "Tables" "numbers in"
.XX R "Figures" "numbers in"
.DS 1
12-20
.DE
.LI
If a series has more than two items, place the abbreviation
or symbol for a unit of measurement at the end of the series.  
.DS 1
1200, 1400, or 1600MHz
.DE
.P 
If a series has only two items, repeat the abbreviation or symbol 
for a unit of measurement. 
.XX R "Abbreviations" "in a series"
.XX R "Symbols" "in a series"
.DS 1
10% to 50%
.DE
.LI
Use full years in ranges, not partial years. 
.P 1
.I Use
.DS 1
1980 to 1989
.DE
.P 1
.I "Do not use"
.DS 1
1980-89 (or 1980 to 89)
.DE
.LE
.LI
'B "Follow these guidelines when using decimals" :
.DL
.LI
Write decimal numbers of less than 1 with a zero preceding the decimal
point.
.DS 1
0.25
.DE
.LI
Emphasize exact measurement by following a whole number with a decimal
point and a zero.  Otherwise, omit the decimal point and the zero. For
example:
.DS 1
3.0 feet long
approximately 3 feet long
.DE
.LI
In lists, maintain consistency in decimal precision.  Add one or more
trailing zeros, if necessary, to achieve consistency.
.LI
Align columns of numbers containing decimal points
on the decimal point.  For example: 
\"right-justify all other columns of numbers. For example:
.DS F
.TS 
center,box,tab(@);
lb |lb |lb
l | n | c.
Air Flow Clearance@Centimeters@Inches
_
Front@15.2@6.0
Rear@30.5
Sides@15.2@6.0
.TE
.DE
.LI 
Right-justify columns of numbers.  For example:
.DS F
.TS  
center,box,tab(@);
lb |lb
n |n.
Units Sold@Unit Price
_
500@$0.50
27@$4.75
1@$0.33
.TE
.DE
.\".TS H 
.\"tab(@);
.\"lfB lfB
.\"nw(3.0i) n.
.\"_
\".sp 4p
.\"Units Sold@Unit Price
.\".sp 4p
.\"_
.\".sp 4p
.\".TH
.\"500@$0.50
.\"27@$4.75
.\"1@$0.33
.\".sp 6p
.\"_
.\".TE
.\".R
.LI
Do not use a decimal point as a radix indicator in text.
.LE
.LI
'B "Follow these guidelines when writing fractions" :
.DL
.LI
Write a fraction as a figure when it is attached to other figures.
.XX R "Fractions" "as figures"
.DS 1
1 1/2
.DE
.LI
Write a fraction as a figure when it is in a series of numbers written
as figures. 
.DS 1
1, 7, 3/4, 8
.DE
.LI
Write a fraction as a figure when it is part of a unit of measure used
as a modifier. 
.DS 1
1/2-inch margins
.DE
.LI
Hyphenate a fraction written as words. 
.XX R "Hyphenation" "of fractions"
.XX R "Fractions" "hyphenating"
.DS 1
three-fourths
one and one-half
one-third
.DE
.LE
.XX R "Radix indicators"
.XX R "Base indicators"
.LI
'B "Follow these guidelines when using radix indicators" :
.DL
.LI
Indicate the radix of a number expressed as a figure by subscript (2, 8,
10, or 16) if you have the production capability to do so. For example: 
.DS 1
.EQ
23 sub 10
.EN
.DE
.LI
If you do not have the production capability to use subscripts, write the 
radix as a numeral enclosed in parentheses.
.DS 1
23(10)
.DE
.LI
If the radix is in parentheses, separate the number and its radix 
with a space.
.LI
Do not use a decimal point as a radix indicator in text.
.EQ
delim ##
.EN
.LI
If the radix of a number is part of a compound modifier, hyphenate it.
For example: 30(decimal)-byte buffer or #30 sub 10 #-byte buffer.
.EQ
delim off
.EN
.\".LI
.\"'B "Follow these guidelines for specifying tolerances" :
.\".DL
.\".LI
.\"There should 
.\".I not 
.\"be any space between the + - signs and the value.
.\".DS 1
.\"+10%, -15%
.\"+10%, -10%
.\"\(+-10%
.\".DE
.\".LI
.\"The tolerances should be enclosed in parentheses with a space preceding the
.\"open parenthesis.
.\".DS 1
.\"115 V ac (+15%, -21%)
.\"240 V ac (+10%, -25%)
.\"50 to 60 Hz (\(+-3 Hz)
.\".DE
.LE
.LE
.P
See also
.B measurements .
.\".H 2 "Order Numbers"
.\" 
.\" ***PIP Rev. B***
.\" 
.XX R "Part numbers"
.XX R "Order numbers"
.XX R "Translation considerations" "order numbers"
.P
.\"Most documents provide information on related documentation.  When order
.\"numbers are provided as part of this information, the order numbers may
.\"apply to one country or market only.  This can cause problems when
.\"readers want to order translated versions of the documentation for a
.\"product. Readers tend to assume that order numbers supplied in a
.\"document apply worldwide. 
.\".BL 
.\".LI
.\"Avoid including order information in documentation whenever possible.
.\".LI
.\"Do not include document order numbers in related documentation lists.
.\"Instead, provide them separately (so that they can be easily changed for
.\"other countries).
.\".LI
.\"Place material containing this information in an
.\"appendix.  Prepare for this in your documentation plan.
.\".LI
.\"Advise the user of any documents that are available in multiple languages.
.\".LE
.H 2 "Periods"
.XX R "Periods" "rules for using"
.XX R "Punctuation" "periods"
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
.B lists
for information on using a period to punctuate list items.
.H 2 "Plurals"
.XX R "Plurals"
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
.XX R "Numbers" "forming plurals"
.XX R "Forming plurals"
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
.XX R "Data" "with a singular verb"
.XX R "Datum" "use data"
.LI
Use
.I data
with a singular verb form; do not use the term
.I datum
at all.  For example:
.DS 1
The data is transferred along parallel lines.
.DE
.XX R "Media" "with a singular verb"
.LI
Use 
.I media
with a singular verb.  For example:
.DS 1
The media is shipped separately from the documentation.
.DE
.LE
.H 2 "Pronouns"
.XX R "Pronouns"
.XX R "Gender neutrality" "avoiding ambiguous pronouns"
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
.XX R "Command qualifiers"
.XX R "Qualifiers"
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
.H 2 "Quotation Marks"
.XX R "Quotation marks" "with direct quotation"
.XX R "Quotation marks" "with literal response"
.XX R "Quotation marks" "with literal code"
.XX R "Punctuation" "quotation marks"
.P
Follow these guidelines for quotation marks:
.BL 
.LI
Use quotation marks to indicate a direct quotation or literal response or
piece of code within text.  
.DS 1
The system displays the error "DBM-%Database not ready"
if you have not readied the database before fetching a record.
.DE
.XX R "Quotation marks" "with technical term"
.LI
Use quotation marks to enclose standard technical terms that
are used in a nonstandard way.
.XX R "Quotation marks" "with unnumbered section titles"
.LI
Use quotation marks in describing section titles that are unnumbered.
.LI
Do not use quotation marks to lend emphasis to a word or phrase.  
.XX R "Quotation marks" "within interactive examples"
.LI
Do not put quotation marks around command names, filenames, user
responses, or syntax. You can, however, use quotation marks within interactive
examples.  For example:
.DS 1
Notes> SET PROFILE/PERSONAL_NAME="John Q. Noter"
.DE
.LE
.H 2 "Screen Objects"
.XX R "Screen objects"
.XX R "Online" "screen objects" 
.XX R "DECwindows" "screen objects"
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
.XX R "Semicolons"
.XX R "Punctuation" "semicolons"
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
.XX R "Symbols" "how to write"
.P
Follow these guidelines when you use symbols:
.BL 
.LI
Write out the name of the symbol in text and enclose the symbol in
parentheses.  You may use the symbol in tables and code examples to
conserve space.  
.XX R "Symbols" "in tables"
.XX R "Symbols" "in code examples"
.DS 1
The \|$\| (dollar sign) is the default prompt.
.DE
.\"\fBException:\fR OSF manpages show the symbol first and then enclose 
.\"the name of the symbols in parentheses. 
.LI
If there are only two items in a series, repeat the
symbol for a unit of measurement. 
.XX R "Abbreviations" "in series"
.XX R "Symbols" "in series"
.DS 1
10% to 50%
.DE
.LI
If there are more than two items in a series, place the symbol for a
unit of measurement at the end of the series.
.DS 1
12, 14, or 16 ft
.DE
.XX R "Symbols" "to pluralize"
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
.\"For more information on symbols, see Chapter 5.
.H 2 "Tense"
.XX R "Tense" "present"
.P
Use the present tense of verbs whenever possible.
.P 1
.I Use
.DS 1
If you make an error, the program prints an error message.
.DE
.P 1
.I "Do not use"
.DS 1
If you have made an error, the program prints an error message.
If you make an error, the program will print an error message.
.DE
.H 2 "That and Which"
.P
Use
.I that
for a restrictive clause.  A restrictive clause is
essential to the meaning of the sentence.
.DS 1
Chapter 2 explains the considerations that affect good schema design.
.DE
.P
Use
.I which
for a nonrestrictive clause.  A nonrestrictive clause
is set off by commas and provides additional information that is not
essential to the meaning of the sentence.
.DS 1
One feature is the schema, which specifies the logical definition of the database.
.DE
.H 2 "Time"
.\" 
.\" ***PIP Rev. B***
.\" 
.XX R "Time" "of day"
.XX R "Translation considerations" "time"
.P
Use the following guidelines when referring to time in documentation:
.BL 
.LI
The abbreviations a.m. and p.m. refer to specific time only.
.P 1
.I Use
.DS 1
The meeting is at 3:00 p.m.
.DE
.P 1
.I "Do not use"
.DS 1
The meeting is in the p.m.
.DE
.LI
If you use the words
.I o'clock , 
.I noon ,
or
.I midnight ,
spell out the time. 
.DS 1
The meeting is at three o'clock.
The train arrived at twelve noon.
.DE
.LI
If you use military time (24-hour format), use a number in the
.I nnnn
format followed by the word hours.
.DS 1
The meeting is at 1500 hours.
.DE
.LE
.H 2 "Time Zones"
.\" 
.\" ***PIP Rev. B***
.\" 
.XX R "Time" "zones"
.XX R "Translation considerations" "time zones"
.P
Use the following guidelines in referring to time zones:
.BL 
.LI
Spell
.I "time zone"
as two words.
.LI
For text or displays that indicate the time zone, use either the full name
of the time zone (for example, Central European Time or Eastern Standard
Time) or the degree of variance from Greenwich Mean Time (for example, for
Austria, Greenwich Mean Time plus 1 hour).
.LI
Do not use the mnemonic codes (for example, CET, PST, EST); the codes
are often ambiguous, and no formal international agreement on the
value of these codes exists.
.LI
Do not make reference to the date on which users change to or from 
Daylight Saving Time.  Such dates differ depending on the country.
.LE
.H 2 "Trademarks"
.XX R "Trademarks" "OSF"
.XX R "OSF" "trademarks"
.XX R "Adjectives" "trademarks as"
.XX R "Nouns" "trademarks as"
.XX R "Verbs" "trademarks as"
.\" 
.\" ***PIP Rev. B***
.\" 
.P
Trademarks are names, symbols, or other devices that identify
products that are legally restricted to the use of the owner or
manufacturer.
.ig ++
.BL 
.LI
Write all trademarks of Digital and other firms exactly 
as they are registered. 
.LI
Use a trademark as an adjective, not as a noun or verb. For example, do 
not refer to a product as a VAX, but rather as a VAX computer. 
.LI
Do not form possessives with trademarked names.
.P 1
.I Use
.DS 1
The VAX instruction set is quite complicated.
.DE
.P 1
.I "Do not use"
.DS 1
VAX's instruction set is quite complicated.
The VAX's instruction set is quite complicated.
.DE
.LI
Always use
.I Digital
or
.I "Digital Equipment Corporation"
in documentation when referring to the company. Use
.I DEC
only as a formative trademark.  For example:
.DS 1
DECwrite
DECforms
.DE 
.LI
You must list all trademarks in a book on the copyright
page. List them alphabetically in table format, and include the
Digital Logo at the end.
.LI
List third-party trademarks on the copyright page.
List them alphabetically in table format, below the
Digital trademark list. See the
.I "Trademark Handbook for Digital Employees: Third-Party Trademarks List" .
.LI
You can use a trademark in a hyphenated expression.  
.DS 1
ULTRIX-based system
.DE
.LE
.P
For more information, see the
.I "Trademark Handbook for Digital Employees" . 
.++
.P
The following guidelines apply to all trademarks, whether they belong
to OSF or to other companies, and all documentation, including internal
documentation.  These guidelines are consistent with those
published by the United States Trademark Association.
.BL
.LI
Acknowledge ownership of the trademark.
.LI
Spell and capitalize the trademark correctly (even if 
it is an unusual spelling).
.LI
Always use a trademark or registered trademark as an
adjective.  The noun that the trademark modifies does not 
always have to be the same noun and it does not have
to begin with a capital letter.
.LI
Do not use a trademark as a possessive. (Since a trademark is 
not a noun, it cannot have a possessive form.) According to
common usage, this guideline is relaxed for our own company's
name (OSF's name only, 
.I not 
the names of other companies).
.LI
Do not pluralize a trademark.  (Since a trademark is not a noun,
it cannot have a plural form.)
.LI
Do not use a trademark as part of a hyphenated compound.  This
guideline is relaxed for our own company's name (for OSF-specific uses
only, not names of other companies).
.LE
.H 3 "Using OSF Trademarks"
.br
Use the following guidelines for OSF trademarks:
.BL
.LI
Use the \(rg or \(tm symbol the first time you use one of the OSF
trademarks or registered trademarks in text.
.LI
Legal wants to determine on a case-by-case basis whether or not
to use the appropriate symbol in titles.  Do
.I not
use it unless Legal asks you to.
.LI
List all OSF trademarks on the copyright page in 
alphabetic order.
.LE
.H 3 "Using Other Companies' Trademarks"
.br
.P
It is OSF's policy to acknowledge the trademarks of
other companies.  We are going to develop a comprehensive
list of trademarks for everyone to reference. The list 
will give the correct spelling of the trademark, the 
trademark holder, and indicate whether it is a
trademark or a registered trademark.
.P
Follow these guidelines:
.BL
.LI
Acknowledge all trademarks of other companies.  Check the
most current trademark list for the information.
.LI
Write all trademarks of other companies exactly as they
are registered.
.LI
The first time you use another company's trademark or
registered trademark in text, insert the appropriate
superscript number at the end of the
trademark and create a footnote at 
the bottom of the page that cites the owner.
.P
For example, see the X Window System\*F trademark at the bottom of this page.
.FS
X Window System is a trademark of the Massachusetts Institute of Technology.
.\"ETHERNET\*F
.\".FS
.\"ETHERNET is a registered trademark of Xerox Corporation.
.FE
.LI
Do
.I not
use the \(rg or \(tm symbol with another company's trademark
or registered trademark; these are reserved for OSF use.
.LI
List all trademarks and registered trademarks on the
copyright page in alphabetical order.  List
them after you list OSF's trademarks.
.LE
.\".H 2 "Typefaces"
.\".P
.\"The following sections show the fonts to use for the most common
.\"types of objects we call out in text, such as pathnames, sample
.\"output, and prompts.  We use the term "regular" in this guide
.\"(even though it is not a standard typesetting term) to mean the
.\"plain (nonbold/nonitalic or Roman) version of the body copy, that is,
.\"the standard typeface for simple text.
.\".H 3 "regular typeface"
.\".br
.\".P
.\"This is an example of regular (Roman) typeface used in OSF's published
.\"documents.
.\".P
.\"Use regular for most of the text, including system prompts, when
.\"the system prompts appear within a paragraph of text.
.\".H 3 "boldface"
.\".br
.\".P
.\".B "This is an example of boldface."
.\".P
.\".BL
.\".LI
.\".B "Bold for literal objects"
.\".P
.\"Use bold for literal objects, including commands, utilities,
.\"keywords, options, pathnames, and user input in examples.  
.\"Use bold to refer to names of variables, routines,
.\"procedures, and programs used in sample programs when you 
.\"refer back to them in normal text.  Do not use bold for emphasis.
.\".P
.\"The following paragraphs show examples of the use of bold:
.\".DS 1 F
.\"The 
.\".B edfont
.\"utility is an interactive, menu-driven program that lets you create,
.\"edit, and view character font files.
.\".P
.\"The 
.\".B "ls -x"
.\"command displays the entries in a 3-column format.
.\".P
.\"Your 
.\".B ~user_data/com 
.\"directory contains your shell scripts.
.\"For example, you might have a shell script names 
.\".B my_ld
.\"that is your own version of the
.\".B ld
.\"command.
.\".P
.\"The 
.\".B iod_seek_fixed_rec
.\"program asks the user to specify the number of the record 
.\"to update and assigns the number to the variable
.\".BR choice_rec .
.\".P
.\"In the program 
.\".BR circles ,
.\"The variable 
.\".B radius_1
.\"refers to the radius of 
.\".B circle_1 
.\"and 
.\".B radius_2
.\"is the radius of 
.\".BR circle_2 .
.\".P
.\".B "cp /usr/bin/getcc ~/bin/getcc
.\".DE
.\".LI
.\".B "Bold for the definition of a new term"
.\".P
.\"When you define a new term, put it in bold at its first use,
.\"but not every subsequent use (unless it should be in bold for 
.\"other reasons).
.\".DS 1 F
.\"Entry directories contain one or more upper-level directories.
.\"An upper-level directory is one level below the entry directory
.\"and normally serves as the main directory for a
.\"branch of logically related objects.
.\".DE
.\".LE
.\".H 3 "italics"
.\".br
.\".P
.\".I "This is an example of italics."
.\".BL
.\".LI
.\".B "Italics for substitutes"
.\".P
.\"Use italics for user-supplied arguments, options, and parameters
.\"and for text you want to emphasize.
.\".P
.\"A general guideline is to use italics for names that users are not
.\"likely to enter literally; in cases where the users normally 
.\"substitute their own name or value for the expression in italics.
.\".P
.\"The following example shows the use of italics for user-supplied
.\"arguments:
.\".DS 1 F
.\"The syntax for the 
.\".B cp
.\"command is as follows:
.\".P
.\".B cp
.\".I source_pathname 
.\".RI [ target_pathname ]
.\".RI [ options ]
.\".P
.\"The 
.\".B cp
.\"command copies a file from the source to the target.
.\".DE
.\".P
.\"If you use the same word as a user-supplied argument to discuss
.\"the argument, put it in italics.  For example, when you discuss 
.\""source pathname" in a paragraph, referring back to the previous example,
.\"put 
.\".I source_pathname
.\"in italics.
.\".DS 1 F
.\"The 
.\".B cp
.\"command copies a file from 
.\".I source_pathname
.\"to
.\".IR target_pathname .
.\".DE
.\".P
.\"When referring to a user-supplied argument, option, or 
.\"parameter by its exact name in regular text, use italics; for example:
.\".DS 1 F
.\"For 
.\".I integer_arg
.\"in the function 
.\".BI abs( integer_arg )\fR,
.\"use any value between -32,768 and +32,767.
.\".DE
.\".P
.\"When you refer in text to variables and argument that you have used 
.\"in examples (ones that you have assigned literal names), use bold:
.\".DS 1 F
.\"In the sample program
.\".BR circles ,
.\"the variable 
.\".B radius-1 
.\"refers to the radius of 
.\".BR circle-1 ,
.\"and 
.\".B radius-2 
.\"is the radius of 
.\".BR circle-2 .
.\".DE
.\".P
.\"User-supplied arguments, options, or parameters may be commonly used
.\"words, such as "integer."  If you use the word in its ordinary sense, 
.\"and not in specific reference to a user-supplied argument, option, or
.\"parameter, do not italicize the word; for example:
.\".DS 1 F
.\"The absolute value function takes only integer values, not real values.
.\".DE
.\".LI
.\".B "Italics for emphasis"
.\".P
.\"The following example shows the use of italics for emphasis:
.\".DS 1 F
.\"The 
.\".B cpf
.\"command only copies
.\".IR files ;
.\"use 
.\".B cpt
.\"(copy tree) for copying
.\".I directories
.\"and their subordinate objects.
.\".DE
.\".P
.\"Use italics for emphasis sparingly.  Limit the use of italics to 
.\"1-word or 2-word phrases.  Do not use italics for long phrases or
.\"clauses, sentences, or entire paragraphs.  In these cases, use
.\"other mechanisms for emphasis.  If text is important enough to be
.\"emphasized, call it out in a note.  In some cases make a separate
.\"section for the emphasized material.
.\".LE
.\".H 3 "typewriter"
.\".br
.\".ft CW 
.\".P
.\"This is an example of typewriter.
.\".ft R
.\".P
.\"Use typewriter for system messages and output in examples only, not
.\"in normal (paragraph) text; for example:
.\".DS 1 F
.\"The 
.\".B "pwd"
.\"command lists your current working directory; for example:
.\".sp .45
.\".B "$ pwd"
.\".br
.\".ft CW
.\"/usr/miguel
.\".sp .45
.\".ft R
.\".DE
.\".P
.\"The shell prompt, such as the dollar sign prompt, should be in 
.\"typewriter; however, because the difference between regular typeface
.\"and typewriter font for this one character is
.\"difficult to see, the prompt may be in regular typeface.
.\".P
.\"If you refer to an output message in text, use double quotes, 
.\"not typewriter; for example:
.\".DS 1
.\"The prompt produces the message, "Text is read-only" when ...
.\".DE
.\".P
.\"Use typewriter for sample program listings, whether
.\"a compete program a program fragment, or a single line of 
.\"source code; for example:
.\".DS 1 F
.\"After making the preceding declaration, we can write
.\".sp .45
.\".ft CW
.\"union U u4;
.\".sp .45
.\".ft R
.\".P
.\"This would define another variable, 
.\".BR u4 , 
.\"with type
.\".BR U .
.\"Note that you cannot use the tag name by itself; it must
.\"be preceded by the keyword 
.\".B union
.\"or 
.\".BR struct .
.\".DE
.\".H 3 "sans serif typeface in figures"
.\".br
.\".ft H
.\".P
.\"This is an example of a sans serif typeface.
.\".ft R
.\".P
.\"Use a sans serif typeface for all text within figures, 
.\"as well as for callouts and  labels.
.\"This rule applies only to artwork that we generate at OSF.
.\".H 3 "boldface and regular serif typeface in tables"
.\".br
.\".P
.\"This is an example of regular serif typeface.
.\".P
.\"Use a regular serif typeface in the body of tables and 
.\"for footnotes to tables.  
.\".P
.\".B "This is an example of a boldface serif font."
.\".P
.\"Use a boldface serif font for the column heads of tables.
.\".H 3 "typeface for figure captions and table titles"
.\".P
.\".H 3 "fonts in shell command lines and shell scripts"
.\".br
.\".P
.\"The following sections make some clearer distinctions for
.\"italics and bold example shell command lines.
.\".BL
.\".LI
.\".B "Syntax example"
.\".P
.\"A 
.\".B "syntax example"
.\"serves to illustrate the syntax for a command (or other
.\"entity); for example:
.\".DS 1 F
.\"$
.\".B ld
.\".I your_dir
.\".DE
.\".P
.\"The command
.\".B ld
.\"is in bold, and 
.\".I your_dir
.\"is in italics.  In this case if you refer to 
.\".I your_dir
.\"in the text following the syntax example, then 
.\".I your_dir
.\"must be in italics.
.\".LI
.\".B "Syntax definition"
.\".P
.\"The syntax example is different from the
.\".BR "syntax definition" ,
.\"which is complete and does not have a prompt; for example:
.\".DS 1 F
.\".B ld 
.\".I pathname 
.\".BI [ options ]
.\".P
.\".B bind 
.\".I pathname1 
.\".BI [ pathnameN ] 
.\".BI [ option1 [ 
.\".IB ...optionN ]]
.\".DE
.\".P
.\"The commands
.\".B ld
.\"and
.\".B bind
.\"are bold, and
.\".I pathname
.\"and
.\".I options
.\"are italics.
.\".P
.\"Here is another example:
.\".DS 1 F
.\".BI "debug [" -debug_options ] 
.\".IB target_program_name [ target_program_options ]
.\".DE
.\".LI 
.\".B "Literal example"
.\".P
.\"The following is a
.\".BR "literal example" :
.\".DS 1
.\".B "$ ld weekly_report"
.\".DE
.\".P
.\"Both the command and pathname are in bold.  The file
.\".B weekly_report 
.\"is a literal pathname.  If you refer to 
.\".B weekly_report 
.\"in text following the literal example, then
.\".B weekly_report 
.\"must be in bold.
.\".LI
.\".B "Guidelines"
.\".P
.\"In a syntax example, use phrases like
.\".IR my_dir ,
.\".IR your_dir ,
.\"and
.\".IR dir .
.\".P
.\"In a literal example, do not use phrases like
.\".B my_dir
.\"or
.\".B your_dir
.\"(and do no use them in long printout examples or figures
.\"that the literal example may be referring to).
.\".LI
.\".B "Bold for sample shell script lines" 
.\".P
.\"Use bold for one sample line from a shell script when that line
.\"can stand alone as user input. (Treat a sample shell script longer than
.\"one line as a program listing, and put it in typewriter.)
.\".DS 1 F
.\"If you include a command line such as the following:
.\".P
.\".B "(0,200)dr; (540,600) cp /bin/csh"
.\".P
.\"in your 
.\".B startup_dm
.\"file, the DM automatically opens a C shell when you log in.
.\".DE
.\".LI
.\".B "Sample shell scripts"
.\".P
.\"If a sample shell script listing is longer than one line, then treat it
.\"as a file or program listing and use typewriter.
.\".DS 1 F
.\"As an example of a 
.\".B ".cshrc"
.\"file, consider the following:
.\".sp .45
.\".ft CW
.\"set history=10
.\".br
.\"set path = ( . ~/bind /bin /usr/bin /usr/osf/bin)
.\".br
.\"set noclobber
.\".br
.\"set ignoreeof
.\".br
.\"set inprocess
.\".br
.\"alias cd 'cd \!* ; ls'
.\".sp .45
.\".ft R
.\".DE
.\".LE
.\".H 3 "summary"
.\".br
.\".BL
.\".LI
.\"Commands: bold
.\".LI
.\"Keywords: bold
.\".LI
.\"Datatype: regular, when used generically, bold if a keyword.
.\".LI
.\"Command options (used in text): bold
.\".LI
.\"User-supplied variable (in syntax definitions and text): italics
.\".LI
.\"User-supplied argument (in syntax definitions and text): italics
.\".LI
.\"Variables and arguments used in examples and when referred
.\"to in text; bold (these are literals)
.\".LI
.\"Pathnames, filenames, directory names (in text): bold
.\".LI
.\"True/false: if keywords, in bold; otherwise it depends on context (not
.\".I every
.\"use of these values requires bold or italics)
.\".LI
.\"Sample commands involving user input and system response: user
.\"input in bold regular typeface, system response in typewriter
.\".LE
.\".H 3 "conventions for reference documents"
.\".br
.\".P
.\"The following chart summarizes these conventions for reference documents.
.\"Here are some guidelines specific to reference documents.
.\".BL
.\".LI
.\"The "foo(N)" convention is unique to reference documents, so use the
.\"guidelines in this section and the following table.
.\".LI
.\"Reference documents use the ^ (circumflex) convention to indicate a 
control key.
.\".LI
.\"When a keyword begins a sentence, it is acceptable for the 
.\"keyword to start with a lowercase letter (see also 
.\".BR case-sensitivity ).
.\".LI
.\"When a reference in a "SEE ALSO" section is a complete sentence, use
.\"terminating punctuation.
.\".LE
.\".DS "" F
.\".TB "Typographic Conventions for Reference Documents"
.\".TS
.\"center,box,tab(@);
.\"lB | lB 
.\"l | l .
.\".SP .5
.\"Item@Style
.\"_
.\".SP .5
.\"Command names@Bold
.\"Filenames@Bold
.\"System calls@Bold
.\"Subroutines@Bold
.\"Pathnames@Bold
.\"_
.\""foo(N)"@
.\".sp
.\"in DESCRIPTION section@T{
.\""foo" Bold; "(N)" Roman
.\".br
.\"Example: (\fBacl\fR(7))
.\"T}
.\".sp
.\"in SEE ALSO section@T{
.\""foo" Roman; "(N)" Roman
./".br
.\"Example: (acl(7))
.\"T}
.\"_
.\"Substitutable parameters@Italics
.\"Command arguments@Italics
.\"Options@Bold
.\".TE
.\".DE
.\".P
.\"See also typographic conventions section in the preface.
.P
.H 2 "Typographic and Keying Conventions"
A list of typographic conventions must appear in the preface of all OSF documents.
The following is the current list of typographic conventions
that appears in the preface of OSF
documents.  Edit this list in each 
document so that only those conventions actually used in your
document appear in the preface.  
.VL \w@\f(CWTypewriter\ font\ \ \ fR@u
.LI "\fBBold\fR"
In formats and command descriptions, 
.B "bold"
words or characters represent commands or keywords 
that you must use literally, including pathnames.  
.P
In text, 
.B "bold"
words indicate the first use of a new 
term.
.P
In examples, information that you enter appears in
.B "bold".
.LI "\fIItalics\fR"
.ft I
Italic words or characters in formats and command descriptions 
represent values that you must supply.
.ft R
.LI "\f(CWConstant width\fR"
.ft CW
Information that the system displays appears in 
this typeface. Examples of source code also appear in 
this typeface.
.ft R
.LI "[\ \ ]"
Brackets enclose optional items in formats and command
descriptions. 
.LI "{\ \ }"
Braces enclose a list from which you must choose an item 
in formats and command descriptions. 
.LI "\ |\ "
In formats and command descriptions, 
a vertical bar separates items in a list of choices.
.LI "<\ \ >"
Angle brackets enclose the name of a key on the keyboard.
.LI "..."
Horizontal ellipsis points indicate that you can repeat the 
preceding item one or more times.
Vertical ellipsis points indicate that you can repeat the 
preceding item one or more times.
.LE
.S P 
.P
This document uses the following keying conventions: 
.VL \w@\f(CWoutput/source\ code\fR@u
.LI "\fBCtrl-\fIx\fR or\ ^\fIx\fR"
The notation \fBCtrl-\fIx\fR or ^\fIx\fR, indicates
a control character sequence.  
Hold down the control key while you press the second key in the
sequence.
For example, \fB<Ctrl-c>\fR means that you hold down 
the control key while pressing c.
.LI "\fB<Return>\fR"
The notation \fB<Return>\fR refers to the key on your terminal
or workstation that is labeled with the word Return or Enter, or 
with a left arrow.
.LI "enter"
When instructed to
...\"#emph
.I "enter"
a command, type the command name and then
press \fB<Return>\fR.  For example, the instruction
"Enter the 
.B "ls"
command" means that you type the
.B "ls"
command and
then press \fB<Return>\fR (enter = type command + press \fB<Return>\fR).
.LE
The following table summarizes the typographic conventions
.DS F
.TS
box,center,tab(@);
lb |lb
l |l.
Entity@Convention
_
Commands@Bold
.sp
Keywords@Bold
.sp
Functions@Bold
.sp
Routines@Bold
.sp
Data types@T{
Standard font when used generically, 
bold if a keyword
T}
.sp
Command options@Bold
.sp
T{
User-supplied variables in syntax 
definitions and text
T}@Italics
.sp
Arguments@Italics
.sp
T{
Variables and arguments used in text 
to refer to examples
T}@T{
Bold (these are literals)
T}
.sp
T{
System pathnames, filenames, and 
directory names
T}@Bold
.sp
Return values@ All caps; default font
.sp
User input in sample commands@Bold
.sp
System response in sample commands@Constant width
.TE
.DE
.H 2 "Verbs and Nouns"
.XX R "Call" "a function"
.XX R "Call" "a routine"
.XX R "Initialize" "a device"
.XX R "Start" "an application"
.XX R "Exit" "from an application"
.XX R "Invoke" "a formatter"
.XX R "Invoke" "a procedure"
.XX R "Type" "text"
.XX R "Text" "typing"
.XX R "Applications" "entering"
.XX R "Applications" "exiting"
.XX R "Devices" "initializing"
.XX R "Run" "a command procedure"
.XX R "Execute" "See Run a command procedure"
.XX R "Execute" "See Run a program"
.XX R "Execute" "See Run an executable file"
.XX R "Select" "text"
.XX R "Choose" "See Select text"
.XX R "Run" "an executable file .DS 1E"
.XX R "Invoke" "a utility"
.XX R "Procedures" "invoking"
.XX R "Run" "a program"
.XX R "Functions" "calling"
.XX R "Routines" "calling"
.XX R "Command procedures" "running"
.XX R "Executable files" "running"
.XX R "Utilities" "invoking"
.XX R "Programs" "running"
.XX R "Formatters" "invoking"
.XX R "Choose" "a menu operation"
.XX R "Menu operations" "choosing"
.XX R "Click on" "a button"
.XX R "Click and drag" "a cursor"
.XX R "Cursors" "clicking and dragging"
.XX R "Click on" "an icon"
.XX R "Buttons" "clicking on"
.XX R "Icons" "clicking on"
.XX R "Display" "a dialog box"
.XX R "Remove" "a dialog box"
.XX R "Open" "a window"
.XX R "Open" "a file"
.XX R "File" "opening"
.XX R "Close" "a file"
.XX R "File" "closing"
.XX R "Open" "a database"
.XX R "Databases" "opening"
.XX R "Close" "a database"
.XX R "Databases" "closing"
.XX R "Close" "a window"
.XX R "Dialog boxes" "displaying"
.XX R "Dialog boxes" "removing"
.XX R "Windows" "opening"
.XX R "Windows" "closing"
.XX R "Drag" "a cursor"
.XX R "Enter" "a command"
.XX R "Run" "a command procedure"
.XX R "Cursors" "dragging"
.XX R "Commands" "entering"
.XX R "Command procedures" "running"
.XX R "Depress" "See Press keys"
.XX R "Hit" "See Press keys"
.XX R "Strike" "See Press keys"
.XX R "Punch" "See Press keys"
.P
The following verb and noun combinations are preferred:
.DS F
.TS 
center,box,tab(@);
lb |lb
l |l.
_
Verbs@Nouns
Call@Functions
Call@Routines
Choose@Menu operations
Click and drag@Cursors
Click on@Buttons
Click on@Icons
Close@Databases
Close@Files
Close@Windows
Delete@Entries
Display@Dialog boxes
Drag@Cursors
Enter@Commands
Exit from@Applications
Initialize@Devices
Invoke@Formatters
Invoke@Procedures
Invoke@Utilities
Open@Databases
Open@Files
Open@Windows
Press@Keys
Press and hold@Mouse buttons
Remove@Dialog boxes
Run@Command procedures
Run@Executable files 
Run@Programs
Select@Text
Start@Applications
Type@Text
.TE
.DE
.H 2 "Voice"
.XX R "Active voice"
.XX R "Passive voice"
.XX R "Voice"
.P
In active voice, the subject is the doer of the action. Using the active
voice emphasizes who or what the agent of an action is or how something
comes about.  Using the passive voice emphasizes the result of an action
and gives less emphasis to the agent of the causative action.  Use the active
voice whenever possible.  Use the passive voice when the doer of the action
is unknown, unimportant, or assumed.  
.P 1
.I Use
.DS 1
The prompt is displayed.
.DE 
.P 1
.I "Do not use"
.DS 1
The screen displays the prompt.
.DE
.H 2 "Warranties"
.\" 
.\" ***PIP Rev. B***
.\" 
.XX R "Warranties"
.XX R "Translation considerations" "warranties"
.P
The terms and conditions of product warranties vary by country.  For example, 
some countries are legally required to have longer warranty periods than others.
.BL 
.LI
Avoid inserting warranty information in the documentation, because it is
country-specific.
.LI
Warranty information is often legally required in the local language.
Therefore, include warranty information in an addendum to the Software
Product Description.
.LE
.H 2 "When, Where, While"
.\" 
.\" ***PIP Rev. B***
.\" 
.XX R "When, where, while"
.XX R "Translation considerations" "where"
.XX R "Translation considerations" "while"
.XX R "Translation considerations" "when"
.P
Do not use the adverbs
.I when , 
.I where , 
and
.I while
to mean 
.I "in contrast to" ,
or
.I "in comparison to" .
This frequently results in an ambiguous statement.
If the translator misinterprets the meaning of the statement, translation
errors can occur.

