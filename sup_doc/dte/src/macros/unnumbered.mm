...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\" @OSF_FREE_COPYRIGHT@
...\" 
...\" HISTORY
...\" $Log: unnumbered.mm,v $
...\" Revision 1.1.2.5  1994/06/24  15:49:11  fred
...\" 	free copyright
...\" 	[1994/06/24  15:40:41  fred]
...\"
...\" Revision 1.1.2.4  1994/06/23  18:42:23  fred
...\" 	free copyright
...\" 	[1994/06/22  20:12:50  fred]
...\" 
...\" Revision 1.1.2.3  1993/04/10  00:38:28  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  00:33:51  bowe]
...\" 
...\" Revision 1.1.2.2  1992/07/06  20:17:50  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  20:09:45  bowe]
...\" 
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/unnumbered.mm,v 1.1.2.5 1994/06/24 15:49:11 fred Exp $
...\"
...\"	unnumbered.mm -- settings invoked by using a "UNNUMBERED" directive
...\"					 in a Description file
...\"
...\"   All section heads below level 1, like
...\"
...\"    .H 2 "Section title" 
...\"
...\"   will get their section number trimmed off before they appear in the
...\"   running text or table of contents.
...\"
...\"  **** Note: this cannot be used with SGREF for the same "piece" 
...\"
.de !J
.if \\$1>1 \{\
.	ds }0 \&\"  clear the section number for levels > 1
.	ds }+ \&\"  clear the section number for levels > 1
'	br \}
..
...\"
...\"
...\"  set regularized indents for the TOC:
...\"
.tm !TOC: .ds Ci 0i .5i 1i 1.5i 2i 2.5i
...\"
