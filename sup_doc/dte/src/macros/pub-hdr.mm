...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\" @OSF_FREE_COPYRIGHT@
...\" 
...\" HISTORY
...\" $Log: pub-hdr.mm,v $
...\" Revision 1.1.2.5  1994/06/24  15:48:45  fred
...\" 	free copyright
...\" 	[1994/06/24  15:39:29  fred]
...\"
...\" Revision 1.1.2.4  1994/06/23  18:41:57  fred
...\" 	free copyright
...\" 	[1994/06/22  20:10:43  fred]
...\" 
...\" Revision 1.1.2.3  1993/04/10  00:38:10  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  00:33:18  bowe]
...\" 
...\" Revision 1.1.2.2  1992/07/06  20:16:29  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  20:08:07  bowe]
...\" 
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/pub-hdr.mm,v 1.1.2.5 1994/06/24 15:48:45 fred Exp $
...\"
...\"	pub-hdr.mm  --  header information for book publishing
...\"
...\" SHOW PUBLISH (not Draft) MODE:
.nr |D 0
...\"
...\"
...\" 	Settings specific to OSF macro extensions
...\" 	=========================================
...\"
.nr !! 1i\" scanning column width
.nr !$ 30\" h1 point size
.nr !@ 13\" point size
...\"
...\"
...\"	Settings specific to -mm
...\"	========================
...\"
...\" heading style changes
...\"
.ds HF 1 3 3 1 1 1
.ds HP \\n(!$ 20 16 16 \n(!@
.nr Hb 6
.nr Hs 6
...\"
...\" turn off hyphenation because it doesn't work
...\"
...\" margin style changes
...\"
.VM "" 1
.BS
.sp 1
.BE
...\"
...\" turn off hyphenation because it doesn't work
...\"
.SA 1
.nr Hy 0
.nh
...\"
.nr Cl 3
...\"
...\"  indicate that we're within a book-format:
...\"
.nr |Z 1
...\"
