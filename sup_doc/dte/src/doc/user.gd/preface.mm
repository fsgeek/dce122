...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\"  @OSF_FREE_COPYRIGHT@
...\"
...\" HISTORY
...\" $Log: preface.mm,v $
...\" Revision 1.1.2.7  1994/06/24  15:16:45  fred
...\" 	free copyright
...\" 	[1994/06/23  20:16:42  fred]
...\"
...\" Revision 1.1.2.6  1994/06/23  18:40:46  fred
...\" 	free copyright
...\" 	[1994/06/22  19:35:56  fred]
...\" 
...\" Revision 1.1.2.5  1993/04/10  01:23:05  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  01:20:59  bowe]
...\" 
...\" Revision 1.1.2.4  1992/05/28  18:21:02  bowe
...\" 	Fix botched initial check-in.
...\" 	[1992/05/28  18:17:20  bowe]
...\" 
...\" Revision 1.1.2.3  1992/05/28  17:56:37  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:53:37  bowe]
...\" 
...\" Revision 1.1.2.2  1992/05/28  16:50:38  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:48:17  bowe]
...\" 
...\" $EndLog$
...\" _________________________________________________________________
...\"
.nr P 6 
.H 1 "Preface"
.P
The
...\"#doctitle
.I "Documentation Tools Environment User's Guide/Reference"
explains how to use the OSF\(tm Documentation Tools Environment (DTE) to
build OSF books.  
.H 2 "Tool Description"
The DTE is an internal OSF tool for creating
OSF documents, which we make available to our licensees.  While
it is not a supported part of our OSF offerings, we are interested
in feedback about the tool, so that we can improve its portability
and functionality over time. 
.H 2 "Audience"
This document is for OSF writers, writers
at OSF licensee sites, and writers preparing
documentation for OSF technology suppliers.
DTE users should be familiar with Unix \(tm
text processing tools.
.H 2 "Applicability"
.P
The DTE requires a Documentor's Workbench package; 
see the release notes provided with this document for
information about version requirements. 
.H 2 "Purpose"
The purpose of this document is to show you how to use the DTE to
markup and build OSF documents.  The document does not describe
how to use the DTE to create non-OSF documents.
.H 2 "Document Usage"
This document is organized into six chapters and one appendix.
.BL
.LI
For an introduction to the Documentation Tools Environment (DTE), 
see Chapter 1.
.LI
To understand source file markup, see Chapter 2.
.LI
To understand how to build books, see Chapter 3.
.LI
For a technical description of the Semantic Markup Language (SML),
see Chapter 4.
.LI
For a quick-reference to SML, see Chapter 5.
.LI 
For the manual pages for the DTE, in alphabetical order, see Chapter 6.
.LI
For information about the internals of the DTE, for users who
are interested in extending it or adapting it to another environment,
see Appendix A.
.LI
For information about including Postscript files in documents, see
Appendix B.
.LE
.H 2 "Typographic and Keying Conventions"
.P
This document uses the following typographic conventions: 
.VL \w@\f(CWoutput/source\ code\fR@u
.LI "\fBBold\fR"
.B "Bold"
words or characters represent system elements that you must use
literally, such as commands, flags, and pathnames. \fBBold\fR words
also indicate the first use of a term included in the glossary.
.LI "\fIItalic\fR"
.I "Italic"
words or characters represent variable values that you must supply.
.ft R
.LI "\f(CWConstant width\fR"
Examples and information that the system displays appear in
\f(CWconstant width\fR typeface.
.LI "[\ \ ]"
Brackets enclose optional items in format and syntax
descriptions.
.LI "{\ \ }"
Braces enclose a list from which you must choose an item
in format and syntax descriptions.
.LI "\ |\ "
A vertical bar separates items in a list of choices.
.LI "<\ \>"
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
.LI "\fB<Ctrl-\fIx\fB>\fR\ or\ ^\fIx\fR"
The notation \fB<Ctrl-\fIx\fB>\fR or ^\fIx\fR followed by
the name of a key, indicates
a control character sequence.
For example, \fB<Ctrl-c>\fR means that you hold down
the control key while pressing \fB<c>\fR.
.LI "<\fBReturn\fR>"
The notation <\fBReturn\fR> refers to the key on your terminal
or workstation that is labeled with the word Return or Enter, or
with a left arrow.
.LI "Entering\ commands"
When instructed to
...\"#emph
.I "enter"
a command, type the command name and then
press <\fBReturn\fR>.  For example, the instruction
"Enter the
.B "ls"
command" means that you type the
.B "ls"
command and
then press <\fBReturn\fR> (enter = type command + press <\fBReturn\fR>).
.LE
