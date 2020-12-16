...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\" @OSF_FREE_COPYRIGHT@
...\" 
...\" HISTORY
...\" $Log: sync-post.mm,v $
...\" Revision 1.1.2.5  1994/06/24  15:48:58  fred
...\" 	free copyright
...\" 	[1994/06/24  15:40:14  fred]
...\"
...\" Revision 1.1.2.4  1994/06/23  18:42:09  fred
...\" 	free copyright
...\" 	[1994/06/22  20:11:42  fred]
...\" 
...\" Revision 1.1.2.3  1993/04/10  00:38:19  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  00:33:34  bowe]
...\" 
...\" Revision 1.1.2.2  1992/07/06  20:17:02  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  20:08:47  bowe]
...\" 
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/sync-post.mm,v 1.1.2.5 1994/06/24 15:48:58 fred Exp $
...\"
...\"	sync-post.mm -- synchronizer trailer file for -mm
...\"
.if \n(!"=1 .nr H1 -1\"	don't count the preface
.ds @1 \g(H1
.ds @2 \g(H2
.ds @3 \g(H3
.ds @4 \g(H4
.ds @5 \g(Fg
.ds @6 \g(Tb
.ds @7 \gP
.af H1 1
.af H2 1
.af H3 1
.af H4 1
.af Fg 1
.af Tb 1
.af P 1
.tm !SYNC: "\nP" "\n(H1" "\n(H2" "\n(H3" "\n(H4" "\n(Fg" "\n(Tb"
.af H1 \*(@1
.af H2 \*(@2
.af H3 \*(@3
.af H4 \*(@4
.af Fg \*(@5
.af Tb \*(@6
.af P \*(@7
