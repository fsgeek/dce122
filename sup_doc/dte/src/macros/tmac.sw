...\" @NO_OSF_COPYRIGHT@
...\" 
...\" HISTORY
...\" $Log: tmac.sw,v $
...\" Revision 1.1.2.2  1992/07/06  20:17:19  bowe
...\" 	Initial rev.
...\" 	[1992/07/06  20:10:12  bowe]
...\"
...\" $EndLog$
...\"
...\" $Header: /u1/rcs/dte/macros/tmac.sw,v 1.1.2.2 1992/07/06 20:17:19 bowe Exp $:
...\"
...\" %W% %U% %G%
...\" %Z% Copyright(c) %G% SecureWare, Inc.
...\" %Z% All Rights Reserved.
...\"
...\" This file defines standard SecureWare abbreviations and macros
...\" for use with all SecureWare documentation. 
...\"
...\" This file should be loaded in AFTER the mm macros have been read in.
...\" The typical way of doing this is by including   -msw    on the 
...\" command line which invokes troff.
...\"
...\" This file consists of the following sections :
...\"
...\" 1) Standard SecureWare Abbreviations
...\" 2) Changes to mm registers to modify standard mm behaviour
...\" 3) Standard SecureWare Macro Definitions
...\" 4) Set standard spacing, font.
...\"
...\" ----------------------------------------------------------
...\" ----------------------------------------------------------
...\"
...\"	Standard SecureWare Abbreviations
...\"
.ds B1 "Security Module Package Plus
.ds C2 "Security Module Package
.ds Cm "\s-1CMW+\s0
.ds Cw "Compartmented Mode Workstation
.ds Dt "\\*(DT
.ds Su "Security Module Package
.ds Sw "S\s-2ECURE\s0W\s-2ARE\s0
...\"
...\" ----------------------------------------------------------
...\"
...\"	The next few commands modify the behavior of mm
...\"
.ds Lf FIGURES                  \" Change name of List of Figures
.ds HP 17 15 13 12 11 10	\" Heading point size. (H1=17, H2=15 etc.)
.ds HF 3 3 3 3 3 3 3            \" All headings in bold (bold=3)
.nr Ej 1			\" Start new page for ".H 1"
.nr Hb 7			\" Break after all headings
.nr Hs 7			\" Set vertical spacing after heading
.nr Cl 7			\" Save all headings for Table of Contents
.nr P 0				\" All paragraphs to be left aligned (default)
.nr Dr 0			\" No draft notice in title page
...\" Set standard point size, vertical spacing, standard font.
.S 11 13
.R
.SA 1
...\"
...\" ----------------------------------------------------------
...\"
...\"	Define standard SecureWare macros. They are listed alphabetically.
...\"
.deDe         \" End of source code insert
.S 11 13
.ft R
.DE
..
.deDf         \" Start of source code insert for floating display
.DF L N
.S 9 11
.ft \\*(!)
.ta 9n +8n +8n +8n +8n +8n +8n +8n +8n +8n
..
.deDs         \" Start of source code insert
.DS L N
.S 9 11
.ft \\*(!)
.ta 9n +8n +8n +8n +8n +8n +8n +8n +8n +8n
..
.deFg		\" End of figure macro. Insert the name and spacing
.SP 0.5
.FG "\\$1"
.SP 1.5
..
.deFn		\" Insert next figure number into running text
.nr x \\n(Fg
.nr x +1 0
\\n(H1-\\nx\\$1
..
.deHX		\" Insert space before each heading except level one heads
.if \\n(H1>=1 .SP 1
..
.deHZ		\" Cut down on white space after header
.sp -0.35
..
.de Ii		\" Used to start insert of source file/user interaction. See Oo
.DS \\$1 \\$2 \\$3
.S 10
.ft \\*(!)
..
.deNs 		\" Define a macro to reset page size to normal
.ft R
.S 11 13
..
.de Oo		\"End of user interaction. See Ii
.S 11
.ft R
.DE
..
...\"		\" Overline a word. The second argument is optional
...\"		\" and allows for punctuation. e.g.    .OL Hello ,  
.deOL		\" overlines properly without a space after "hello"
\\$1\l'|0\(rn'\\$2
..
.dePf 		\" Define page footer. Should be invariant through document.
.ds}f "'\d\d\d\\\\n(H1\-\\\\nP''\\$1'
.ds}p "'\d\d\d\\$1''\\\\n(H1\-\\\\nP'
.ds}b "
..
.dePh 		\" Define page header. 
.ds}e "'\\$1'''
.ds}o "'''\\$1'
..
.deSe		\" Start of section. Use this instead of ".H 1 Title"
.if !\\n(.$-1 .)D "Se:Needs two arguments"
.nr H1 \\$1
.nr H1 -1
.Ph "\\$2"
.H 1 "\\$2"
..
.deSt		\" Startup macro.
.ds HP 17 15 13 12 11 10	\" Heading point size. (H1=17, H2=15 etc.)
.ds HF 3 3 3 3 3 3 3            \" All headings in bold (bold=3)
.nr Ej 1			\" Start new page for ".H 1"
.nr Hb 7			\" Break after all headings
.nr Hs 7			\" Set vertical spacing after heading
.nr Cl 7			\" Save all headings for Table of Contents
.nr P 0				\" All paragraphs to be left aligned (default)
.nr Dr 0			\" No draft notice in title page
.S 11 13
.R
.SA 1
.dsTt "\\$1
.Pf "\\*(Tt"
..
...\" Define two macros for inserting pretty screens into the file.
...\" The macros are .SS and .ST, however we need to use the pic-ed
...\" version. The original, pre-pic, version is listed below as a comment.
...\"   .de SS         \" This macro used to insert round-cornered box
...\"   .br
...\"   .ne 14
...\"   .PS
...\"   move right .25i
...\"   line right 5.5i
...\"   arc cw
...\"   line down 1.3i
...\"   arc cw
...\"   line left 5.5i
...\"   arc cw
...\"   line up 1.3i
...\"   arc cw
...\"   .PF
...\"   .S 10 12
...\"   .ft CW
...\"   .cs CW 21
...\"   .in .10i
...\"   .nf
...\"   .so \\$1
...\"   .fi
...\"   .ft R
...\"   .SP 3
...\"   .S 11 13
...\"   .FG "\\$2."
...\"   .in 0
...\"   ..
...\"   .de ST         \" This macro used to insert round-cornered box
...\"   .br
...\"   .ne 26
...\"   .PS
...\"   move right .25i
...\"   line right 5.5i
...\"   arc cw
...\"   line down 3.15i
...\"   arc cw
...\"   line left 5.5i
...\"   arc cw
...\"   line up 3.15i
...\"   arc cw
...\"   .PF
...\"   .S 10 12
...\"   .ft CW
...\"   .cs CW 21
...\"   .in .10i
...\"   .nf
...\"   .so \\$1
...\"   .fi
...\"   .ft R
...\"   .SP 3
...\"   .S 11 13
...\"   .FG "\\$2."
...\"   .in 0
...\"   ..
.de SS         \" This macro used to insert round-cornered box
.br
.ne 14
... 0 -1.8 6 0
... 0.000i 1.800i 6.000i 0.000i
.nr 00 \n(.u
.nf
.PS 1.800i 6.000i 
.br
\h'0.250i'\l'5.500i'
.sp -1
\h'6.000i'\v'0.250i'\D'a-0.250i 0.000i 0.000i -0.250i'
.sp -1
\h'6.000i'\v'0.250i'\v'-.25m'\L'1.300i\(br'\v'.25m'
.sp -1
\h'5.750i'\v'1.800i'\D'a0.000i -0.250i 0.250i 0.000i'
.sp -1
\h'5.750i'\v'1.800i'\l'-5.500i'
.sp -1
\v'1.550i'\D'a0.250i 0.000i 0.000i 0.250i'
.sp -1
\v'1.550i'\v'-.25m'\L'-1.300i\(br'\v'.25m'
.sp -1
\h'0.250i'\D'a0.000i 0.250i -0.250i 0.000i'
.sp -1
...\"	.PF
.if \n(00 .fi
.S 10 12
.ft \\*(!)
.cs \\*(!) 21
.in .10i
.nf
.so \\$1
.fi
.ft R
.SP 3
.S 11 13
.FG "\\$2."
.in 0
..
.de ST         \" This macro used to insert round-cornered box
.br
.ne 26
... 0 -3.65 6 0
... 0.000i 3.650i 6.000i 0.000i
.nr 00 \n(.u
.nf
.PS 3.650i 6.000i 
.br
\h'0.250i'\l'5.500i'
.sp -1
\h'6.000i'\v'0.250i'\D'a-0.250i 0.000i 0.000i -0.250i'
.sp -1
\h'6.000i'\v'0.250i'\v'-.25m'\L'3.150i\(br'\v'.25m'
.sp -1
\h'5.750i'\v'3.650i'\D'a0.000i -0.250i 0.250i 0.000i'
.sp -1
\h'5.750i'\v'3.650i'\l'-5.500i'
.sp -1
\v'3.400i'\D'a0.250i 0.000i 0.000i 0.250i'
.sp -1
\v'3.400i'\v'-.25m'\L'-3.150i\(br'\v'.25m'
.sp -1
\h'0.250i'\D'a0.000i 0.250i -0.250i 0.000i'
.sp -1
...\"	.PF
.if \n(00 .fi
.S 10 12
.ft \\*(!)
.cs \\*(!) 21
.in .10i
.nf
.so \\$1
.fi
.ft R
.SP 3
.S 11 13
.FG "\\$2."
.in 0
..
.deTb		\" End of table macro. Insert the name and spacing
.SP 0.5
.TB "\\$1"
.SP 1.5
..
.deTi		\" Title macro. Each argument is output as a separate line.
...\" 		\" Normally this is the last file in a troff run. 
...\"		\" However, if, for some reason you want to run this earlier 
...\"		\" then we need to set a local temporary variable (nh) for 
...\"		\" the page header. Usage:	.TI "This is" "Title"
.dsnh \(}t
.PH ""		\" No page header
.bp		\" New page. 
.PF ""		\" No page feet
.SP 5		\" Skip 5 spaces
.B
...\" Change font size and spacing
.S 18 20
...\"		\" Allow up to five lines in the title page
.if \\n(.$ \{\
.ce 1
\\$1 \}
.if \\n(.$-1 \{\
.ce 1
\\$2 \}
.if \\n(.$-2 \{\
.ce 1
\\$3 \}
.if \\n(.$-3 \{\
.ce 1
\\$4 \}
.if \\n(.$-4 \{\
.ce 1
\\$5 \}
...\"	Put version number and release date at consistent place
...\"	Do not modify the numbers/dates here - use head.mm for that
.sp |3i
.S 14 16
.ce 3
Part number: \\*(Pn
Revision: \\*(Rv
\\*(Dt
.S 12 14
...\" If this is a draft document (Dr=1) then insert draft notice
.if \\n(Dr \{\
.sp |6i	\" Move to consistent point
NOTE: Information in this draft is subject to change. All
interfaces and descriptions are intended to be accurate, but
may change in the final version of this document. \}
...\"
...\" The next line moves down to a consistent point from the top of page
...\" This will always put the address at a consistent place.
.sp |8.5i
.ce 4
\*(Sw, Inc.
430 10th Street, Suite N-210
Atlanta, Georgia 30318, USA
(404)876-4840
...\" Reset font, page size and page header.
.R
.S 11 13
.ds}t \(nh 
..
.deTn		\" Insert next table number into running text 
.nr x \\n(Tb
.nr x +1 0
\\n(H1-\\nx\\$1
..
...\"		\" Underline a word. The second argument is optional
...\"		\" and allows for punctuation. e.g.    .UL Hello ,  
.deUL		\" underlines properly without a space after "hello"
\\$1\l'|0\(ul'\\$2
..
...\"	---------------------------------------------------------------------
...\"	E N D   O F   S e c u r e W a r e   M A C R O   D E F I N I T I O N S
...\"	---------------------------------------------------------------------
