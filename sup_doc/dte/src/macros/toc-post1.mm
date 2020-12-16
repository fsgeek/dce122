...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\" @OSF_FREE_COPYRIGHT@
...\" 
...\" HISTORY
...\" $Log: toc-post1.mm,v $
...\" Revision 1.1.2.5  1994/06/24  15:49:05  fred
...\" 	free copyright
...\" 	[1994/06/24  15:40:30  fred]
...\"
...\" Revision 1.1.2.4  1994/06/23  18:42:17  fred
...\" 	free copyright
...\" 	[1994/06/22  20:12:23  fred]
...\" 
...\" Revision 1.1.2.3  1993/04/10  00:38:24  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  00:33:44  bowe]
...\" 
...\" Revision 1.1.2.2  1992/07/06  20:17:29  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  20:09:29  bowe]
...\" 
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/toc-post1.mm,v 1.1.2.5 1994/06/24 15:49:05 fred Exp $
...\"
...\"	toc-post1.mm  --  generate the table of contents.  This file is
...\"	the complement to toc-pre.mm and toc-middle.mm.
...\"
...\"	close the definition started in toc-middle.mm:
..
...\"
...\"	redefine the page exit macro for the toc banner
.de TY
.rs
.sp 3v
.ps \\n(!$
.vs \\n(!$
Contents
\s30\l'\\n(.lu'\s0
.vs \\n(!@
.ps \\n(!@
.rs
.sp 5v
.nr !_ 0
.PH ""
..
...\"
...\"  the following trick causes )w to inhibit the next page header--
...\"      we need this because TC is obsessive about starting new pages
...\"      when we can't control them....
...\"
.am )w
.nr !_ 1
..
...\"
...\"
.ds !! Contents
