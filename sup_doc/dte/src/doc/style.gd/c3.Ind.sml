...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c3.Ind.sml,v $
.\" Revision 1.1.2.6  1994/06/24  15:15:23  fred
.\" 	free copyright
.\" 	[1994/06/23  20:21:42  fred]
.\"
.\" Revision 1.1.2.5  1994/06/23  18:39:19  fred
.\" 	free copyright
.\" 	[1994/06/22  19:09:43  fred]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:06:40  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:02:33  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:35:54  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:33:03  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:05:22  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:57:44  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
.iX "-[" "indexes"
.iX "writing" "indexes"
.iX "creating" "indexes"
.H 2 "Indexes"
.P 
This section discusses OSF's guidelines for creating a useful index or 
evaluating the quality of an existing index.  
It discusses the time required to produce
a usable index, the entries that should be included, and the format of
the entries.
.iX "scheduling" "indexes"
.iX "planning" "indexes"
.iX "indexes" "scheduling"
.H 3 "Scheduling Time for Your Index"
.P 
Since indexes benefit from the review cycle just like the rest of your manual,
you should create a preliminary index before you send the manual out for
final review.  If the major sections in your manual are stable at an earlier
time, consider beginning your index then.
.P
If you are evaluating an index prepared by another company, similar principles
apply.  Make sure you set aside time at the beginning of the project 
to evaluate the index, assess what enhancements need to be made (if any), 
and prioritize the enhancements.  
If the index requires major enhancements, you will need to set
aside time to make them before the manual goes out for final review.
.iX "indexes" "evaluating"
.P
No formula exists for calculating the time required to write a good index.  
Some professional indexers recommend a minimum of 3 days; 
others recommend 4 days per hundred pages.
If you have written a number of indexes, you may have a concrete idea of your
typical pace when indexing and know how much time to set aside.  If you are
relatively new to indexing, you should set aside 1 to 2 weeks to create
a preliminary index.  If you are making specific enhancements to an existing
index, you need to scale the time accordingly.
.iX "indexes" "balancing"
.P
Although the amount of time you have to create an index may be limited
by deadlines, it is important that the index is balanced, covering
all sections of the manual.
Use the following work method to create a balanced index:
.AL 
.LI 
Determine how many working hours that you have.
.LI 
Divide the time into two equal periods.
.iX "index" "entries"
.iX "index" "file"
.LI 
Use the first time period to create the index entries and generate a working
(that is, unedited) index file.
.LI 
Determine the maximum amount of time you should spend indexing each page
by dividing the time period (in minutes) by the total number of pages in 
your manual.
.P
For the first few pages you index, note how much time you spend.  If you are
spending more than the allotted time, you need to quicken your pace and
stick with that pace for the rest of the manual.  Indexing each page in
approximately the assigned number of minutes, ensures that
your index will be balanced, covering all sections of the manual.
.LI 
Use the second time period to generate an index file and edit a hard copy of
the file.  Then, go back into the source files and edit the
entries.  You should generate the index file and edit the entries several
times until you are satisfied.
.iX "index" "file"
.LE
.P 
To illustrate how this method works, suppose you have 1 week to write an
index for a 200-page manual.  You have a total of 40 hours to 
complete the index.
You must spend the first 20 hours (1200 minutes) creating the index entries,
at a rate of 6 minutes per page.  During the second 20 hours, you generate
and edit the index iteratively.
.P 
As you write more indexes, you may find that you edit the entries as you
create them.  Thus, the amount of time you spend generating and
editing the index decreases, so you can spend more time creating the index
entries.  For example, instead of half the total time period, you may need only
a third or a quarter of the total time period to edit the index.
.P
Conversely, you may prefer to add index entries as you write.
In this case, you need to spend more time editing the index
file and index entries.
.P 
Once you create an index as part of your final review draft, be sure to
schedule time to update the index as you add to and change the manual.  Scale
the length of time according to the number of changes you make to the manual.
Note which sections you have changed or added to the manual
since the index was written, and go back and index them.  Even better,
get into the habit of indexing the added and modified sections as you go
along.
.H 3 "Which Topics and Sections to Include in an Index"
.P 
.iX "indexes" "evaluating"
.iX "evaluating" "indexes" 
This section lists the mandatory and optional content of indexes.  If you
are writing a new index, complete the mandatory items first before
moving on to the optional ones.  If you are evaluating an existing index, 
assess whether it meets the mandatory criteria 
as well as the optional criteria.
If the index does not meet some of the criteria, focus your efforts on
fixing the mandatory items first.
.H 4 "Mandatory Content"
.iX "indexes" "mandatory content"
.P 
You must index the following content of your manual:
.ML 
.LI 
All parts of the manual, including the preface, figures, glossary, 
and appendixes.
By indexing all pieces, you create a thorough, balanced index.
.LI 
Major discussions for all pertinent tasks, such as the major sections in
each chapter and appendix.  At a minimum, index the first and second level
heads in all parts of the manual.  Try to have at least two major 
entries for each
task:  one entry with the noun as the primary entry, and one entry with
the action (gerund) as the primary entry.  For example:
.tS
abbreviating
.nL
	commands, 3-29
