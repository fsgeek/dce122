...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\" @OSF_FREE_COPYRIGHT@
...\" 
...\" HISTORY
...\" $Log: sync-pre.mm,v $
...\" Revision 1.1.2.5  1994/06/24  15:49:02  fred
...\" 	free copyright
...\" 	[1994/06/24  15:40:22  fred]
...\"
...\" Revision 1.1.2.4  1994/06/23  18:42:13  fred
...\" 	free copyright
...\" 	[1994/06/22  20:12:04  fred]
...\" 
...\" Revision 1.1.2.3  1993/04/10  00:38:21  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  00:33:39  bowe]
...\" 
...\" Revision 1.1.2.2  1992/07/06  20:17:14  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  20:09:08  bowe]
...\" 
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/sync-pre.mm,v 1.1.2.5 1994/06/24 15:49:02 fred Exp $
...\"
...\"	sync-pre.mm -- synchronizing header file for -mm
...\"
...\"	Set heading levels:
...\"
.nr H1 \n!		\" use ! reg (passed from command line)
.nr H2 \n#		\" use # reg (passed from command line)
.nr H3 \n$		\" use $ reg (passed from command line)
.nr H4 \n^		\" use ^ reg (passed from command line)
...\"
...\"
...\"	Set page number:
...\"
.nr P \n@		\" use @ reg (passed from command line)
...\"
...\"
...\"	set figures and table registers
...\"
.nr Fg \n_	\" set fig # from cmd line reg
.nr Tb \n=	\" set from cmd line reg
...\"
...\"
...\" .iX  --  Index Macro outputs count, page nr, args via .tm
...\"
...\"
.de iX
.ds !# \\gP
.af P 1
.nr !# \\nP
.af P \\*(!#
.ie \\n(.$>4 \{\
.	tm .iX: too many (\\n(.$) arguments:  "\\$1" "\\$2" "\\$3" "\\$4" "\\$5"
.	nr !~ 4		\" only use 4 args..
'	br \}
.el .nr !~ \\n(.$
.ie \\*(!#0 \{\
.	ie \\n(H1>9 \{\
.		ie \\n(!#>99 .tm !INDEX: \\n(!~ \\n(H1\(mi\\nP \\$1 
.		el .ie \\n(!#>9 .tm !INDEX: \\n(!~ \\n(H1\(mi0\\nP \\$1
.		el .tm !INDEX: \\n(!~ \\n(H1\(mi00\\nP \\$1
'		br \}
.	el \{\
.		ie \\n(!#>99 .tm !INDEX: \\n(!~ 0\\n(H1\(mi\\nP \\$1 
.		el .ie \\n(!#>9 .tm !INDEX: \\n(!~ 0\\n(H1\(mi0\\nP \\$1
.		el .tm !INDEX: \\n(!~ 0\\n(H1\(mi00\\nP \\$1
'		br \}
'	br \}
.el \{\
.   ie \\n(!#>99 .tm !INDEX: \\n(!~ \(mi\\nP \\$1 
.   el .ie \\n(!#>9 .tm !INDEX: \\n(!~ \(mi0\\nP \\$1
.   el .tm !INDEX: \\n(!~ \(mi00\\nP \\$1
'   br \}
.if \\n(!~>1 .tm !INDEX: \\$2
.if \\n(!~>2 .tm !INDEX: \\$3
.if \\n(!~>3 .tm !INDEX: \\$4
..
...\"
...\"	put headings into the sync file so that we can perhaps use
...\"	them in sync'ed sections
...\"
.am H
.tm !H\\$1: "\\$2"
..
...\"
