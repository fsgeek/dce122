...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\" @OSF_FREE_COPYRIGHT@
...\" 
...\" HISTORY
...\" $Log: draft-mmt+.mm,v $
...\" Revision 1.1.2.7  1994/06/24  15:48:06  fred
...\" 	free copyright
...\" 	[1994/06/24  15:38:00  fred]
...\"
...\" Revision 1.1.2.6  1994/06/23  18:41:15  fred
...\" 	free copyright
...\" 	[1994/06/22  20:07:51  fred]
...\" 
...\" Revision 1.1.2.5  1993/04/10  00:37:39  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  00:32:25  bowe]
...\" 
...\" Revision 1.1.2.4  1992/07/21  20:25:15  fred
...\" 	rename )E macro to )e rather than just remove it.  allows
...\" 	creation of a TOC via a .TC by renaming it back and then using
...\" 	the .TC.  Rename would be via ".rn )e )E".   -fld
...\" 	[1992/07/21  20:24:33  fred]
...\" 
...\" Revision 1.1.2.3  1992/07/15  17:36:50  bowe
...\" 	Fill empty file (really initial rev).
...\" 	[1992/07/15  17:35:55  bowe]
...\" 
...\" Revision 1.1.2.2  1992/07/06  19:21:54  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  19:18:50  bowe]
...\" 
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/draft-mmt+.mm,v 1.1.2.7 1994/06/24 15:48:06 fred Exp $
...\"
...\"	draft-mmt+.mm  --  extensions to -mm for draft formatting
...\"
...\"  first, remove excess -mm macros/strings
.rm (1 (2 (3 (4 )K )M )N )W )X )Y >1 >2 >3 >4 >5 >6 >7 >8 >9 >T >x >z
.rm AE AF AK AS AT AU AV CB CH CP CS DR FC HL HO IA IE IH IN LO LT MH
.rm MT MV NE nP NS OK PM PY RR SG TL TM WA WB WE WH WV
.rm ]A ]F ]G ]H ]I ]J ]K ]L ]M ]O ]Q ]R ]S ]U ]V ]W ]X
.rm ]i ]j ]k ]l ]m ]o ]p ]q
.rm }A }B }E }H }I }Z }z
...\"
.po .8i	\" define left margin
.nr O .8i
.lt 6.5i
...\"
.if n .bd B 1		\"  don't do overkill emboldening
...\"
...\"	new top of page macro stuff
...\"
.de TP
'sp 2v			\" top margin
.ds !# \\gP
.af P 1
.nr !# \\nP		\" get page number
.af P \\*(!#
.if \\n(!_=1 .nr !# 0
.ie \\n(!#>1 \{\
.	ie \\n(!#%2=0 \{\
'		tl \\*(}e		\" even page head
.		if \\n(!?=1 .tl \\*(!?\"  extra head for SGREF
'		br \}
.	el \{\
'		tl \\*(}o		\" odd page head
.		if \\n(!?=1 .tl \\*(!?\"  extra head for SGREF
'		br \}
'	br \}
.el 'sp 2v		\" no running head -- blank space
.nr !_ 0		\" turn it off
.sp 1.75v
.|B				\" special exit macro -- used by Parts to fix footers
..
...\"
...\"	.H modifications:  rename H to !H and define a new H so that
...\"		the page head can be suppressed on the 1st page, and so
...\"		that the chapter name can appear in the running head
...\"
.rn H !H
...\"
.de H	\" the new .H macro
.if \\$1=1 \{\
.	nr !_ 1		\" inhibit running page head on chapter title pages
'	br \}
.ds !/ \\gP
.af P 1
.nr !/ \\nP		\" save page # for preface
.af P \\*(!/
.!I "\\$1" "\\$1" "\\$2"	\" call macro (if defined) for SGREF
.!H "\\$1" "\\$2" "\\$3"
..
...\"
.am !H	\" (the real .H macro)
.in \\n(!!u		\" reset to scanning column
.S \\n(!@\" default point size
.if \\$1=1 .ds !! \\$2\" chapter title
..
...\"
...\"	HEADING ESCAPE macros
...\"
.de HX
.!I "\\$1" "\\$2" "\\$3"	\" call macro (if defined) for SGREF
.ie \\$1>1 \{\
.	if \\n(!"=1 .ds }0 \&\" clear marks inside preface
.	sp 2v
.	ie \\$1=2 .vs 16		\" pick a vertical spacing for header
.	el .ie \\$1<5 .vs 14
.	el .vs 12
'	br \}
.el \{\
.	ie \\$3Preface \{\
.		nr P \\n(!/			\" reset page number
.		ds }0 \h'|.15i'\" don't do anything special for the preface
.		nr !" 1			\" in fact, remember this is the preface
'		br \}
.	el .ie \\$3Glossary \{\
.		ds }0 \h'|.15i'\" don't do anything special for the glossary either
'		br \}
.	el .ie \\$3Permuted Index \{\
.		nr P \\n(!/+1		\" reset page number
.		nr !" 1				\" don't count this as a chapter
.		ds }0 \h'|.15i'\" don't do anything special for the ptx either
'		br \}
.	el \{\
.		if \\n(!"=1 .nr H1 -1\"	don't count the preface
.		nr !" 0
.		ie \\g(H10 .ds }0 \\*(|A\ \\*(}0\"	prefix "Chapter #."
.		el .ds }0 Appendix\ \\*(}0\"			unless, "Appendix #."
'		br \}
.	vs 20
'	br \}
.in 0				\" header always at left margin
.nr ;3 +1.5v		\" increase space for H to reserve via .ne
..
...\"
.de HY
.if \\$1=1 \{\
.	rs
.	sp |2.5i
'	br \}
.!J "\\$1"          \" call unnumbered trimmer, if any
..
...\"
.de HZ
.ie \\$1=1 \{\
.	rs
.	sp 2.5v			\" room below head
'	br \}
.el .sp 1.25v
.nr !_ 0
..
...\"
...\"	make our own TOC--redefine the macro that stuffs info into
...\"	the TOC to make it output to std err.
...\"
...\"  (save the -mm )E macro in case someone wants it..)
.rn )E )e
...\"
...\"	first, redefine the sections table of contents collector
...\"
.de )E
.ds !# \\gP
.af P 1
.nr !# \\nP
.af P \\*(!#
.ie \\*(!#0 .tm !TOC: .)T \\n(;1 \\$1 "\\*(}0" "\\$2" \\nP \\n(H1
.el .tm !TOC: .)T \\n(;1 \\$1 "\\*(}0" "\\$2" \\nP
..
...\"
...\"	then, add to the tables/figures/etc toc outputter/collector
...\"
.am )F
.ds !# \\gP
.af P 1
.nr !# \\nP
.af P \\*(!#
.ie \\n(:y \{\
...\" figure inside display:  get the page number right
\!.	ie \\*(!#0 .tm !TOC: .if \\$2=\\\\\\\\\\\\\\\\$1 .)T 1 1 "\\*(}0" "\\$4" \\\\nP \\n(H1
\!.	el .tm !TOC: .if \\$2=\\\\\\\\\\\\\\\\$1 .)T 1 1 "\\*(}0" "\\$4" \\\\nP
'	br \}
.el \{\
.	ie \\*(!#0 .tm !TOC: .if \\$2=\\\\\\\\$1 .)T 1 1 "\\*(}0" "\\$4" \\nP \\n(H1
.	el .tm !TOC: .if \\$2=\\\\\\\\$1 .)T 1 1 "\\*(}0" "\\$4" \\nP
'	br \}
..
...\"
...\" make sure paragraph macro honors the scanning column
...\"
.am P
.if \\n(!(=0 .in \\n(!!u
.S \\n(!@\" default point size
..
...\"
...\"  make tables auto-reduce point size
.am TS
.ps -1
..
.am TE
.ps +1
..
...\"
...\" the list macros must save the indent that they contribute
...\"
.am VL
.nr !( +1
..
.am AL
.nr !( +1
..
.am ML
.nr !( +1
..
.am DL
.nr !( +1
..
.am BL
.nr !( +1
..
...\"
.am LE
.nr !( -1	\" indent over
..
...\"
...\"  redefine VL so that we can give it a default indent
.rn VL !K
.de VL
.ie \\n(.$>2 .!K "\\$1" "\\$2" "\\$3"
.el .ie \\n(.$>1 .!K "\\$1" "\\$2"
.el .ie \\n(.$>0 .!K "\\$1"
.el .!K 1i
..
...\"
...\"	adjust caption macros to give more space above and below
...\"
.rn TB !T	\" hide the real one
...\"
.de TB
.sp .5v
.in +.5i
.!T "\\$1" "\\$2"
.in \\n(!!u
..
...\"
.am !T
.sp .25v
..
...\"
.rn FG !F
...\"
.de FG
.sp .5v
.po \\n(!!u+.5i
.!F "\\$1" "\\$2"
.po
..
...\"
...\"   PIC support macros
...\"
...\"  The only real work done in these two macros is to try to make sure
...\"  that the figure is centered.
...\"
...\"   synopsis:  .PS <scaled-height> <scaled-width>
...\"
...\"  if the arguments are missing, then you lose the .ne or the centering
...\"  (respectively).
...\"
.de PS
.if !\\$1 .ne \\$1
.if !\\$2 \{\
.	in (\\n(.lu-\\$2)/2u
.	nr !: 1					\" remember that we did an indent
'	br \}
..
...\"
.de PE
.if \\n(!:=1 .in			\" reset indent
.nr !: 0
..
...\"
...\"	EXAMPLES macros
...\"
...\"  first, the obsolete DTE versions:
...\"
.de sE
.DS
.nr !~ \\n(!@-2
.S \\n(!~
.sp 1v
.ft \\*(!)
..
.de eE
.ft R
.S \\n(!@
.DE
..
...\"
...\"  now, the anticipated SML versions:
...\"
.de oS
.DS
.nr !~ \\n(!@-2
.S \\n(!~
.sp 1v
.ft \\*(!)
..
.de oE
.ft R
.S \\n(!@
.DE
..
...\"
...\"    NOTE:  the following glossary term stuff is taken from SML
...\"           as a temporary "get started" feature
...\"
...\" Glossary term 
...\" (rem: .gL acts differently when inside .wS & .wE [gpsml])
.de gL
...\"\&\fB\\$1\fR
.tm !GLOSSARY: "\\$1" "\\n(H1\(mi\\nP"
..
...\" Glossary term followed by ordinary text
...\".de G,
...\"\&\fB\\$1\fR\\$2
...\"..
...\" Ordinary text followed by glossary term
...\".de ,G
...\"\$\fR\\$1\fB\\$2\fR
...\"..