.sp
commands
.nL
	abbreviating, 3-29
.tE
.LI 
All system elements such as commands, system call, files, and directories.  
Index the name of the element itself, as well as the type of element.  
Also, use the typographic conventions in your index entries as you
use in the text.  For example:
.tS
\*Lcc\*O command, 3-43 to 3-55
.P 
commands
.nL
	\*Lcc\*O, 3-43 to 3-55
.nL
	\*Lmv\*O, 3-57
.P 
\*Lmv\*O command, 3-57
.tE
.LI 
.iX "indexing" "definitions"
.iX "indexing" "concepts"
Concepts and definitions of important terms.  Index both definitions
that appear in the flow of text and those appearing in the glossary.
.LI 
.iX "indexing" "error messages"
.iX "error messages" "indexing"
Error messages.  Index the name of the message as well as the words
"errors" and "messages."
.LI
Special characters.  Index the character itself as well as the spelled
out name of the character.
.LI 
.iX "indexing" "acronyms"
.iX "indexing" "abbreviations"
.iX "acronyms" "indexing"
.iX "abbreviations" "indexing"
Acronyms and abbreviations.  Make the term that is most commonly used (either the
abbreviation or the spelled-out phrase) the primary entry and create a \*VSee\*O
reference for the other entry.  With most acronyms, the acronym itself is more
familiar than the phrase.  In the following example, 
IEEE is the more familar phrase, 
so it is the primary entry:
.tS
IEEE (Institute of Electrical and Electronics Engineers), 
operating system standards, 3-35
.sp
Institute of Electrical and Electronics Engineers.  \*VSee\*O IEEE
.tE
.LI 
.iX "indexing" "figures"
.iX "indexing" "tables"
.iX "figures" "indexing"
.iX "tables" "indexing"
Information in figures and tables.  Index the content of the figures and
tables as well as their titles.  
For some tables, you may need to index each
entry if it is significant for the reader.
.LI 
Titles of manuals.  If you refer readers to other manuals, index the titles of those
manuals.
.LI 
Proper nouns, such as names of languages, machines, and systems.
.LE
.H 4 "Optional Content"
.iX "indexes" "optional content"
.P 
Optionally, you can index the following content of your manual:
.ML 
.LI 
Entries that readers might not go to the index for,
but might use once they get there.
For example:
.tS
audience
.nL
examples (for major examples, such as programs)
.nL
notes
.nL
cautions
.nL
procedures (for numbered steps)
.nL
summary (for tabular information)
.tE
.LI 
Synonyms and alternate names for information.  Use \*VSee\*O references
for these terms.  These synonyms and names could include terms that readers might
be familiar with from other contexts.  For example:
.tS
Alt key.  \*VSee\*O Meta key
.P 
MACH-O.  \*VSee\*O OSF_ROSE 
.tE
.LI 
Related pieces of information.  Use \*VSee also\*O references.  
Keep in mind, however, that the \*VSee also\*O reference 
should lead the reader to additional
information, not the same information under a different heading.  For example:
.tS
protection, files and directories, 3-8
.nL
	\*VSee also\*O permissions
