...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\" @OSF_FREE_COPYRIGHT@
...\" 
...\" HISTORY
...\" $Log: toc-pre.mm,v $
...\" Revision 1.1.2.5  1994/06/24  15:49:09  fred
...\" 	free copyright
...\" 	[1994/06/24  15:40:36  fred]
...\"
...\" Revision 1.1.2.4  1994/06/23  18:42:20  fred
...\" 	free copyright
...\" 	[1994/06/22  20:12:42  fred]
...\" 
...\" Revision 1.1.2.3  1993/04/10  00:38:27  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  00:33:49  bowe]
...\" 
...\" Revision 1.1.2.2  1992/07/06  20:17:42  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  20:09:41  bowe]
...\" 
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/toc-pre.mm,v 1.1.2.5 1994/06/24 15:49:09 fred Exp $
...\"
...\"	toc-pre.mm  --  header stuff so that we can generate a toc
...\"	from local .)T calls.   This def gets closed by the tocmac2.mm
...\"	file, which also calls the .TC macro.
...\"
...\"	This is the first - >C is used for regular entries
...\"
.de >C	\" macro that holds .)T calls for .H stuff
