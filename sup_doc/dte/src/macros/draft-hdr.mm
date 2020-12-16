...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\" @OSF_FREE_COPYRIGHT@
...\" 
...\" HISTORY
...\" $Log: draft-hdr.mm,v $
...\" Revision 1.1.2.6  1994/06/24  15:48:04  fred
...\" 	free copyright
...\" 	[1994/06/24  15:37:57  fred]
...\"
...\" Revision 1.1.2.5  1994/06/23  18:41:12  fred
...\" 	free copyright
...\" 	[1994/06/22  20:07:35  fred]
...\" 
...\" Revision 1.1.2.4  1993/04/10  00:37:38  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  00:32:22  bowe]
...\" 
...\" Revision 1.1.2.3  1992/07/15  17:36:48  bowe
...\" 	Fill empty file (really initial rev).
...\" 	[1992/07/15  17:35:51  bowe]
...\" 
...\" Revision 1.1.2.2  1992/07/06  19:21:49  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  19:18:41  bowe]
...\" 
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/draft-hdr.mm,v 1.1.2.6 1994/06/24 15:48:04 fred Exp $
...\"
...\"	draft-hdr.mm  --  header information for draft formatting
...\"
...\" SHOW DRAFT MODE:
.nr |D 1
...\"
...\" define the width of the scanning column
.nr !! .5i		\" 1/2 inch
...\"
...\" heading style changes
...\"
.ds HF 3 3 3 3 3 3 3
.ds HP 20 16 14 12 11 11 11
.nr Hs 4
.nr Hb 4
.nr Cl 3
.nr !$ 20	\" H1 size
.nr Ej 1	\" eject for level 1's
...\"
...\" turn off hyphenation because it doesn't work
...\"
.nr Hy 0
.nh
...\" some other arbitrary defs
...\"
.nr !@ 11	\" point size default
...\"
...\" enlarge some margins
.VM "" 1
.BS
.sp 1
.BE
...\"
...\"  indicate that we're within a book-format:
...\"
.nr |Z 1
...\"
