...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c2.4comtmp.sml,v $
.\" Revision 1.1.2.7  1994/06/24  15:14:57  fred
.\" 	free copyright
.\" 	[1994/06/23  20:20:56  fred]
.\"
.\" Revision 1.1.2.6  1994/06/23  18:38:49  fred
.\" 	free copyright
.\" 	[1994/06/22  19:07:52  fred]
.\" 
.\" Revision 1.1.2.5  1993/06/14  15:02:51  bowe
.\" 	Minor edits by Noreen.
.\" 	[1993/06/14  14:35:10  bowe]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:06:28  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:01:58  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:35:34  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:32:30  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:04:00  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:56:50  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
.TH "Command Template"
.SH "NAME"
\*LCommand Format Template\*O - Provides a  description of command 
reference page structure and content
.P
The \*LName\*O section contains the name of the command 
in bold, followed by a dash, and a short statement of its purpose.  
Include a space before and after the dash.
Begin the statement with an active initial-capped verb. 
Do not include an ending period.
.P
It is important that you keep the purpose statement as succinct as possible
because some commands and tools use this line as input.
For this reason, do not include anything other than a description
in \*LName\*O.
For example, for dummy pages (that is, reference pages that 
refer the reader to other reference pages for specific
information), add a \*LDescription\*O section for the "See" reference 
and include a brief description in \*LName\*O. 
.P
Likewise, for reference pages that describe a command not in OSF/1,
add a \*LDescription\*O section that includes the statement "This command 
does not exist for OSF/1 . . ." and refer the reader to the 
appropriate OSF/1 reference.
.P
If the reference page describes more than one command, include all
the command names.
However, try to avoid combining reference pages.  Use dummy pages instead.
.SH "SYNOPSIS"
The \*LSynopsis\*O section contains the synopsis diagram.  
See section XXXX for information on formatting synopsis diagrams.
.SH "FLAGS" 
The \*LFlags\*O section lists and describes the command's required or 
optional flags, if any.
Preface each flag with - (dash) and use bold font for the dash and
the flag.  List the flags in alphabetical order, 
with lowercase flags before uppercase flags; 
for example, \*LehmMwxXy\*O. 
.P
Use the conventions for formatting the \*LSynopsis\*O section 
(see section XXXX) in \*LFlags\*O.
For example, use italics for arguments to flags, and brackets for
optional arguments.  
.P
Begin the text for each flag with an active verb.
Specify whether the flag is mandatory or optional, or is mutually
exclusive with another flag.
Because the \*LFlags\*O section is used most frequently for quick reference,
make the descriptions as concise as possible.  If a flag requires
more complete discussion, included this discussion in the
\*LDescription\*O or \*LNotes\*O section, depending on its scope.
.SH DESCRIPTION
Begin the \*LDescription\*O section with a concise 
description of the purpose of the command.  
The initial sentence should be an expansion
of the short statement included in \*LName\*O.
Follow the initial description with details of the function's
use.
.P
Also use \*LDescription\*O to expand information provided
in other sections, such as \*LFlags\*O.
Some this information may overlap with other 
sections on the current reference page.
.P
Use subsections in the \*LDescription\*O section, if necessary.
.SH "SUBCOMMANDS"
The \*LSubcommands\*O section describes in detail 
the command's subcommands, if any.
If necessary, you can use subsections in this section.
.SH "EXAMPLES"
The \*LExamples\*O section provides examples of 
ways in which the command is typically used.
Examples generally consist of an explanatory line or two of text, a
constant-width illustration of an actual instance of the command, output from
the command if appropriate, and explanatory text again.
.P
If there is more than one example, number each example.
.SH "FILES"
The \*LFiles\*O section lists any OSF/1 system files that are read, 
employed, referred to, or written to by the command, 
or that are otherwise relevent to its use.
Include a brief description for each pathname,
but do not include the name of the executable file of the command
itself.
.SH "NOTES" 
The \*LNotes\*O section contains any supplementary information 
that is peripheral to the
actual operation of the interface or function.    
Use this section instead of a set-off text region labeled "Notes"
in other sections.
.SH "CAUTIONS"
The \*LCautions\*O section contains information on possible
system damage or data corruption
that may occur as a result of using the command in a specific implemenation.
.SH "DIAGNOSTICS"
The \*LDiagnostics\*O section provides information useful 
for diagnosing errors that may result when the command is used.
.SH "EXIT VALUES"
The \*LExit Values\*O section lists and describes exit 
values returned by the command.
.SH "RELATED INFORMATION"
The \*LRelated Information\*O section lists OSF/1 
commands, functions, file formats, and special files that are
employed by the command, that have a purpose that is related to that of
the command, or that are otherwise of interest within the context of the
command.  
.P
This section also lists related OSF/1 documents 
and other related documents, and
miscellaneous information related to the command.
.P
The following basic subgroups are used in \*LRelated Information\*O; 
use only the subgroups that apply:
.rS
Functions:
.br
Commands:
.br
Files:
.br
Data Structures:
.rE
.P
If necessary, you can break information into additional groups.
.P
Include section numbers for reference pages listed in this section,
using bold for both the section number and the parentheses.
Separate the reference pages with a comma.  Do not include \*Vand\*O between
the last two pages in the list and do not include a period at the end
of the list. 
.P
Include name of the reference page, even if it is not the
same as the command you refered to in text. For example, include
\*Lscanf(3)\*O as opposed to \*Lfscanf(3)\*O.
