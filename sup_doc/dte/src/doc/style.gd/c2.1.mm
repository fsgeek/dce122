...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c2.1.mm,v $
.\" Revision 1.1.2.6  1994/06/24  15:14:45  fred
.\" 	free copyright
.\" 	[1994/06/23  20:20:36  fred]
.\"
.\" Revision 1.1.2.5  1994/06/23  18:38:37  fred
.\" 	free copyright
.\" 	[1994/06/22  19:07:03  fred]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:05:44  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:01:41  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:35:25  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:32:16  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:03:35  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:56:29  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
.H 1 "Structural Elements of OSF Documentation"
This chapter details the specifications for the structural elements
required in OSF documentation offerings, and the order in which the
information is to appear.  In general, all OSF documents will conform
to these specifications.  When a document does not conform to the
specifications, the rationale for nonconformance will be published in
the document specification plan.  Additionally, we will use these
specifications to evaluate source documentation submitted by
technology suppliers when planning OSF documentation projects, and
when estimating required resources and developing schedules.
.P
This chapter also includes specifications for using and formatting tables, and
describes how to write and format reference pages.

.H 2 "Software User Documentation Specifications"
The specification requirements in this section apply to documentation
that describes how to install, operate, and manage software.  Table
2-1 shows the components that are required in all software user
documentation and the order in which they appear.  Most components are
required in all volumes of a multivolume documentation set.
.DS
.TB "Inclusion Requirements for User Documents"
.TS
center,box,tab(@);
lB | lB | lB  
lB | lB | lB  
l | c | c. 
\^@First or Only@Other 
Component@Volume@Volume
_
Title Page@M@M
Copyright Page@M@M
\0\0Restrictions@M@M
\0\0Warranties@R@R
\0\0Acknowledgements@M@M
Contents@M@M
\0\0List of Illustrations@M@M
\0\0List of Tables@M@M
Preface@M@R
\0\0Audience@M@M
\0\0Applicability@M@M
\0\0Purpose@M@R
\0\0Document Usage@M@R
\0\0Related Documents@R\u\s-21\d\s0@R
\0\0Typographic and@@
\0\0\0\0Keying Conventions@M@M
\0\0Problem Reporting@M@R
Document Body@X@X
...\"T{
...\"Error Messages and Software Problems
...\"T}@R@R
Appendixes@O@O
Glossary@M@M\u\s-2\2\d\s0
Index@M@M\u\s-2\2\d\s0
.TE
.P
.B "Notes to Table:"
.VL .5i
.LI "M"	
Must be included when the information exists
.LI "O"	
Optional.
.LI "R"
Reference; include within the volume or reference another document 
that contains the information.
.LI "X"
See section 2.1.6 for more information about this component.
.LI "\u\s-2\1\d\s0"
Addresses relationship to other volumes.
.LI "\u\s-2\2\d\s0"
Must be included in at least one volume; use references 
to the component in other volumes.
.LE
.DE
.H 3 "Title Page"
The title page consists of the following elements:
.BL
.LI
Document name
.LI
Version or revision
.LI
OSF address
.LE
.H 3 "Copyright Page"
The copyright page consists of the following elements:
.VL 1i
.LI "Restrictions"
Include the document's copyright notice(s), limitations that apply to the use or reproduction of the document or software, 
and product trademarks.
.LI "Warranties"
Include warranties, disclaimers, and contractual obligations that apply to the document or software.
.LI "Acknowledgments"
.br
Include references to the technology suppliers and document titles that are the sources of the OSF document. Acknowledge all trademarks of other companies that
appear in a document.
.LE
.H 3 Contents
The table of contents includes these elements:
.BL
.LI
Entries to the third level of the document structure hierarchy
.LI
A page number for every entry
.LI
Leader strings connecting entries and page numbers
.LE
.H 3 " Lists of Illustrations and Tables"
Lists of illustrations and tables include these elements:
.BL 
.LI
Number and title of each illustration and table
.LI
Page numbers for each illustration and table
.LI
Leaders strings and connecting entries and page numbers
.LE
.H 3 "Preface"
The Preface describes the following:
.VL 1i
.LI "Audience" 
Specifies the experience level and previous training expected of the reader.
.LI "Applicability"  
Identifies the software product (including version number) to which this 
document applies.  Includes, if relevant, information about the software and hardware environment required to use this software.
.LI "Purpose" 
Explains why the document was written and summarizes what the 
information provides for the audience.
.LI "Document Usage"  
.br
Briefly describes the contents of each major section, its intended use, and relationship to other sections.
.LI "Related Documents"  
.br
Lists the other documents in the documentation set and any other documents 
referenced in text.
.LI "Typographical and Keying Conventions"  
.br
Describes the stylistic, typographic, keying, and command syntax conventions used 
in the document.
.LI "Problem Reporting" 
.br
Describes how to report problems with the documentation or software.  Provides a contact and method for problem reports or suggestions for improvement.
.LE
.H 3 "Document Body"
A document's type determines the kind of imformation that appears in the body of the document.  There are three document types:
.BL
.LI
Information-oriented documents provide models, algorithms, tutorials, and background information that contribute to the user's understanding of the software.
For example, the \*(Id.
.LI
Task-oriented documents provide step-by-step procedures for achieving specific goals.
For example, the \*(SV.
.LI
Reference documents present comprehensive information organized to facilitate random access.
For example, the \*(Rc.
.LE
.P
OSF documentation plans specify the document type(s).  Several document types can occur together within a single or multivolume manual.  In such cases, the document types are clearly separated.
.H 4 " Information-Oriented Documents"
These documents organize information by major topics and subtopics.  
For example, a software architecture manual might contain the following topics:
.BL
.LI  
Overview of functionality
.DL
.LI
Supported applications
.LI
Supported languages
.LE
.LI
Major subsystem 1
.DL
.LI
Component A
.LI
Component B
.LE
.LI
Major subsystem 2
.LE
.P
Information-oriented documents contain a statement of scope that 
defines the limits or boundaries of the information covered.  This statement can appear at the beginning of the entire document, or when appropriate, can introduce each major subdivision of the document.
.P
This document type gives the user information required to understand the software \(em
what it can and cannot do and the goals it supports.  Clear and unambiguous examples 
reinforce the discussion.
.H 4 "Task-Oriented Documents"
This document type supports the user in carrying out specific goals.  It organizes information around task groups performed together and/or in sequence.
.P
A task-oriented document contains the following components organized in 
an order appropriate to the task(s):
.VL 1i
.LI "Statement of scope" 
Indicates the scope of the tasks to be described.
.LI "Pointers" 
Provide references to associated information-oriented documents.
.LI "Materials"  
Describes all materials that the user needs to perform the task.
.LI "Preparation"  
Describes technical or administrative actions that must be 
performed before the task can be started.
.LI   "Notes"
Contain information of special importance to the reader,
formatted apart from the text to call the reader's attention to the
information.
.LI "Cautions"  
Contain information the reader needs to know to avoid
damaging the software.  Cautions appear on the same page as, and
immediately before, the action that requires a caution.
.LI "Method"  
Describes each task including commands that the user issues; the system functions invoked; system responses that indicate normal termination; expected results with examples of successful completion; possible error conditions; and how to avoid and recover from errors.
.LI "Related information"  
.br
Provides additional information about other tasks that can be supported by the methods described, tasks that are frequently performed together and their relationship, and any limitations or constraints that apply to the methods described.
.LE
.H 4 "Reference Documents"
Reference documents in a set are organized by software function.
For example, the \*(Rs and the \*(Ra.
.P
Individual reference documents consist of the following components:
.VL 1i
.LI "Introduction"  
Briefly describes the commands and calls described in the
document  and provides any necessary background information.
.LI "Reference pages"  
.br
Organized alphabetically within chapters.  
Chapters represent functional groups of commands or calls.
Each chapter includes an introduction that briefly describes the 
commands or calls in the chapter.  
Some reference documents may contain only one or two chapters.
.LE
.P
The components of individual reference pages vary.  See sections
2.4 and 2.5 for details about writing and formatting reference pages.  
...\".H 3 "Error Messages and Software Problems"
...\"Error messages are described in an easily accessed location 
...\"such as an appendix, or separate chapter.  
...\"For each message, describe the condition that causes it, 
...\"recovery procedures, and the actions required to clear it.
...\".P
...\"Describe known software problems with their error 
...\"messages and error recovery methods, and provide alternate methods 
...\"for accomplishing a task.  
...\"Documentation for software problems and error messages 
...\"can appear with the software command function, or in a separate reference volume.
.H 3 "Appendixes"
Appendixes contain supporting material that 
does not belong in the main body of the text.  
Appropriate material for appendixes includes, but is not limited to the following:
.BL
.LI
Descriptions of data formats and file structures
.LI
Input and output codes; for example, character conversion codes
.LI
Global processing limitations
.LI
Sample files, reports, or programs
.LE
.H 3 "Glossary"
The elements of a glossary are as follows:
.BL
.LI
Specialized words used in the body of the document
.LI
A descriptive phrase that provides a definition of each term
.LI
An optional, brief expanded definition of the term
.LI
Synonyms of words used in the text with a \fISee\fR or \fISee also\fR cross-reference to the main glossary entry
.LE
.P
See section XXXX for a detailed description of glossaries.
.H 3 "Index"
The index consists of the following elements:
.BL
.LI
Important words from the text and their location references
.LI
Concepts, synonyms, or paraphrases that are related to the main index entries and their location references
.LI
Symbols used in the text with location references
.LE 
.P
Location references are page numbers, section or paragraph numbers, illustration numbers, or another index entry.   
.H 2 "Software Development Documentation Specifications "
The specification requirements in this section apply to documentation
that describes how to develop, modify, and port software to specific
platforms.  Some examples of such documentation are coding style
guides, programmer's reference manuals, and software porting guides.

\fBEditor's Note:\fR The specifications defined in Section 2.1 and listed Table
2-1 apply the the documention described in this section.  Because ther
are additional and different types of information required for software 
development documentation, which are to be described in this section, we
are looking for an IEEE (or other) standard that provides these specifications.
If you  can suggest a source that will help us develop this section,
please contact the documentation group at OSF.
.H 2 "Guidelines for Formatting Tables"

The following sections describe OSF's guidelines for 
formatting tables.
.H 3 "Introducing Tables in Text"
Introduce tables with a complete sentence.  Do not use an incomplete sentence
with a colon.  For example:
.sp
.DS I
\fIUse\fR
.sp
The flags specified by this function are described in Table 1-1.
.sp
\fIDo not use\fR
.sp 
Flags specified by this function are
.DE
.H 3 "Formatting Table Titles
Table titles are formatted as follows:
.BL
.LI
Table titles are the same typeface as text.
Do not use typographic conventions in table titles, because 
these cause the list of tables in the table of contents to
format incorrectly.
.LI
The word "table" is  bold and all capital letters.
.LI
.B TABLE 
is followed by the chapter number or the
appendix letter, a hyphen, and the table number.
.LI
The table number is followed by a period to separate it
from the title of the table.
.LI
Table titles are initial caps, except for articles
and so forth (see Chapter 3 for the rules
on capitalization).
.LI
Table titles are centered above the tables.
.LE
.TB "Example Table Title"
.TS 
center,tab(@),box;
lb|lb|lb
l | l | l.
\*LFormal Name@Informal Name@Languages Covered\*O
_
.TH 
ISO 8859/1@Latin-1@Western European
ISO 8859/2@Latin-2@Eastern European
ISO 8859/3@Latin-3@Southeastern European
ISO 8859/4@Latin-4@Northern European
ISO 8859/5@Latin-5@English & Cyrillic-Based
ISO 8859/6@Latin-6@English & Arabic
ISO 8859/7@Latin-7@English & Greek
ISO 8859/8@Latin-8@English & Hebrew
ISO 8859/9@Latin-9@Western European & Turkish
.TE
...\".DS "" F
...\".TB "Series Model xxxx/Model yyyy  Physical Memory Allocated 
...\"for System-Supplied Devices"
...\".TS
...\"center,box,tab(@);
...\"lB | lB
...\"l | lw(45n).
...\"Physical Address (Hex)@Device
...\"_
...\"000000-03FFFF@Reserved for the System
...\"040000-05FFFF@I/O Address Space 
...\"080000-09FFFF@Available for Customer Devices
...\"0A0000-0BFFFF@Color or Alternate Monochrome Graphics
...\"0C0000-0DFFFF@T{
...\"Alternate Monochrome Graphics or Token
...\"Ring (0D0000-0DFFFF)
...\"T}
...\"0E0000-0FFFFF@T{
...\"Alternate Color Graphics or Alternate or
...\"Second Single-Board Ring (0E0000-0EFFFF)
...\"T}
...\"100000-8FFFFF@Main Memory
...\".TE
...\".DE
.H 3 "Formatting Column Heads"
.P
Use the following guidelines for formatting column heads:
.BL
.LI
Use the same typeface as the text for column heads.  Bold the
column heads.
.LI
For tables with single-column heads 
place the column head and 
carryover lines flush left
(see step 4 for tables with multiple-column heads) .
.LI
Stack column heads when doing so will reduce the 
width of the columns (see the following example).
.TS
center,box,tab(@);
lB | lB | lB | lB
lB | lB | lB | lB
l | c | c | l.
DMA@DMA@8- or 16-Bit@
Request No.@Priority@Transfer@Function
_
DRQ0@1@8@User Device
DRQ1@2@8@Tape Drive or User Device
DRQ2@3@8@Floppy Dive or User Device
DRQ3@4@8@User Device
DRQ4@\(em@\(em@Cascade for Channels 0-3
DRQ5@5@16@User Device
.TE
.LI
For tables with multiple-column heads, center the top column heads
and place the bottom column
heads flush left (see the following example).
.P
For tables with more than two levels of heads,
center the top level heads and place the
lowest level heads flush left over the
data in their columns.
.LI
When single-column heads are used with multiple-column heads
in the same table, place the single-column head flush left
at the baseline of the ruled block 
area that encloses the single-column head (see the first column 
in the following example).
.TS
center,box,tab(@);
lB | cB s | cB s
lBd | lB | lB | lB3 | lB
lBd | lB | lB | lB3 | lB
c | n | n | l | 1.
\^@Size in Bits@Decimal Number Range of Values
_
Address@
Type@Subnet@Host@Subnet Portion@Host Portion
_
A 1@8@16@1-255@0.1-255.254
A 2@16@8@0.1-255.255@1-254
.sp
B 1@8@8@1-255@1-254
B 2@12@4@1-255@1-240
.sp
C@4@4@1-15@1-14
.TE
.LI
When a common unit of measure applies to all entries
in a column, abbreviate it or spell it enclosed in 
parentheses after the column head (see the following
example).
.LI
When units of measure are not common to all entries in a column,
include the appropriate unit of measure with each entry in the column
(see the rightmost column in the following example).
.TS
center,box,tab(@);
cB s s s | cB s 
lB | lB | lB | lB | lB | lB
lB | lB | lB | lB | lB | lB
c | c | c | c | l | l.
Rate Select@32.768 Time Base
_
@@@@Periodic Interrupt Rate@Square Wave 
RS3@RS2@RS1@RS0@(Microseconds)@Frequency
_
0@0@0@0@None@None
0@0@0@1@3.90625@256Hz
0@0@1@0@7.8125@128Hz
0@0@1@1@122.070@8.192kHz
0@1@0@0@244.141@4.096kHz
0@1@1@1@1.953125@512Hz
.TE
.LI
Repeat column heads when a table is continued onto one or more pages. 
.LE
.H 3 "Formatting Table Column Information"
Use the following guidelines for formatting information that appears
in the table columns:
.BL
.LI
Use the same typeface
as the text for information that appears in the 
table columns.
.LI
Follow the keying and typographic conventions when they apply.
.LI
Follow the guidelines for capitalization in Chapter 3
of this guide.
.LI
You can use abbreviations in tables, especially
when you have space limitations.
Abbreviations are not always translatable so 
define them in text before using them,
unless they are commonly used 
abbreviations (for example, standard units of measure).
You can also use notes to tables to define abbreviations used in tables.
.LI
Place column entries flush left under the column
heads unless you have entries that are three characters or less.  Center 
entries that are three characters or less under their column heads.  
...\"Indent carryover lines to 
...\"clearly show blocks of information that belong together
...\"(see the following example).
.LI
Use typographic and keying conventions in table columns as you would
in text.
.TS 
center, box, tab (@);
lb | lb |lb
lb | c | c.
Parameters@Before Call@After Call
_
fd@Y@N
buf@Y@(Y)
nbytes@Y@N
flags@N@Y
.TE
.LI
If you need to group several entries, 
use line spacing to distinguish the groups.  
(see the following examples).
.TS
center,box,tab(@);
lB | lB | lB  
lB | lB | lB  
l | c | c. 
\^@First or Only@Other 
Component@Volume@Volume
_
Title Page@M@M
Copyright Page@M@M
\0\0Restrictions@M@M
\0\0Warranties@R@R
\0\0Acknowledgements@M@M
Contents@M@M
\0\0List of Illustrations@M@M
\0\0List of Tables@M@M
.TE
.SP
.TS
center,box,tab(@);
lB | cB s | cB s
lBd | lB | lB | lB3 | lB
lBd | lB | lB | lB3 | lB
c | n | n | l | 1.
\^@Size in Bits@Decimal Number Range of Values
_
Address@
Type@Subnet@Host@Subnet Portion@Host Portion
_
A 1@8@16@1-255@0.1-255.254
A 2@16@8@0.1-255.255@1-254
.sp
B 1@8@8@1-255@1-254
B 2@12@4@1-255@1-240
.sp
C@4@4@1-15@1-14
.TE
.LI
Use em dashes (\(em) in columns that do not 
have information in them. This convention allows 
the reader to rapidly scan across
the table to columns that do contain
information (see the following example).
.TS 
center, box, tab(@);
lb | lb | lb
lb | lb | c.
XTI Function@Socket Function@Shared Semantics
_
t_accept@accept@No
t_alloc \*O(optional)@\(em@\(em
t_bind@bind@No
t_close@close@\(em   
.TE
.LE
.H 3 "Ruling Tables"
.P
Use the following guidelines for ruling tables:
.BL
.LI
Include  a horizontal rule under the column heads.
.LI
Use vertical rules to separate all of the columns
(see the following example).
.LI
Do not include a horizontal rule between each entry.
.LI
Rule footnotes, legends, and notes as part of
the table (see the following examples).
Use superscript numbers for table footnotes.
...\".LE
.TS
center,box,tab(@);
lB | lB | lB
l | l | l.
.SP .5
Key Name\u\s-31\s0\d@Description@Default Setting
_
.SP .5
\*Lddf_name\*O\u\s-32\s0\d@I/O device descriptor file@\*L/dev/device\*O
\*Ldevice_name\*O@I/O device name@\*L/dev/sio1\*O
\*Ldevice_speed\*O@Specified if port is an SIO line@1200
\*Lio_mode\*O\u\s-32\s0\d@Parallel@Serial
\*Lprinter_model\*O@T{
Specified if driver supports more than one model
T}@None
\*Lmon_name\*O\u\s-33\s0\d@T{
Device name of I/O port used by the monitor program
T}@None
\*Lmon_speed\*O\u\s-33\s0\d@T{
Specified if monitor I/O port is an SIO line
T}@None
.TE
.P
.B "Notes to Table:"
.sp
\u\s-31\s0\d Two-word "Key Names" are separated by a double underscore as shown.
.sp .4v
\u\s-32\s0\d Used only if the output port is a parallel port without a streams manager.
.sp .4v
\u\s-33\s0\d Used when the printer sends status information to a separate SIO channel.
.DS "" F
.TS
center,box,tab(@);
lB | lB | lB
lB | lB | lB
l | l | c. 
@@Bus Addressing
Physical Address@Allocation@Mode (Bits)
_
0-7FFF@Bus CSRs@16
800000-BFFFFF@User Bus Devices@24
1000000-2FFFFFF@User Bus Devices@32
4000000-FFFFFFFF@See NOTE@32
.TE
.P
.B "Note to Table:" 
.sp
The bus address range 4,000,000-FF,FFF,FFF
is reserved for bus controllers that want to
communicate with each other without interference 
from the processor. Programs cannot reference 
this address range.
.DE
.LI
Double rule run-on tables that repeat column heads (see
the following example).
.TS
center,box,tab(@);
lB | lB || lB | lB
c | l || c | l.
Pin No.@Signal@Pin No.@Signal
_
1@Ground@16@SIO2_DCD
2@SIO1_TXD@18@SIO2_DTR
3@SIO_RXD@9@SIO3_RXD
4@SIO1_RTS@10@SIO3_CTS
5@SIO1_CTS@19@SIO3_DTR
7@Inline Resistor@21@SIO3_TXD
8@SIO1_DCD@23@SIO3_RTS
.TE
.LI
Repeat column heads on all continuation pages of the table
