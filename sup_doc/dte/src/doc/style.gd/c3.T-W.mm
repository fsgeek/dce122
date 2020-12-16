...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c3.T-W.mm,v $
.\" Revision 1.1.2.6  1994/06/24  15:15:33  fred
.\" 	free copyright
.\" 	[1994/06/23  20:22:01  fred]
.\"
.\" Revision 1.1.2.5  1994/06/23  18:39:28  fred
.\" 	free copyright
.\" 	[1994/06/22  19:10:02  fred]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:06:04  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:02:45  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:36:01  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:33:13  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:05:47  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:57:59  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
.H 2 "Tense"
.iX "tense" "present"
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
.iX "that and which"
.iX "which and that"
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
.iX "time" "of day"
.iX "internationalization" "time"
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
.iX "time" "zones"
.iX "internationalization"  "time zones"
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
Time) or the degree of variance from Greenwich mean time (for example, for
Austria, Greenwich mean time plus 1 hour).
.LI
Do not use the mnemonic codes (for example, CET, PST, EST); the codes
are often ambiguous, and no formal international agreement on the
value of these codes exists.
.LI
Do not make reference to the date on which users change to or from 
Daylight saving time.  Such dates differ depending on the country.
.LE
.P
.H 2 "Trademarks"
.iX "trademarks" "OSF"
.iX "OSF" "trademarks"
.iX "adjectives" "trademarks as"
.iX "nouns" "trademarks as"
.iX "verbs" "trademarks as"
.\" 
.\" ***PIP Rev. B***
.\" 
.P
Trademarks are names, symbols, or other devices that identify
products that are legally restricted to the use of the owner or
manufacturer.
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
.ig ++
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
.++
.LI
Do
.I not
use the \(rg or \(tm symbol with another company's trademark
or registered trademark; these are reserved for OSF use.
.LI
List all trademarks and registered trademarks on the copyright
page in alphabetical order.  List them after you list OSF's 
trademarks.
.LE
.H 2 "Typographic and Keying Conventions"
A list of typographic conventions must appear in the preface of all OSF documents.
.P
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
In examples, information that the user enters appears in
.B "bold".
.LI "\fIItalics\fR"
In formats and command descriptions, 
.I "italic" 
words or characters represent variables and values that the user must supply.
.ft R
.LI "\f(CWConstant width\fR"
.ft CW
Information that the system displays appears in 
the  typeface. Examples of source code also appear in 
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
.P
OSF uses the following keying conventions: 
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
Verbs@Nouns
_
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
