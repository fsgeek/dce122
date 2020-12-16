...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\" @OSF_FREE_COPYRIGHT@
...\" 
...\" HISTORY
...\" $Log: sgref.mm,v $
...\" Revision 1.1.2.5  1994/06/24  15:48:51  fred
...\" 	free copyright
...\" 	[1994/06/24  15:40:02  fred]
...\"
...\" Revision 1.1.2.4  1994/06/23  18:42:03  fred
...\" 	free copyright
...\" 	[1994/06/22  20:11:06  fred]
...\" 
...\" Revision 1.1.2.3  1993/04/10  00:38:14  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  00:33:25  bowe]
...\" 
...\" Revision 1.1.2.2  1992/07/06  20:16:50  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  20:08:18  bowe]
...\" 
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/sgref.mm,v 1.1.2.5 1994/06/24 15:48:51 fred Exp $
...\"
...\"	sgref.mm -- settings invoked by using a "SGREF" directive in a
...\"				 Description file
...\"
...\"   This is used in the Motif Style Guide to produce a format very
...\"   specific to that book.
...\"
...\"   Specifics:
...\"
...\"    1. .H 2 "Reference Head"    contributes its title to each page's
...\"                                running head (like where man page
...\"                                titles show up).
...\"
...\"    2. .H 2 and .H 3 get their "section numbers" removed when they
...\"       appear in the running text.
...\"
...\"    3. Page eject before .H 1 *and* .H 2
...\"
...\"    4. only place level 1 and 2 heads in the TOC
...\"
...\"
.nr Ej 2          \" eject before level 1 and 2 heads
...\"
...\"
...\"   Use the !? number register to indicate that we have text for the
...\"   special running head.  That text is contained in the !? string.
...\"
.de !I		\" called by the .H substitute in {pub|draft}-mmt+.mm
.ie \\$1=2 \{\
.	nr !? 1
.	ds !? \\$3\"     \" save the text
'	br \}
.el .if \\$1=1 .nr !? 0   \" clear at top level
.ds }0 \&\"          \" clear the section number
..
...\"
.nr Cl 2	\" level 1 and 2 heads in the TOC
...\"