.tE
.LE
.P 
Finally, you should also be aware of content 
that you should \*Vnot\*O index.  Do not
index trivial or obscure references to a topic.  
You should index only the major discussion of a topic, 
not every instance the topic is mentioned in the manual. 
To spot an obscure reference, think about the entry; if you cannott imagine a
reader wanting to find this piece of information, do not include it.
.H 3 "Format of Entries"
.P 
.iX "-[" "indexes" "formatting"
.iX "capitalization" "in indexes"
.iX "indexes" "capitalization"
This section discusses the format of specific types of index entries.  
Follow these guidelines as closely as possible.
.H 4 "General Format"
The following guidelines apply to all index entries:
.ML
.LI 
Capitalize entries as they are normally spelled in running text.  
For example, do not capitalize ordinary words or command names 
(unless the command name actually begins with a capital letter).
.LI 
Alphabetize entries according to the letter-by-letter method.
.LI 
Do not use more than three levels of entries.
.LI 
Do not include more than five page references per entry.  
If you have more than five page references, 
add subentries.  For example, the following entry:
.tS
control keys, 3-3, 3-6, 3-7, 3-8, 3-10, 3-37
.tE
should be change to:
.tS
control keys
.nL
	Control-c, 3-6
.nL
	Control-d, 3-10
.nL
	Control-h, 3-3, 3-7
.nL
	Control-r, 3-6
.nL
	Control-u, 3-7
.nL
	Control-w, 3-7
.nL
	defining, 3-8
.nL
	in \*Lvi\*O, 3-37
.tE
.LI 
If a primary entry has only one secondary entry, 
make the secondary entry a descriptive phrase.
For example the following entry::
.tS
structures
.nL
	synchronizing, 3-75
.tE
should be changed to:
.tS
structure, sychronizing, 3-75
.tE
Do the same for single tertiary entries.
.LI 
Make sure the first word in an entry is the most important word.
.LI 
Make sure all of your primary entries, including nouns, 
gerunds, and special characters, agree with the OSF list of entries
in Section 3.36.4.
In most cases, the list specifies the plural form of a noun
(for example, commands, addresses, characters), but there may be exceptions.
.LI 
If your primary entry begins with an adjective, 
be sure to include the noun as part of the entry.  
Do \*Enot\*O break the noun into a secondary entry.  
For example, the following format is correct:
.tS
left angle bracket, in variable window, 3-54
.nL
left recursion, in \*Lyacc\*O, 3-127
.tE
.P 
But this format is incorrect:
.tS
left
.nL
	angle bracket, in variable window, 3-54
.nL
	recursion, in \*Lyacc\*O, 3-127
.tE
.LI 
When you make cross-references with \*VSee also\*O references, 
make sure the reference leads to additional information, 
not the same information under a different heading.
.LI 
Avoid creating entries with a number as the primary entry.  
If you must use a number as a primary entry, 
alphabetize it according to its phonetic pronunciation.
.cS
.LI 
Add all of your \*VSee\*O and \*VSee also\*O references to a separate file, 
rather than embedding them in the manual.  
We will supply this file as part of the standards in the future. 
The file we supply will have most of the standard cross-references already in it.
You can then add the cross-references that are unique to your manual.  
By having your \*VSee\*O and \*VSee also\*O references in a separate file, 
you can find them easily (since they do not have page numbers) 
for any necessary edits.
.cE
.LI
If an entry is too long to fit in the column (that is, it runs into the
second column or off the page), hyphenate the entry in the source.
This will cause the text to break at the hyphen  in the hardcopy.
.LE
.H 4 "Format of Definitions"
.P 
When indexing a definition of a word, use "definition" as the secondary entry.  
For example:
.tS
breakpoints
.nL
	clearing, 3-142
.nL
	definition, 3-3, 3-171
.nL
	setting, 3-71 to 3-72, 3-97 to 3-100
.tE
.H 4 "Format of Major Tasks"
.P 
When indexing major tasks, 
be sure to include the range of pages in your index entry.
If a topic is discussed at length in several places in the same chapter, 
consolidate the page ranges into a single range.  
For example, you would change:
.tS
breakpoints, 3-3 to 3-42, 3-44 to 3-46
.tE
To the following:
.tS
breakpoints, 3-38 to 3-46
.tE
.cS
.P 
To indicate the most important and/or lengthy discussion of a topic, use the word
"discussion" as a secondary entry.  For example:
.cE
To indicate the most important and/or lengthy discussion of a topic, 
specify the page range with the main entry.  For example:
.tS
expression evaluation window, 3-91 to 3-95
.nL
	creating new, 3-211
.nL
	definition, 3-9, 3-170
.nL
	opening, 3-213
.tE
.H 4 "Format of Software Syntax"
.P 
When indexing commands, system calls, files, directories, options, 
and switches, use the actual command as an adjective, 
and include the appropriate noun.  For example, the following format is 
correct:
.tS
\*L-a\*O option
.nL
	\*Llint\*O command, 3-97
.nL
	\*Lls\*O command, 3-23
