...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c3.D-F.mm,v $
.\" Revision 1.1.2.6  1994/06/24  15:15:16  fred
.\" 	free copyright
.\" 	[1994/06/23  20:21:30  fred]
.\"
.\" Revision 1.1.2.5  1994/06/23  18:39:11  fred
.\" 	free copyright
.\" 	[1994/06/22  19:09:17  fred]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:05:51  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:02:22  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:35:48  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:32:53  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:04:52  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:57:26  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
.H 2 "dashes"
.iX  "dashes" "en"
.iX "en dashes"
.iX "em dashes"
.iX  "punctuation" "dashes"
.iX  "dashes" "em"
.iX  "-; hyphens" "dashes"
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
.P
Do not put a space before or after dashes used in text
or in titles.
.LE
.H 2 "Dates"
.\" 
.\" ***PIP Rev. B***
.\" 
.iX "dates"
.iX "month"
.iX "year"
.iX "internationalization" "date"
.iX "internationalization" "day"
.iX "internationalization" "month"
.iX "internationalization" "year"
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
.iX "display" 
.iX "-: displays" "appears"
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
.iX "ellipses"
.iX "vertical ellipses"
.iX "horizontal ellipses"
.iX "-: ellipses" "dots"
.iX "-: Latin abbreviations, ellipses" "etc"
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
.iX "font" "for emphasis"
.iX "system messages" "emphasizing"
.iX "italic" "for emphasis"
.iX "bold" "for emphasis"
.iX "emphasis"
.iX "defining new terms" 
.iX "new terms, defining"
.iX "manual titles" "in text"
.iX "referencing titles of manuals" 
.iX "titles of manuals" 
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
.iX "enter"
.iX "entering" "commands"
.iX "type"
Follow these rules for the verbs \fIenter\fR and \fItype\fR. 
.BL 
.LI
Use
.I enter
for invoking commands from the keyboard.  For example:
.iX "entering" "menu information"
.iX "entering" "form field information"
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
.iX "Enter" "response to prompt"
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
.iX "fewer and less"
.iX "less"and fewer"
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
.iX "file types, initial periods"
.iX "pathnames"
.iX "periods" "file types"
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
