...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\" @OSF_FREE_COPYRIGHT@
...\" 
...\" HISTORY
...\" $Log: ptx.mm,v $
...\" Revision 1.1.2.6  1994/06/24  15:48:40  fred
...\" 	free copyright
...\" 	[1994/06/24  15:39:20  fred]
...\"
...\" Revision 1.1.2.5  1994/06/23  18:41:51  fred
...\" 	free copyright
...\" 	[1994/06/22  20:10:21  fred]
...\" 
...\" Revision 1.1.2.4  1993/04/10  00:38:05  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  00:33:11  bowe]
...\" 
...\" Revision 1.1.2.3  1992/08/04  21:10:52  fred
...\" 	change line length hack from 6.2i to 5.5i to force permuted
...\" 	indices to come out closer to the left margin.  -fld
...\" 	[1992/08/04  21:10:17  fred]
...\" 
...\" Revision 1.1.2.2  1992/07/06  20:16:10  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  20:07:55  bowe]
...\" 
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/ptx.mm,v 1.1.2.6 1994/06/24 15:48:40 fred Exp $
...\"
...\"	ptx.mm  --  permuted index macro extensions to the "standard"
...\"				-mptx stuff.
...\"
...\"	let's give this thing a title
...\"
.af P i
.nr N 0
...\"
...\"
.H 1 "Permuted Index"
.if \n(|P=1 .if \*(|P .ds |P Permuted Index
...\"
...\"  downsize and use full page width
...\"
.nr !! 0
'in \\n(!!u
.nr !~ -3
.ps \n(!~
...\".nr !~ +1
.vs \n(!~
...\"
...\"
.nf
.nr L 5.5i    \" decrease the line length to decrease the apparent left margin
.ll \nLu
.nr)y \n(.lu-.65i
.nr)x \n()yu/2u