.tE
.P 
But this format is incorrect:
.tS
\*L-a\*O, 3-23, 3-97
.tE
.H 4 "Format of Figures and Tables"
.P 
When you index a figure, 
include the word "figure" in parentheses at the end of the entry or subentry.
Likewise, with tables, include the word "table" in parentheses at the end of the entry.
For example:
.tS
data
.nL
	alignment (figure), 3-27
.nL
	representation, 3-24
.nL
	size (figure), 3-44
.sp
signals
.nL
	definition, 3-7, 3-317
.nL
	meaning (table), 3-82 to 3-83
.tE
.H 4 "Format of Special Symbols"
.P 
When indexing special symbols, spell out the name of the symbol in parentheses 
and provide detail in the secondary entry.  
Be sure to consult the OSF list of entries in Section 3.36.4 for the correct name 
of each special symbol.  For example:
.tS
* (asterisk)
.nL
	\*Ladb\*O expressions, 3-152
.nL
	comment in \*Lyacc\*O specification, 3-36
.nL
	operator in \*Llex\*O, 3-13
.nL
	type strings, 3-85
.nL
	wildcard character, 3-16
.tE
.P 
You should also provide an entry for the spelled-out version of the symbol:
.tS
asterisk
.nL
	\*Ladb\*O expressions, 3-152
.nL
	comment in \*Lyacc\*O specification, 3-36
.nL
	operator in \*Llex\*O, 3-13
.nL
	type strings, 3-85
.nL
	wildcard character, 3-16
.tE
.P 
Depending on the symbol, 
you should also supply an entry for the use of the symbol.  
For example, these entries could supplement the entries for >, <, 
and | in an OSF manual:
.tS
pipes, for redirection of output, 3-13
.nL
redirection, of output with pipes, 3-13
.tE
.P 
When indexing filenames or other items that begin with a special symbol, 
do \*Enot\*O alphabetize them under the special symbols section.  
The filename should appear under the first alphabetic character in the name. 
For example:
.tS
\*L-a\*O option, of \*Llint\*O command, 3-43
.nL
$a0 to $a7 registers, 3-147
.sp
creating, aliases, in \*Ldbx\*O, 3-114 to 3-115
\*L.cshrc\*O file, 3-19
.nL
\*Lcumsecs\*O column, in \*Lprof\*O listings, 3-192
.tE
.iX "-]" "indexes" "formatting"
.H 3 "List of Primary Entries for OSF Indexes"
.P 
This section lists the primary entries that you should use when indexing.  
Use as many of these entries as appropriate. 
.tS
& (ampersand)
.nL
<> (angle brackets)
.nL
* (asterisk)
.nL
` (backquote)
.nL
\\ (backslash)
.nL
{} (braces)
.nL
[] (brackets)
.nL
^ (circumflex)
.nL
: (colon)
.nL
, (comma)
.nL
- (dash)
.nL
$ (dollar sign)
.nL
\&. (dot)
.nL
\&.\. (double dot)
.nL
" (double quotation mark)
.nL
\&.\.\. (ellipses)
.nL
= (equal sign)
.nL
! (exclamation point)
.nL
() (parentheses)
.nL
% (percent sign)
.nL
+ (plus sign)
.nL
# (number sign)
.nL
? (question mark)
.nL
> (redirection symbol)
.nL
; (semicolon)
.nL
\' (single quotation mark)
.nL
/ (slash)
.nL
~ (tilde)
.nL
| (vertical bar or pipe)
.nL
addresses
.nL
arguments
.nL
C compiler
.nL
C language
.nL
changing
.nL
child processes
.nL
commands
.nL
compiling
.nL
control keys
.nL
core files
.nL
copying
.nL
creating
.nL
data
.nL
deleting
.nL
directories
.nL
editing
.nL
errors
.nL
examples
.nL
exiting
.nL
files
.nL
help
.nL
initializing
.nL
instructions
.nL
keys
.nL
libraries
.nL
logging in
.nL
logging out
.nL
menus
.nL
messages
.nL
notes
.nL
options
.nL
parameters
.nL
parent processes
.nL
pointers
.nL
procedures
.nL
processes
.nL
programs
.nL
quitting
.nL
registers
.nL
searching
.nL
stack
.nL
starting (rather than invoking)
.nL
states
.nL
stopping (rather than terminating)
.nL
summary
.nL
system calls
.nL
variables
.nL
windows
.tE
.iX "-]" "indexes"
