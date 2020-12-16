...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\" @OSF_FREE_COPYRIGHT@
...\" 
...\" HISTORY
...\" $Log: toc-post2.mm,v $
...\" Revision 1.1.2.5  1994/06/24  15:49:07  fred
...\" 	free copyright
...\" 	[1994/06/24  15:40:33  fred]
...\"
...\" Revision 1.1.2.4  1994/06/23  18:42:18  fred
...\" 	free copyright
...\" 	[1994/06/22  20:12:32  fred]
...\" 
...\" Revision 1.1.2.3  1993/04/10  00:38:26  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  00:33:46  bowe]
...\" 
...\" Revision 1.1.2.2  1992/07/06  20:17:34  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  20:09:36  bowe]
...\" 
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/toc-post2.mm,v 1.1.2.5 1994/06/24 15:49:07 fred Exp $
...\"
...\"  toc-post2.mm -- toc processing
...\"
'po .8i
...\"
...\"  page footer stuff
.if \n(|P=1 .ds |P Contents
.nr N 0
.de TX
.rm }b
.|C "(;g" ""
..
.af P i
...\"
.TZ			\" draft callout to set page number
...\"
...\"	fake out TC to know that we have tables and figures....
...\".nr !0 1		\" figures (jko set in $syncFile.tables)
...\".nr !1 1		\" tables  (jko set in $syncFile.figures)
...\"
.nr @! 1
.nr !_ 1\"	inhibit running head on 1st page
...\"
...\"
...\"	call the table of contents
.TC 2 1 3 0
