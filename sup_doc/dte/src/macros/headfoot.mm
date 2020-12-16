...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\" @OSF_FREE_COPYRIGHT@
...\"
...\" HISTORY
...\" $Log: headfoot.mm,v $
...\" Revision 1.1.2.5  1994/06/24  15:48:19  fred
...\" 	free copyright
...\" 	[1994/06/24  15:38:25  fred]
...\"
...\" Revision 1.1.2.4  1994/06/23  18:41:29  fred
...\" 	free copyright
...\" 	[1994/06/22  20:08:51  fred]
...\" 
...\" Revision 1.1.2.3  1993/04/10  00:37:49  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  00:32:42  bowe]
...\" 
...\" Revision 1.1.2.2  1992/07/06  20:15:02  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  20:06:42  bowe]
...\" 
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/headfoot.mm,v 1.1.2.5 1994/06/24 15:48:19 fred Exp $
...\"
...\"	headfoot.mm -- generic header/footer setup stuff
...\"
...\"	.|C "page reg name" "section name"
...\"
...\"	Some interesting strings:
...\"
...\"		!%	setup to be the font for heads/feet
...\"		!@	the title of the current book
...\"		|P	the title of the current part
...\"		!!	the title of the current chapter
...\"		!?	the "extra" heading for SGREF
...\"
...\"	Some interesting registers:
...\"
...\"		|P	=0 not doing parts, =1 we are doing parts
...\"		|D	=1 doing a draft format,  =0 doing publish
...\"		N   <3 doing single page numbering, >= 3 doing
...\"							section-page numbering
...\"
...\"
.de |C		\" setup mm headers/footers
.ie \\n(|D=1 \{\
'	br				\" DRAFT MODE STYLE INFO
.	ds |V \*(DT\"		date
.	ie \\n(|P=0 .ds |W \*(DT\"	date
.	el .ds |W \\\\\\\\\\\\\\\\*(!@\"doing parts - use book title
.	ds !% R\"			roman font
'	br \}
.el \{\
'	br				\" PUBLISH MODE STYLE INFO
.	ds |V\"				don't show date
.	ie \\n(|P=0 .ds |W\"	don't show date
.	el \{\
.		ds |W \\\\\\\\\\\\\\\\*(!@\"doing parts - use book title
.		ds |V \\\\\\\\\\\\\\\\*(!@\"book title on both sides of the page
'		br \}
.	ds !% H\"			helvetica
'	br \}
...\"
...\"
.ie \\n(|P=0 \{\
'	br				\" NOT PARTS--
.	ds |Y \\\\\\\\\\\\\\\\*(!@\"	\" use book title
'	br \}
.el \{\
'	br				\" PARTS --
.	ds |Y \\\\\\\\\\\\\\\\*(|P	\" use part name
'	br \}
...\"
...\"
...\" construct folio
.ie \\nN<3 .ds |X \\\\\\\\\\\\\\\\n\\$1\"	not section-page
.el .ds |X \\$2\(mi\\\\\\\\\\\\\\\\n\\$1\"	section-page
...\"
...\"
...\"  Now, setup headers, then footers
...\"
.EH "\\\\f\\*(!%\s\n(!@\\*(|Y\s0\fR"
.OH "\\\\f\\*(!%\s\n(!@\\\\\\\\*(!!\s0\fR"
.PH ""
...\"
.EF "\\\\f\\*(!%\s\n(!@\\*(|X\\*(|V\s0\fR"
.OF "\\\\f\\*(!%\s\n(!@\\*(|W\\*(|X\s0\fR"
.PF ""
..
...\"
...\"
...\" page headers and footers
...\"
.|C "P" "\\\\\\\\\\\\\\\\n(H1"
...\"
