...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\" @OSF_FREE_COPYRIGHT@
...\" 
...\" HISTORY
...\" $Log: index-pre.mm,v $
...\" Revision 1.1.2.7  1994/06/24  15:48:23  fred
...\" 	free copyright
...\" 	[1994/06/24  15:38:32  fred]
...\"
...\" Revision 1.1.2.6  1994/06/23  18:41:32  fred
...\" 	free copyright
...\" 	[1994/06/22  20:09:08  fred]
...\" 
...\" Revision 1.1.2.5  1993/05/14  18:22:45  fred
...\" 	fix test about when to output "See Also" message
...\" 	probably broken during master index work.
...\" 	[1993/05/14  18:22:26  fred]
...\" 
...\" Revision 1.1.2.4  1993/04/10  00:37:52  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  00:32:47  bowe]
...\" 
...\" Revision 1.1.2.3  1992/12/10  18:37:54  fred
...\" 	changes to implement the new master index
...\" 	[1992/12/10  18:37:15  fred]
...\" 
...\" Revision 1.1.2.2  1992/07/06  20:15:11  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  20:06:52  bowe]
...\" 
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/index-pre.mm,v 1.1.2.7 1994/06/24 15:48:23 fred Exp $
...\"
...\"	index formatting macros
...\"
...\"MACROS DEFINED
...\"iL text   
...\"iP text nr_subordinates 
...\"iS text nr_subordinates 
...\"iT text nr_subordinates 
...\"iQ text nr_subordinates 
...\"i# page_nr_text
...\"i: See_text
...\"i; See_Also_text
...\" .iL is called between letters of the alphabet
...\" .iP is called for the primary level of an entry
...\" .iS,T,#,:,; called for secondary, tertiary, page numbers, etc
...\" .iS and .iT .iQ entries always appear (they may be null). Null entries
...\" are included in the number of subordinate counts. We take pains to
...\" merge lines when only one entry at a given level apears.
...\" Number registers used:
...\" ip Indentation of primary entries
...\" is Indentation of secondary entries
...\" it Indentation of tertiarys entries
...\" il 2 if next entry is first secondary in its primary
...\"    3 .... first tertiary in its secondary
...\"    4 .... first reference text in its tertiary
...\" in Number of peers of at current level 
...\"
...\"
.de iL
.nr ip 1i
.if !\\$1 \{\
.	fl
.	sp 4v
.	ne 1.25i
.	in \\n(ipu-.5i	\" do indent
\s30\&\\$1\s0
.	sp 1
'	br \}
..
...\"
...\"
.de iP
'ne 4v
.br
.in \\n(ipu
.ti -.5i
\&\\$1\c
.nr il 2
.nr in \\$2
..
...\"
...\"
...\"
.de iS
.if !\\$1 \{\
.	ie (\\n(il==2)&(\\n(in==1) \{\
.		nr sp \\n(ip
, \c
'		br \}
.	el \{
.		br
.		nr sp \\n(ip+.5i
.		in \\n(spu
.		ti -.5i
'		br \} 
'	ne 2v
\&\\$1\c
'	br \}
.nr il 3
.nr in \\$2
..
.de iT
.if !\\$1 \{\
.	ie (\\n(il==3)&(\\n(in==1) \{\
.		nr tp \\n(sp
, \c
'		br \}
.	el \{
.		br
.		nr tp \\n(sp+.5i
.		in \\n(tpu
.		ti -.5i
'		br \} 
'	ne 2v
\&\\$1\c
'	br \}
.nr il 4
.nr in \\$2
..
.de iQ
.if !\\$1 \{\
.	ie (\\n(il==4)&(\\n(in==1) \{\
.		nr qp \\n(tp
, \c
'		br \}
.	el \{
.		br
.		nr qp \\n(tp+.5i
.		in \\n(qpu
.		ti -.5i
'		br \} 
'	ne 2v
\&\\$1\c
'	br \}
.nr il 5
..
.de i#
, \\$1\c
..
.de i:
\&. \fISee\fR \\$1
.nr il 5
..
.de i;
.ie \\n(il<6 \{\
.	br 
\fISee also\fR\}
.el ; \c
\&\\$1\c
.nr il 6
..
...\"
...\"
...\"	let's give this thing a title
...\"
...\".nr !_ 1
.pn 1
.OP
.ie \n;=0 .ds !! Index
.el .ds !! Master\ Index
.nr P 1
.af P 1
.nr N 3
.if \n(|P=1 \{\
.	ie \n;=0 .ds |P Index
.	el .ds |P Master\ Index
'	br \}
...\"
.|C "P" "Index"
...\"
.rs
.sp 2v
.in 0
.ie \n;=0 \s30Index\s0
.el \s30Master\ Index\s0
\s30\l'\n(.lu'\s0
.sp 5v
.nr !_ 0
.SP 2
...\"
...\"
.ie \n;=0 \{\
.	2C		\" not master index mode -- use 2 columns
.	nr !~ \n(!@-1	\" step down point size
'	br \}
.el \{\
.	nr !~ \n(!@	\" keep regular point size
'	br \}
.S \n(!@
...\"
.nh			\" NO hyphenation
.na			\" no justification
