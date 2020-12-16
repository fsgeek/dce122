...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\" @OSF_FREE_COPYRIGHT@
...\" 
...\" HISTORY
...\" $Log: pub-mmt+.mm,v $
...\" Revision 1.1.2.5  1994/06/24  15:48:47  fred
...\" 	free copyright
...\" 	[1994/06/24  15:39:53  fred]
...\"
...\" Revision 1.1.2.4  1994/06/23  18:41:59  fred
...\" 	free copyright
...\" 	[1994/06/22  20:10:50  fred]
...\" 
...\" Revision 1.1.2.3  1993/04/10  00:38:11  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  00:33:20  bowe]
...\" 
...\" Revision 1.1.2.2  1992/07/06  20:16:45  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  20:08:11  bowe]
...\" 
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/pub-mmt+.mm,v 1.1.2.5 1994/06/24 15:48:47 fred Exp $
...\"
...\"	pub-mmt+.mm  --  extensions to -mm for publishing
...\"
...\"  first, remove excess -mm macros/strings
.rm (1 (2 (3 (4 )K )M )N )W )X )Y >1 >2 >3 >4 >5 >6 >7 >8 >9 >T >x >z
.rm AE AF AK AS AT AU AV CB CH CP CS DR FC HL HO IA IE IH IN LO LT MH
.rm MT MV NE nP NS OK PM PY RR SG TL TM WA WB WE WH WV
.rm ]A ]F ]G ]H ]I ]J ]K ]L ]M ]O ]Q ]R ]S ]U ]V ]W ]X
.rm ]i ]j ]k ]l ]m ]o ]p ]q
.rm }A }B }E }H }I }Z }z
...\"
...\"
...\"  set left and right margins.
.po .4i
.nr O .4i
.ll 6.6i
.lt 6.6i
.ev 1
.lt 6.6i
.ll 6.6i
.ev
.ev 2
.lt 6.6i
.ll 6.6i
.ev
.nr W 6.6i
...\"
...\"
...\"	TOP OF PAGE macro
...\"
...\".nr !_ 1
...\"
.de TP
.ds !# \\gP
.af P 1
.nr !# \\nP
.af P \\*(!#
.if \\n(!_=1 .nr !# 0
.ie \\n(!#>1 \{\
.	rs
.	sp |.625i
.	ps 12
.	vs 14
.	ft H
.	ie \\n(!#%2=0 \{\
.		ie \\n(|P=0 .tl \\*(!@\"  book or part name?
.		el .tl \\*(|P
'		br \}
.	el .tl \\*(!!
.	sp -.65v
\l'\\n(.lu'
.	if \\n(!?=1 \{\
.		br
.		ie \\n(!#%2=0 .tl \\*(!?\" extra running head for SGREF
.		el .tl \\*(!?
'		br \}
.	ps
.	ft
.	sp 3
'	br \}
.el \{\
'	rs
.	sp 8v
'	br \}
.nr !_ 0
.|B				\" special exit macro -- used by Parts to fix footers
..
...\"
...\"
...\"	ENHANCE PARAGRAPH and HEADING macros
.am H
.in \\n(!!u
.S \\n(!@
.if \\$1=1 .ds !! \\$2
..
...\"
...\"
...\" make sure paragraph macro honors the scanning column
...\"
.am P
.if \\n(!(=0 .in \\n(!!u
.S \\n(!@\" default point size
..
...\"
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
...\"
...\"
...\"
...\"	Enhance table macros for Helvetica
.am TS
.ft H
.ps -1
...\".fp 2 HI    \" can't do this because it confuses troff
.fp 3 HB
..
.am TE
.ft R
.ps +1
...\".fp 2 I
.fp 3 B
..
...\"
...\"	.H modifications:
...\"
...\"		rename H to !H and define a new H so that the page head
...\"		can be suppressed on the 1st page
...\"
.rn H !H
...\"
...\"
.de H
.if \\$1=1 \{\
.	nr !_ 1		\" inhibit running head on chapter head pages
'	br \}
.ds !/ \\gP
.af P 1
.nr !/ \\nP		\" save page number for preface
.af P \\*(!/
.!I "\\$1" "\\$1" "\\$2"	\" call macro (if defined) for SGREF
.!H "\\$1" "\\$2" "\\$3"
..
...\"
...\"
...\"	HEADING ESCAPE macros
...\"
.de HX
.!I "\\$1" "\\$2" "\\$3"	\" call macro (if defined) for SGREF
.ie \\$1>1 \{\
.	sp 2v
.	ie \\$1=2 .vs 20
.	el .ie \\$1<5 .vs 16
.	el .vs 13
.	if \\n(!"=1 .ds }0 \&\" clear marks inside preface
'	br \}
.el \{\
.	if \\n(!"=1 .nr H1 -1
.	ie \\$3Preface \{\
.		nr !" 1   		\" decrement section count later
.		nr P \\n(!/		\" reset page number
'		br \}
.	el .ie \\$3Permuted Index \{\
.		nr !" 1   		\" decrement section count later
.		nr P \\n(!/+1	\" reset page number
'		br \}
.	el .nr !" 0
.	ds }0 \&\"
.	vs 30
'	br \}
.nr !# \\n(!!u/2u
.ie \\$1<4 .in 0
.el .in \\n(!#u
'ne 6.5v
.if \\n(!->0 .nr P \\n(!-
.nr !- 0
..
.de HY
.ie \\$1=1 \{\
.	rs
.	sp 5v
.	mk @!
.	ds }+ \"
.	ie \\$3Preface \{\
.		ds }+ \\h'|.2i'
'		br \}
.	el .ie \\$3Glossary \{\
.		ds }+ \\h'|.2i'
'		br \}
.	el .ie \\$3Permuted Index \{\
.		ds }+ \\h'|.2i'
'		br \}
.	el \{\
.		ie \\g(H10 .ds }+ \\*(|A\ \\n(H1.\ \ \"
.		el .ds }+ Appendix\ \\n(H1.\ \ \"
'		br \}
'	br \}
.el \{\
.	ds }+ \\*(}0
'	br \}
.!J "\\$1"          \" call unnumbered trimmer, if any
..
.de HZ
.ie \\$1=1 \{\
.	sp |\\n(@!u
.	nr !* 1
.	if \\$3Preface .nr !* 0
.	if \\$3Glossary .nr !* 0
.	if \\$3Permuted Index .nr !* 0
.	ie \\n(!*=1 .sp -1v
.	el .sp .4v
\s30\l'\\n(.lu'\s0
.	if \\n(!*=1 \{\
.		sp -1.5v
.		if \\n(!*=1 \{\
.			ie \\g(H10 \{\
.				tl '''\s\\n(!$\\*(|A \\n(H1\s0'
'				br \}
.			el .if \\$2=1 \{\
.				tl '''\s\\n(!$Appendix \\n(H1\s0'
'				br \}
'			br \}
'		br \}
.	rs
.	ie \\n(!"=0 .sp 5v
.	el .sp 3v				\" same room for pseudo-chapters
'	br \}
.el \{\
.	sp .5v
'	br \}
.nr !_ 0
..
...\"
...\"	make our own TOC--redefine the macro that stuffs info into
...\"	the TOC to make it output to std err.
...\"
...\"	first, redefine the sections table of contents collector
...\"
.de )E
.ds !# \\gP
.af P 1
.nr !# \\nP
.af P \\*(!#
.ie \\*(!#0 .tm !TOC: .)T \\n(;1 \\$1 "\\*(}+" "\\$2" \\nP \\n(H1
.el .tm !TOC: .)T \\n(;1 \\$1 "\\*(}+" "\\$2" \\nP
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
...\"
...\"
.de PE
.if \\n(!:=1 .in			\" reset indent
.nr !: 0
..
...\"
...\"
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
...\"
...\"  The following is a fix for sometimes missing folios...
...\"     (I hope it works...   fld)
...\"
.de |T
.if \\n(|T=0 \{\
.	tm (actually, Warning:) Doing page footer fix on page \\nP
'	sp -1.5v
.	)b	\" call footer if it hasn't already been hit.
'	br \}
..
.rn )b |U
.de )b				\" hide )b so that we can set |T to show it we've
.nr |T 1			\" hit )b or not...
.|U
.nr |T 0
..
.nr |T \n(:ru-1u
'wh -\n(|Tu |T		\" set our trap one unit below )b
.nr |T 0
...\"
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
...\"
