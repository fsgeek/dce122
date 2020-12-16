...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\" @OSF_FREE_COPYRIGHT@
...\" 
...\" HISTORY
...\" $Log: nonbook.mm,v $
...\" Revision 1.1.2.5  1994/06/24  15:48:27  fred
...\" 	free copyright
...\" 	[1994/06/24  15:38:39  fred]
...\"
...\" Revision 1.1.2.4  1994/06/23  18:41:36  fred
...\" 	free copyright
...\" 	[1994/06/22  20:09:23  fred]
...\" 
...\" Revision 1.1.2.3  1993/04/10  00:37:55  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  00:32:52  bowe]
...\" 
...\" Revision 1.1.2.2  1992/07/06  20:15:29  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  20:07:26  bowe]
...\" 
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/nonbook.mm,v 1.1.2.5 1994/06/24 15:48:27 fred Exp $
...\"
...\"  nonbook.mm  --  change the draft look into a non-book style
...\"
...\"
.nr Ej 0
...\"
...\" heading style changes
...\"
.ds HF 3 3 3 3 3 3 3
.ds HP 16 14 12 11 10 10 10
.nr Hs 4
.nr Hb 4
...\"
...\"
.de HX
.SP 2v
.ie \\$1>1 \{\
.	ie \\$1=2 .vs 16		\" pick a vertical spacing for header
.	el .ie \\$1<5 .vs 14
.	el .vs 12
'	br \}
.el \{\
.	vs 20
'	br \}
.in 0				\" header always at left margin
'ne 3v				\" needs enough following text
..
...\"
.rm HY
...\"
.de HZ
.SP .5v
..
.EF "''\- \\\\nP \-''"
.OF "''\- \\\\nP \-''"
...\"
...\" remove book specific macros
...\"
.rm iX gL )E )F
