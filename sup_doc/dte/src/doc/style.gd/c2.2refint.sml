...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c2.2refint.sml,v $
.\" Revision 1.1.2.6  1994/06/24  15:14:52  fred
.\" 	free copyright
.\" 	[1994/06/23  20:20:49  fred]
.\"
.\" Revision 1.1.2.5  1994/06/23  18:38:45  fred
.\" 	free copyright
.\" 	[1994/06/22  19:07:25  fred]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:06:24  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:01:50  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:35:31  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:32:24  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:03:51  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:56:42  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
.H 2 "Reference Page Style Guidelines"
This section describes style, content, and structure guidelines
for OSF reference pages. It includes general style guidelines as well as 
templates for specific types of reference pages.
.H 3 "General Style"
Use the following general style guidelines when writing reference pages:
.ML
.LI
Use present tense whenever possible.  For example, use 
.I "is" 
or 
.I "are"
instead of 
.IR"will be".
.LI
Use the second person, active voice whenever possible.
.LI
Avoid long strings of modifiers.  For example:
.tS
.eM "Use"
.sp
The destination protocol address that was previously sent.
.tE
.tS
.eM "Do not Use"
.sp
The previously sent destination protocol address . . .
.tE
.LI
Avoid using contractions.
.LI
Use double quotes instead of sets of single quotes.
.LI
Use double quotes around single letters and other short expressions.
For example:  "The following command compares the "a" files to
the "b" files."
.LI
Put a space before ellipses, but no spaces between dots.
.LE
.H 4 "Referring to System Elements"
Use the following guidelines when referring to system elelments:
.ML
.LI
Use the following construction when identifying an existing system element
(command, function, parameter, and so on): 
"the \*Lname\*O command," "the \*Vname\*O parameter."
When identifying a hypothetical system element or something the user must
create, reverse the order, as in "the file \*Lname\*O." For example:
.sp
.tS
.fi
The \*L/etc/passwd\*O file contains password entries for all users.
Before changing this file, you can copy it to a backup file, for example,
\*L/etc/OLDpasswd\*O. The file
\*L/etc/OLDpasswd\*O is now your backup copy.
.sp
.tE
.LI
Capitalize  system elements 
as they appear on the system.
Do not capitalize a lowercase system element that is the
first word in a sentence.
However, do not use a lowercase element name as the
first word in a paragraph. For example:
.iS
.fi
The \*Lgetws\*O function transforms multibyte character input values 
to uniform \L*NLchar\*O width.  \*Lfgetws\*O also expands one-byte and 2-byte
character input values to uniform \*LNLchar\*O width.
.iE
.LI
Use empty parenthesis to designate a function call; for example,
\*Lload\*O().
.LI
Do not rely solely on typographic conventions to identify a system
element unless that element is
the subject of the reference page or is specifically identified by a
heading. For example: 
.tS
.fi
.eM Use
.sp
A type \*Lt_optmgmt\*O structure defined in the \*Lxti.h\*O include 
file is used to specify options.
.sp
.eM "Do not use"
.sp
A type \*Lt_optmgmt\*O structure defined in \*Lxti.h\*O is used to 
specify the options.  
.tE
.LI
Do not refer to the subject of a reference page as
"this \*Lcommand\*O/\*Linterface\*O" or "the \*Lcommand\*O/\*Linterface\*O"
.eM "throughout" 
the reference page.
Generally,
you should refer to the subject of a reference page by name the first time
it appears in a paragraph (at least).
For example:
.tS
.fi
.eM "Use"
.sp
\*LDESCRPTION\*O
.in 1i
The \*Lmknod\*O function creates a special file or FIFO.
.in
.eM "Do not use"
.sp
\*LDESCRITPION\*O
.in 1i
This function creates a special file or FIFO.
.in
.tE
.LI
Do not use a slash before a single directory or filename unless the leading
slash actually refers to the system root. 
.LE
.H 4 "Keyboard Sequences"
Use the following guidelines when referring to keyboard keys or key
sequences:
.ML
.LI
The names of keys are bold and enclosed in angle brackets: for example, 
.K, Escape .
Use an initial capital for key names that are words.
.LI
Refer to a control sequence in text as follows:
.K, Ctrl-\*VX\*O . 
\*OUse \*C^\*O\*VX\*O to refer to a control sequence when describing
system output.
.LI 
Use 
.K, Return
to refer to the key used to enter commands.
.LE
.P
See section XXXX [keys] for more information about keyboard keys and
key sequences.
.H 4 "Tables"
See section 2.3 for guidelines for formattting tables in
reference pages.
.cS
.ML
.LI
List footnotes to tables flush left under the table.  Use numbers to
mark footnotes to tables.
*******
Can tools do this???
******
.LI
Align columns in a table flush left with the
column head. However, if none of the entries in the column is more than
three characters, center the column under
the column head. The following table illustrates the correct way to justify
columns.
.TS 
center,box,tab(@);
lb | lb | lb
l | li | c.
Page Queue@VM Object@Offset
_
Free@tattle@2K
Inactive@tattle@2K
Active@tattle@2K
Inactive@teak@1K
Free@teak@3K
Inactive@tattle@1K
.TE
.LI
Introduce tables with a complete sentence.  Do not use an incomplete
sentence with a colon.
For example,
.tS
.eM "Use"
.sp
The flags specified by this function are described in Table 1-1.
.sp
.eM "Do not Use"
.sp
Flags specified by this function are:
.tE
.LE
.cE
.H 4 "Lists"
Use the following guidelines when using lists in reference pages:
.ML
.LI
Use a colon after an introductory statement that is a complete
sentence. 
For example:
.tS
The \*Lfoo\*O command truncates the pathname to produce the following:
.sp .4v
The following values of \*Vlocal\*O are defined for all settings of \*Vcategory\*O:
.sp .4v
The values of \*Vlocal\*O are defined as follows:
.tE
.LI
Do not use a colon after an introductory statement that is not a complete
sentence.
For example:
.tS
.fi
The \*Lfoo\*O command truncates the pathname to
.sp .4v
The socket level options are
.sp .4v
The \*Lfoo\*O command
.sp .4v
.in .5i
\(bu\0\0Truncates the pathname
.sp .4v
\(bu\0\0Defines the values of \*Vlocal\*O
.tE
(Note that it is acceptable. to use a colon with an incomplete sentence
when using "For example:" to introduce an example.)
.LI
Start each item in a list with the same part of speech if possible.
...\", that is, either start each item
...\"with a complete sentence, or start each entry with an incomplete
...\"sentence. 
 For example:
.tS
\*Vfd\*O   A file descriptor that ... 
.sp .4v
\*Vfp\*O   A pointer to a ... 
.br 
(noun marker)
.sp 1.5
The \*Lfoo()\*O function
.sp
\(bu\0\0Enables or disables socket listening ...
.sp .4v
\(bu\0\0Determines if a sending socket receives ...
.br
(verb)
.sp 1.5
The process inherits the following attributes:
.sp
\(bu\0\0File type as specified by the \*Vmode\*O parameter ...
.sp .4v
\(bu\0\0Group ID set to the group ID of the parent process ...
.br
(adjective)
.tE
.LI
For a list in which the order of the items is not significant (a 
nonsequential list) use
.ML
.LI
Bullets for a first-level list 
.LI
Em dashes (\(em) for a second-level list
.LE
.LI
For a list in which the order of items 
.eM "is" 
significant (a sequential list) use
.ML
.LI
Numbers (1. 2. 3.) for a  first-level list
.LI
Letters (a. b. c.) for a second-level list
.LE
.LI
Do not use periods after list items that are not complete sentences.
For example:
.tS
\*L/usr/bin/ar\*O
.nL
	Command path
.sp
\*L/tmp/ar\*O
.nL
	Temporary files

.tE
.LE
.H 4 "References"
Use the following guidelines when referring to other sections or 
documents. 
.ML
.LI
When referring readers to other reference pages, use bold.
You only need to include the section number (in parenthesis)
in \*LRelated Information\*O.
.LI
Use bold to refer to section headings in the current reference page.
Do not precede the section name with \*Vthe\*O.
For example, \*LSynopsis\*O instead of \*LSynopsis\*O.
.cS
Of course, if you use init caps in draft format, the case
of the headings won't match in draft format. Too bad. 
.P
Do not precede the reference with \*Vthe\*O.  Just use the name of the
section. For example: 
.iS
\&... see \*LDESCRIPTION\*O for more information.
.iE
.LI
Use italics when referring to other manuals.
.LI
Precede references to other manuals with \*Vthe\*O.
.LI
When referring to chapters or sections in other manuals, use an initial 
capital for  the chapter or section 
name and enclose it in double quotes.  Italicize
the name of the manual. For example 
.iS
\&... see "Writing Internationalized Applications" in the \*(Gn.
.iE
.LI
Avoid referring to specific chapters or sections of manuals that have not been
published (for example, other OSF manuals in the release you are working on).
The names of chapters and sections could change at any point in the
manual's development.
.LE
.H 4 "Usage"
.ML
.LI
Use an active verb to introduce user instructions.
For example:
.iS
.eM "Use"
.sp
To create a library, enter:
.sp
\*Lar vq lib.a strlen.o strcpy.o\*O
.sp
.iE
or
.tS
Use the following command to create a library:
.sp
\*Lar vq lib.a strlen.o strcpy.o\*O
.sp
.tE
.tS
.eM "Do not use"
.sp
To create a library:
.sp
\*Lar vq lib.a strlen.o strcpy.o\*O
.tE
.LI
\*VStandard error\*O does not require an article before it.
.LI
Avoid using \*Vsee above\*O and \*Vsee below\*O. 
Try to use the actual section name if possible.  
Otherwise, use \*Vpreceding\*O, \*Vprevious\*O  or \*Vfollowing\*O.
.LI
Use the word \*Vto\*O in text to indicate a range, for example, (0 to 9).
Use a dash if you are referring to a string, or if the range appears in
a table.
.LI
Change \*Vshould\*O to \*Vmust\*O or \*Vcan\*O or \*Vneed to\*O.  
You can sometimes replace it with the simple present form of the verb.  
Use \*Vmust\*O with caution.  
It may change the meaning of the sentence.
.LE
.P
See Chapter 3 for more information about usage.
.H 4 "Terminology"
.P
See Chapter 4 for the OSF terminology list.
.H 4 "Capitalization"
Use the following capitalization guidelines when writing reference pages:
.ML
.LI
Capitalize commands and interfaces
as they appear on the system.
Do not capitalize a lowercase command or interface that is the
first word in a sentence.
However, avoid using a lowercase command or function name as the first 
word in a paragraph.
.LI
In text, \*Vtrue\*O and \*Vfalse\*O should be all capital letters, not bold, 
if they represent return values. 
For example:
.iS
\&...sets the variable to the specified value or to TRUE.
.iE
.LI
Do not use initial capitals for the names of file permissions (read,
write, and execute).
.LE
.P
See section XXXX for more information on capitalization.
.H 4 "Numbers and Symbols"
Use the following guidelines when using numbers and symbols in
reference pages:
.ML
.LI
When using symbols in text, put the actual symbol first, followed by
the name of the symbol in parentheses; for example,
+ (plus sign), . (dot), .. (dot dot).
.LI
Use the following construction to refer to the value zero: 0 (zero).
.LI
Use numerals in compound modifiers starting with a number.  For example,
use \*V2-word\*O, \*V5-line\*O, rather than \*Vtwo-word\*O, \*Vfive-line\*O.
.nS note
Because the numeral 1 can be confused with the letter l, the correct
modifier is \*Vone-word\*O. 
.nE
.cS
.P 
Use the following terms to describe symbols:
.VL 1i
.LI "#"
number sign
.LI "+"
plus sign
.LI "-"
dash  (minus for math)
.LI "^"
circumflex
.LI "!"
exclamation point
.LI "''"
single quotes
.LI '""'
double quotes
.LI "?"
question mark
.LI "/"
slash
.LI "//"
(two slashes)
.LI "\e"
backslash
.LI "~"
tilde
.LI "@"
at sign
.LI "$"
dollar sign
.LI "%"
percent sign
.LI "\(ga"
grave accent
.LI "*"
asterisk
.LI "()"
parentheses
.LI "("
open parenthesis
.LI ")"
close parenthesis
.LI "="
equal sign
.LI ":"
colon
.LI "[]"
brackets
.LI "{}"
braces
.LI "\(ua"
up arrow
.LI "\(da"
down arrow
.LI "\(<-"
left arrow
.LI "\(->"
right arrow
.LI "<>"
angle brackets
.LI "|"
pipe symbol or vertical bar
.LI ">"
redirection symbol
.LI "&"
ampersand
.LI 
.LE
.wH .1C
.cE
.LI
See Chapter 4 for the correct terms to describe symbols. 
.LE
.H 3 "Index Entries"
Use the following guidelines when adding index entries to reference pages:
.ML
.LI
Include an entry for the subject of the reference page
at the beginning and end of the reference page  
to make sure the page range is included in the index.
For reference pages that describe more than one command, 
include an entry for each command or interface.
.LI
At the beginning of the reference page, 
include at least one task-oriented entry.
Generally, create index entries from the purpose line as follows:
.tS
formatting, mail messages
.nL
messages, mail
.nL
	formatting
.nL
mail messages, formatting
.tE
.LI
See section XXXX [Indexing] in Chapter 3 for general indexing guidelines.
.LE
