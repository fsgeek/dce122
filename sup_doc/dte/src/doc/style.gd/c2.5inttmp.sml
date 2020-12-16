...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c2.5inttmp.sml,v $
.\" Revision 1.1.2.7  1994/06/24  15:14:59  fred
.\" 	free copyright
.\" 	[1994/06/23  20:21:00  fred]
.\"
.\" Revision 1.1.2.6  1994/06/23  18:38:51  fred
.\" 	free copyright
.\" 	[1994/06/22  19:07:57  fred]
.\" 
.\" Revision 1.1.2.5  1993/06/14  15:02:53  bowe
.\" 	Minor edits for Noreen.
.\" 	[1993/06/14  15:02:30  bowe]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:06:29  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:02:00  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:35:35  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:32:32  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:04:05  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:56:53  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
.TH "Interface Template"
.SH "NAME"
\*LInterface Reference Page Description\*O - Describes the 
interface reference page structure and content
.P
The \*LName\*O section contains the name of the interface or 
system service function in bold,
a dash, and a short statement of its purpose.  
Include a space before and after the dash.
Begin the statement with an active initial-capped verb. 
Do not include an ending period.
.P
It is important that you keep the purpose statement as succinct as possible
because some commands and tools use this line as input.
For this reason, do not include anything other than a description
in \*LName\*O.  For example, for dummy reference pages 
(that is, pages that refer the reader to other reference pages for specific
information), add a \*LDescription\*O section for the "See" reference 
and include a brief description in \*LName\*O. 
.P
Likewise, for reference pages that describe a command not in OSF/1,
add a \*LDescription\*O section that includes the statement "This command 
does not exist for OSF/1 . . ." and refer the reader to the 
appropriate OSF/1 reference.
.P
If the reference page describes more than one interface, include all
the interface names.
However, try to avoid combining reference pages.  Use dummy pages instead.
.SH "LIBRARY"
The \*LLibrary\*O section contains the name of the library (if any) 
in which the interface or function resides. Use the following form:
.sp
\*VName of Library\*O (\*Lsystem name\*O)
.SH "SYNOPSIS"
The \*LSynopsis\*O section contains the synopsis diagram.  
See section XXXX for information on formatting synopsis diagrams.
.SH "PARAMETERS"
The \*LParameters\*O section contains a list of the parameters that 
appear in \*LSynopsis\*O, 
with a description of each argument's use in the interface or
function.  The description should be initial-capped, with no trailing
period. 
.P
List parameters in the order they are listed in \*LSynopsis\*O.
.P
Include argument specification rules and restrictions in this section.   
When an argument references a data type/data structure definition, 
provide a pointer to the definition in the text.
.P
Because \*LParameters\*O is used most 
frequently for quick reference,
make this section as concise as possible.  If a topic requires
more complete discussion, included the discussion in 
\*LDescription\*O or \*LNotes\*O, depending on its scope.
.P
.SS "Header Files and Data Structures
.P
Replace \*LParameters\*O with a section entitled \*LFields\*O.  In 
\*LFields\*O list the fields included in \*LSynopsis\*O and follow each with
a brief description.  
Follow the formatting guidelines listed in \*LParameters\*O. 
.SH "DESCRIPTION"
Begin the \*LDescription\*O section with a concise 
description of the purpose of the interface or function.  
The initial sentence should be an expansion
of the short statement included in \*LName\*O. 
Follow the initial description with details of the function's
use.
.P
Also use the \*LDescription\*O section to expand information provided
in other sections.
Some of this information may overlap with other 
sections on the current reference page.
.P
Use subheadings in \*LDescription\*O if necessary.
.SH "EXAMPLES"
The \*LExamples\*O section contains sample code, 
with a brief description of what the sample
illustrates.  If necessary, include multiple examples to demonstrate different
uses or strategies.  Include inline comments as appropriate.  
Code samples are formatted in a constant-width font.  
.SH "NOTES"
The \*LNotes\*O section contains any supplementary 
information that is peripheral to the
actual operation of the interface or function.    This section
is optional.
.SH "CAUTIONS"
The \*LCautions\*O section contains information on possible
system damage or data corruption
that may occur as a result of using the interface in a specific
implementation.
.SH "RETURN VALUE"
The \*LReturn Value\*O section contains a list of the possible return values, 
with brief descriptions of their meanings.
Keep this section as concise as possible.  If a return value  requires
more complete discussion,  include this discussion in 
\*LDescription\*O or \*LNotes\*O, depending on its scope.
.SH "ERRORS"
The \*LErrors\*O section contains a list of the error conditions 
under which the interface
or function will fail to complete successfully, and the value of
\fBerrno\fR associated with each.
.P
List the error codes in a variable list. Bold the code names, but do
not enclose them in brackets.
.SH "FILES"
The \*LFiles\*O section contains a list of the file dependencies.  
These are the files required by the interface.  
Provide locations as well as file names.
.SH "RELATED INFORMATION"
The \*LRelated Information\*O section contains references to 
related information organized into subgroups. 
This section also includes related OSF/1 documents, 
other related documents, and
miscellaneous information related to the command.
The following basic subgroups are used in the \*LRelated Information\*O
section; use only the groups that apply:
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
using bold for both the section number and the parenthesis. Separate
the reference pages with a comma. Do not include \*Vand\*O between the last
two pages in the list and do not include a period at the end of the list.
.P
Include name of the reference page, even if it is not the
same as the command you refered to in text. For example, include
\*Lscanf(3)\*O as opposed to \*Lfscanf(3)\*O.
