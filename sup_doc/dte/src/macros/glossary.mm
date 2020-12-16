...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\" @OSF_FREE_COPYRIGHT@
...\" 
...\" HISTORY
...\" $Log: glossary.mm,v $
...\" Revision 1.1.2.5  1994/06/24  15:48:11  fred
...\" 	free copyright
...\" 	[1994/06/24  15:38:09  fred]
...\"
...\" Revision 1.1.2.4  1994/06/23  18:41:21  fred
...\" 	free copyright
...\" 	[1994/06/22  20:08:20  fred]
...\" 
...\" Revision 1.1.2.3  1993/04/10  00:37:43  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  00:32:32  bowe]
...\" 
...\" Revision 1.1.2.2  1992/07/06  20:14:48  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  20:06:03  bowe]
...\" 
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/glossary.mm,v 1.1.2.5 1994/06/24 15:48:11 fred Exp $
...\"
...\"	glossary.mm -- glossary formatting macros
...\"
...\"	special formatting stuff to be used before a glossary
...\"
'fl
...\"
...\"	let's give this thing a title
...\"
...\".nr !_ 1
.pn 1
.OP
.af H1 1
.ds !! Glossary
.nr P 1
.af P 1
.nr N 3
.if \n(|P=1 .ds |P Glossary
...\"
.|C "P" "GL"
...\"
.nr !_ 0
...\"
