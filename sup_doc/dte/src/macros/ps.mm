...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\" @OSF_FREE_COPYRIGHT@
...\" 
...\" HISTORY
...\" $Log: ps.mm,v $
...\" Revision 1.1.2.5  1994/06/24  15:48:36  fred
...\" 	free copyright
...\" 	[1994/06/24  15:39:02  fred]
...\"
...\" Revision 1.1.2.4  1994/06/23  18:41:47  fred
...\" 	free copyright
...\" 	[1994/06/22  20:10:02  fred]
...\" 
...\" Revision 1.1.2.3  1993/04/10  00:38:03  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  00:33:06  bowe]
...\" 
...\" Revision 1.1.2.2  1992/07/06  20:16:00  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  20:07:47  bowe]
...\" 
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/ps.mm,v 1.1.2.5 1994/06/24 15:48:36 fred Exp $
...\"
...\"	transcript compatibility for postscript use.
...\"
...\"	synopsis:  .P! <file.ps>
...\"
.de P!
\\&.
.fl			\" force out current output buffer
\\!%PB
\\!/showpage{}def
...\" the following is from Ken Flowers -- it prevents dictionary overflows
\\!/tempdict 200 dict def tempdict begin
.fl			\" prolog
.sy cat \\$1\" bring in postscript file
...\" the following line matches the tempdict above
\\!end % tempdict %
\\!PE
\\!.
.sp \\$2u	\" move below the image
..
