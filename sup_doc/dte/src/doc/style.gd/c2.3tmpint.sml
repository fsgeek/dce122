...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c2.3tmpint.sml,v $
.\" Revision 1.1.2.6  1994/06/24  15:14:54  fred
.\" 	free copyright
.\" 	[1994/06/23  20:20:52  fred]
.\"
.\" Revision 1.1.2.5  1994/06/23  18:38:47  fred
.\" 	free copyright
.\" 	[1994/06/22  19:07:43  fred]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:06:26  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:01:54  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:35:33  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:32:27  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:03:55  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:56:46  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
.H 2 "Reference Page Formats"
This section describes the OSF format for command and interface reference 
pages. It includes templates that indicate  which section headings to use,
their order, and their contents. 
.P
The templates describe all necessary section headings; however,
not all section headings are applicable for every reference page.
If a heading is not necessary for a specific reference page, do not
include it.  That is, do not include a heading with no text or 
with filler text.  
.H 3 "Data Structures and Header Files"
Use the interface reference page template for
formatting data structure and header file reference pages. 
Special instructions are included in this template where 
information may differ. 
.H 3 "Formatting Synopsis Diagrams"
The \*LSynopsis\*O section of each reference page contains a diagram
summarizing the ways in which a command or interface is invoked. 
.H 4 "Typographic Conventions in Synopsis Diagrams"
Use \*Lbold\*O for
commands, interfaces and system objects that must be used literally,
including:
.tS
Commands
Functions
Flags
Structures
Pathnames
Filenames
Routines
Directories
Calls
Files
Named variables
Environment variables
.tE
.P 
Use \*Vitalics\*O for
strings used to represent other, variable strings,
including:
.tS
Arguments
Parameters
Fields
Options
Changing values
Pointers
.tE
.P
See section XXXX [Typographic Conventions] in Chapter 3 for a description of the typographic conventions to use in the text of a reference page.  
.H 4 "Formatting Command Synopsis Diagrams" 
The following guidelines describe how to format command
synopsis diagrams.
.ML
.LI 
Put all optional items, including both flags and arguments, in 
brackets; for example [\*Vfile\*O].  
Put an optional argument to an optional flag in
its own pair of brackets, following the flag 
(which is within its pair of brackets).
For example, [\*L-a\*O] [\*Vfile\*O] indicates an optional flag \*L-a\*O
with its optional argument \*Vfile\*O, as opposed to [\*L-a\*O \*Vfile\*O],
which indicates an optional flag \*L-a\*O and its required argument
\*Vfile\*O.  
.cS
This may incorrectly imply that the argument could be specified
without the flag; when in doubt, consult the \*LFlags\*O section of the
reference page.
.cE
.P
Use the default font for brackets.  Include a space before the 
left bracket and after the right bracket.
.LI 
Group flags that do not take arguments together.
If these flags are optional, group them in a pair of brackets.  
If some are required and some are optional, group them separately \(em
the required flags with no brackets followed by the optional flags 
in brackets: for example, \*L-ajkv\*O. 
Show flags that have associated arguments separately.  
However, do not group flags that are mutually exclusive, that is, flags
that cannot be used together.
.LI 
Put flags, including  groups of flags, in alphabetical order
(U.S. English), with uppercase letters following lowercase letters; for
example, \*L-aAjkKv\*O.
.LI 
Put command arguments in the order required by the command, if any.
Put mandatory arguments before optional arguments, unless the command
requires otherwise.
If an argument represents the primary object of the command (for example,
a file or directory) put it before the other arguments if possible.	
.LI 
Indicate arguments of indeterminate number with an ellipsis
following the argument name; for example, [\*L-a\*O \*Vfile\*O ...].  
However, do not use plural argument names 
even if the argument may be repeated.
.LI 
When two or three flags or arguments are mutually exclusive \(em that is, they
may not be used together \(em list them next to each other separated by 
vertical bars; for example,
\*L-a\*O | \*L-j\*O or [\*L-k\*O \*Vfile\*O | \*Vdirectory\*O].
Use the default font for the vertical bar.
Include a space before and after the vertical bar.
.nS note 
If you cannot describe all possible combinations or necessary information
using the previous guidelines, 
show different combinations as separate syntax diagrams on separate lines
(as if they were separate commands).
.nE
.LI
For files that are not invoked from the command line,
put the pathname to the file in \*LFlags\*O, and do not include
a Synopsis section.
For daemons that are not invoked from the command line, put  
the name of the daemon in \*LSynopsis\*O. However, if the reference page
discusses subcommands of the daemon
that are invoked from the command line, diagram the subcommands.
.LE
.H 4 "Formatting Interface Synopsis Diagrams"
To format an interface synopsis diagram, first list the header
file include statements required to use the interface. Then
diagram the interface following the ANSI C coding conventions
and the typographic conventions listed in section XXXX.  
.H 4 "Formatting Data Structure and Header File Synopis Diagrams"
To format a data structure or header file synopsis diagram, first list
the header file include statement. Then diagram any data structures
in the file that are not self-explanatory following the ANSI C 
coding conventions and the typographic conventions listed in section
XXXX.
.nP
