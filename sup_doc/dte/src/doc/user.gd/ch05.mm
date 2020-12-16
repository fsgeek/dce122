...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
...\"  @OSF_FREE_COPYRIGHT@
...\"
...\" HISTORY
...\" $Log: ch05.mm,v $
...\" Revision 1.1.2.7  1994/06/24  15:16:31  fred
...\" 	free copyright
...\" 	[1994/06/23  20:15:56  fred]
...\"
...\" Revision 1.1.2.6  1994/06/23  18:40:30  fred
...\" 	free copyright
...\" 	[1994/06/22  19:35:07  fred]
...\" 
...\" Revision 1.1.2.5  1993/04/10  01:22:55  bowe
...\" 	Add OSF copyright.
...\" 	[1993/04/10  01:20:41  bowe]
...\" 
...\" Revision 1.1.2.4  1992/05/28  18:20:53  bowe
...\" 	Fix botched initial check-in.
...\" 	[1992/05/28  18:16:51  bowe]
...\" 
...\" Revision 1.1.2.3  1992/05/28  17:56:29  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:53:37  bowe]
...\" 
...\" Revision 1.1.2.2  1992/05/28  16:50:23  bowe
...\" 	Initial submission.
...\" 	[1992/05/28  16:47:49  bowe]
...\" 
...\" $EndLog$
...\" _________________________________________________________________
...\"
.H 1 "SML Macro Quick Reference"
.iX "index entry"
.iX "another index entry"
.P
This chapter provides a series of tables for your reference when
using the SML macros.  Before using this appendix, you should be
familiar with the SML technical description in Chapter 4, and
the user's information in Chapter 2. 
.P
...\"*********************************************************************
...\"		Second-level head
...\"*********************************************************************
.H 2 "Macros by Function"
The tables in this section show the macros you use for particular purposes.
Functions only used in GPSML are marked as such.
.ne 25
.TB "Macros That Define Overall Document Structure (GPSML ONLY!)"
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
.TH
_
\&.H 1	First-level head (Chapter in a book)	Existing \fBmm\fP macro
\&.H 2	Second-level head (1st-level head in a book)	Existing \fBmm\fP macro
\&.H 3	Third-level head (2nd-level head in a book)	Existing \fBmm\fP macro
\&.H 4	Fourth-level head (3rd-level head in a book)	Existing \fBmm\fP macro

\&.zS	Appendix begins	New semantic macro
\&.zE	Appendix ends	New semantic macro

\&.xS	Title page begins	New semantic macro
\&.xE  	Title page ends	New semantic macro

\&.yS	Disclaimer (copyright) page begins	New semantic macro
\&.yE	Disclaimer (copyright) page ends	New semantic macro

\&.qS	Preface begins	New semantic macro
\&.qE	Preface ends	New semantic macro
.TE
.sp
.ne 25 
.TB "Macros That Delimit Titled Elements of a Document"
.TS H
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status\fR 
_
.TH
_
\&.TB	Table title	Existing \fBmm\fP/\fBman\fP macro
\&.TS	Start table	Existing \fBmm\fP/\fBman\fP macro
\&.T&	Table continue	Existing \fBmm\fP/\fBman\fP macro

\&.TE	End table	Existing \fBmm\fP/\fBman\fP macro
\&.TH	Table header ends	Existing \fBmm\fP macro
\&.tH	Table header ends	New semantic macro (equiv. to .TH) 
			
\&.FG	Figure title	Existing \fBmm\fP/\fBman\fP macro
\&.PS	\fBpic\fP drawing start	Existing \fBmm\fP/\fBman\fP macro
\&.PE	\fBpic\fP drawing end	Existing \fBmm\fP/\fBman\fP macro
			
\&.pR	Procedure title	New semantic macro (GPSML only)
\&.pS	Procedure start	New semantic macro (GPSML only)
\&.pE	Procedure end	New semantic macro (GPSML only)

\&.EC	Equation caption	Existing \fBmm\fP/\fBman\fP macro
\&.EN	End equation	Existing \fBmm\fP/\fBman\fP macro
\&.EQ	Start equation	Existing \fBmm\fP/\fBman\fP macro

\&.EX	Exhibit caption	\fBmm\fP macro
.TE
.sp
.ne 50
.TB "Macros That Delimit Untitled Elements of a Document"
.TS H
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status\fR 
_
.TH
_
\&.P	Paragraph	\fBmm\fP macro
\&.PP	Paragraph	\fBman\fP macro; we add to \fBmm\fP
_
\&.ML	Start nonsequential invariant list	Existing \fBmm\fP macro
\&.VL	Start nonsequential variant list	Existing \fBmm\fP macro
\&.AL	Start sequential invariant list	Existing \fBmm\fP macro
\&.LI	List item	Existing \fBmm\fP macro
\&.LE	End of list	Existing \fBmm\fP macro
_
\&.iS	Start user input example region	New semantic macro
\&.iE	End user input example region	New semantic macro

\&.oS	Start system output example region	New semantic macro
\&.oE	End system output example region	New semantic macro

\&.tS	Start set-off text piece region	New semantic macro
\&.tE	End set-off text piece region	New semantic macro

\&.gS	Start glossary entry region	New semantic macro (GPSML only)
\&.gE	End glossary entry  region	New semantic macro (GPSML only)
			
\&.FS	Start footnote region	Existing \fBmm\fP macro (GPSML only!)
\&.FE	End footnote region	Existing \fBmm\fP macro (GPSML only!)
\&\e*F	Place footnote here	\fBmm\fP macro (GPSML only!)
				
\&.RS	Start reference region	Existing \fBmm\fP macro (GPSML only!)
\&.RF	End reference region	Existing \fBmm\fP macro (GPSML only!)
			
\&.nS 	Start note region	New semantic macro (GPSML only!)
\&.nE	End note region	New semantic macro (GPSML only!)
			
\&.cS	Start comment region	New semantic macro
\&.cE	End comment region	New semantic macro
\&...\e"	One-line comment	Existing markup

\&.lS	Start localization region	New semantic macro
\&.lE	End localization region	New semantic macro
_
\&.mA	Manual title (for title page)	New semantic macro (GPSML only!)
\&.rV	Manual revision (for title page)	New semantic macro (GPSML only!)
\&.cO	Manual copyright (for disclaimer)	New semantic macro (GPSML only!)
\&.aU	Manual author (for title page)	New semantic macro (GPSML only!)
\&.oN x	Manual order number (for title page)	New semantic macro (GPSML only!)

.TE
.sp
.ne 15 
.TB "Meaningful Text Markup"
.TS H
center,box;
l | l | l.
\fBMarkup code	Function	Macro Origin and Status \fR 
_
.TH
_
\&\e*Lname\e*O	Literal	New semantic markup
\&\e*Vname\e*O	Variable	New semantic markup
\&\e*Aname\e*O	Alphabetic constant 	New semantic markup
\&\e*Nname\e*O	Numeric constant 	New semantic markup
\&\e*Oordinary text	Ordinary Text 	New semantic markup
\&\e*ISystem input\e*O	System Input 	New semantic markup
\&\e*CComputer output\e*O	Computer Output	New semantic markup
_
\&.sS	 Start synopsis definition	New semantic markup
\&.sE	 End synopsis definition	New semantic markup

\&.fS	 Start function definition 	New semantic markup
\&.fE	 End function definition 	New semantic markup

\&.dS [opt]	Start type declaration 	New semantic markup
\&.dE 	End type declaration 	New semantic markup
.TE
.ne 10 
.TB "Macros for Tagging Index, Key, and Glossary Entries"
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
\&.kY "key"	Name of keyboard key	New semantic macro
\&.K, "key" "text"	Keyboard key name + ordinary text	New semantic macro
\&.,K "text" "key"	ordinary text + keyboard key name	New semantic macro

\&.gL "term" 	Glossary term	New semantic macro
\&.G, "term" "text"	Keyboard key name + ordinary text	New semantic macro
\&.,G "text" "term"	ordinary text + keyboard key name	New semantic macro

\&.eM "phrase"	Emphasized phrase	New semantic macro
\&.G, "phrase" "text"	Emphasized phrase + ordinary text	New semantic macro
\&.,G "text" "phrase"	ordinary text + emphasized phrase	New semantic macro

\&.OK	Key words	Existing \fBmm\fP macro

\&.iX	Index entry	New semantic macro
.TE
.ne 12 
.TB "Macros That Include, Define Strings, and Mark Up Pages" 
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
\&.dI subdocument_name	Include subdocument of same type	New semantic macro
\&.eI subdocument_name	Include subdocument of example type	New semantic macro
\&.pI subdocument_name	Include PostScript subdocument	New semantic macro

\&.ds	Define string for expansion	Existing markup

\&.pM	Page markup information	New semantic macro
.TE
.ne 4
.TB "Macros That Create Frontmatter and Backmatter (GPSML ONLY!)"
.TS
center,box;
l | l | l.
\fBMacro	Macro	Macro Origin\fR 
\fBName	Function	and Status\fR	
_
\&.TC	table of contents	Existing \fBmm\fP Macro
.TE
.sp
.ne 8
.TB "Markup For Escapes" 
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
\&.nP	Force a page break here	New "semantic" macro
\&.ne x	Reserve x lines on one page	Existing markup
\&.nL	Force a line break	New "semantic" macro	

\&.wH	Tag text converted from another language, not recognized	New semantic macro
.TE
.H 2 "New Semantic Macros"
.P
The table in this section lists all the new semantic
macros and markup that we have invented.  If a macro
replaces existing mark-up, we mention it.
.ne 55 
.TB "New Semantic Macros and Markup"
.TS H
center,box;
l | l | l.
\fBMarkup code	Function	Macro Origin and Status \fR 
_
.TH
_
\&.zS	Appendix begins	New semantic macro
\&.zE	Appendix ends	New semantic macro
\&.xS	Title page begins	New semantic macro
\&.xE  	Title page ends	New semantic macro
\&.yS	Disclaimer (copyright) page begins	New semantic macro
\&.yE	Disclaimer (copyright) page ends	New semantic macro
\&.qS	Preface begins	New semantic macro
\&.qE	Preface ends	New semantic macro
\&.wS	Glossary (wordlist) begins	New semantic macro
\&.wE	Glossary (wordlist) ends	New semantic macro
_
\&.tH	Table header ends	New semantic macro (equiv. to .TH) 

\&.pR	Procedure title	New semantic macro (GPSML only)
\&.pS	Procedure start	New semantic macro (GPSML only)
\&.pE	Procedure end	New semantic macro (GPSML only)

\&.iS	Start user input example region	New semantic macro
\&.iE	End user input example region	New semantic macro

\&.oS	Start system output example region	New semantic macro
\&.oE	End system output example region	New semantic macro

\&.tS	Start set-off text piece region	New semantic macro
\&.tE	End set-off text piece region	New semantic macro

\&.gS	Start glossary entry region	New semantic macro (GPSML only)
\&.gE	End glossary entry  region	New semantic macro (GPSML only)

\&.nS 	Start note region	New semantic macro (GPSML only!)
\&.nE	End note region	New semantic macro (GPSML only!)

\&.cS	Start comment region	New semantic macro
\&.cE	End comment region	New semantic macro

\&.lS	Start localization region	New semantic macro
\&.lE	End localization region	New semantic macro

\&.mA	Manual title (for title page)	New semantic macro (GPSML only!)
\&.rV	Manual revision (for title page)	New semantic macro (GPSML only!)
\&.cO	Manual copyright (for disclaimer)	New semantic macro (GPSML only!)
\&.aU	Manual author (for title page)	New semantic macro (GPSML only!)
\&.oN x	Manual order number (for title page)	New semantic macro (GPSML only!)

\&.kY "key"	Name of keyboard key	New semantic macro
\&.K, "key" "text"	Keyboard key name + ordinary text	New semantic macro
\&.,K "text" "key"	ordinary text + keyboard key name	New semantic macro

\&.gL "term" 	Glossary term	New semantic macro
\&.G, "term" "text"	Keyboard key name + ordinary text	New semantic macro
\&.,G "text" "term"	ordinary text + keyboard key name	New semantic macro

\&.eM "phrase"	Emphasized phrase	New semantic macro
\&.G, "phrase" "text"	Emphasized phrase + ordinary text	New semantic macro
\&.,G "text" "phrase"	ordinary text + emphasized phrase	New semantic macro

\&.iX	Index entry	New semantic macro
_
\&.dI subdocument_name	Include subdocument of same type	New semantic macro
\&.eI subdocument_name	Include subdocument of example type	New semantic macro
\&.pI subdocument_name	Include PostScript subdocument	New semantic macro
\&.pM	Page markup information	New semantic macro
\&.wH	Tag converted text (not recognized)	New semantic macro
_
\&\e*Lname\e*O	Literal	New semantic markup
\&\e*Vname\e*O	Variable	New semantic markup
\&\e*Aname\e*O	Alphabetic constant 	New semantic markup
\&\e*Nname\e*O	Numeric constant 	New semantic markup
\&\e*Oordinary text	Ordinary Text 	New semantic markup
\&\e*ISystem input\e*O	System Input 	New semantic markup
\&\e*CComputer output\e*O	Computer Output	New semantic markup
_
\&.sS	 Start synopsis definition	New semantic markup
\&.sE	 End synopsis definition	New semantic markup

\&.fS	 Start function definition 	New semantic markup
\&.fE	 End function definition 	New semantic markup

\&.dS [opt]	Start type declaration 	New semantic markup
\&.dE	End type declaration 	New semantic markup
.TE
.H 2 "GPSML and RSML"
.P
The tables in this section are lifted from the technical description.
They show the macros in GPSML and RSML.
.sp
.ne 35
.TB "GPSML Macros That Define Overall Document Structure"
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
\&.H 1	First-level head (Chapter in a book)	Existing \fBmm\fP macro
\&.H 2	Second-level head (1st-level head in a book)	Existing \fBmm\fP macro
\&.H 3	Third-level head (2nd-level head in a book)	Existing \fBmm\fP macro
\&.H 4	Fourth-level head (3rd-level head in a book)	Existing \fBmm\fP macro

\&.zS	Appendix begins	New semantic macro
\&.zE	Appendix ends	New semantic macro

\&.xS	Title page begins	New semantic macro
\&.xE  	Title page ends	New semantic macro

\&.yS	Disclaimer (copyright) page begins	New semantic macro
\&.yE	Disclaimer (copyright) page ends	New semantic macro

\&.qS	Preface begins	New semantic macro
\&.qE	Preface ends	New semantic macro
.TE
.ne 25
.TB "GPSML Macros That Delimit Titled Elements of a Document"
.TS H
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status\fR 
_
.TH
_
\&.TB	Table title	Existing \fBmm\fP/\fBman\fP macro
\&.TS	Start table	Existing \fBmm\fP/\fBman\fP macro
\&.T&	Table continue	Existing \fBmm\fP/\fBman\fP macro
\&.TE	End table	Existing \fBmm\fP/\fBman\fP macro
\&.TH	Table header ends	Existing \fBmm\fP macro
\&.tH	Table header ends	New semantic macro (equiv. to .TH) 
			
\&.FG	Figure title	Existing \fBmm\fP/\fBman\fP macro
\&.PS	\fBpic\fP drawing start	Existing \fBmm\fP/\fBman\fP macro
\&.PE	\fBpic\fP drawing end	Existing \fBmm\fP/\fBman\fP macro
			
\&.pR "procedure_name"	Procedure title	New semantic macro
\&.pS	Procedure start	New semantic macro
\&.pE	Procedure end	New semantic macro

\&.EC	Equation caption	Existing \fBmm\fP/\fBman\fP macro
\&.EN	End equation	Existing \fBmm\fP/\fBman\fP macro
\&.EQ	Start equation	Existing \fBmm\fP/\fBman\fP macro

\&.EX	Exhibit caption	\fBmm\fP macro
.TE
.ne 40
.TB "GPSML Macros That Delimit Untitled Elements of a Document"
.TS H
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status\fR 
.TH
_
\&.P	Paragraph	\fBmm\fP macro
\&.PP	Paragraph	\fBman\fP macro; we add to \fBmm\fP
_
\&.ML	Start nonsequential invariant list	Existing \fBmm\fP macro
\&.VL	Start nonsequential variant list	Existing \fBmm\fP macro
\&.AL	Start sequential invariant list	Existing \fBmm\fP macro
\&.LI	List item	Existing \fBmm\fP macro
\&.LE	End of list	Existing \fBmm\fP macro
_
\&.iS	Start user input example region	New semantic macro
\&.iE	End user input example region	New semantic macro

\&.oS	Start system output example region	New semantic macro
\&.oE	End system output example region	New semantic macro

\&.tS	Start set-off text piece region	New semantic macro
\&.tE	End set-off text piece region	New semantic macro

\&.gS	Start glossary entry region	New semantic macro
\&.gE	End glossary entry  region	New semantic macro
			
\&.FS	Start footnote region	Existing \fBmm\fP macro
\&.FE	End footnote region	Existing \fBmm\fP macro
\&\e*F	Place footnote here	\fBmm\fP macro
				
\&.RS	Start reference region	Existing \fBmm\fP macro
\&.RF	End reference region	Existing \fBmm\fP macro
			
\&.nS 	Start note region	New semantic macro
\&.nE	End note region	New semantic macro
			
\&.cS	Start comment region	New semantic macro
\&.cE	End comment region	New semantic macro
\&...\e"	One-line comment	Existing markup

\&.lS	Start localization region	New semantic macro
\&.lE	End localization region	New semantic macro
_
\&.mA	Manual title (for title page)	New semantic macro
\&.rV	Manual revision (for title page)	New semantic macro
\&.cO	Manual copyright (for disclaimer)	New semantic macro
\&.aU	Manual author (for title page)	New semantic macro
\&.oN x	Manual order number (for title page)	New semantic macro

.TE
.ne 15
.TB "GPSML Meaningful Text Markup"
.TS H
center,box;
l | l | l.
\fBMarkup code	Function	Macro Origin and Status \fR 
.TH
_
\&\e*Lname\e*O	Literal	New semantic markup
\&\e*Vname\e*O	Variable	New semantic markup
\&\e*Aname\e*O	Alphabetic constant 	New semantic markup
\&\e*Nname\e*O	Numeric constant 	New semantic markup
\&\e*Oordinary text	Ordinary Text 	New semantic markup
\&\e*ISystem input\e*O	System Input 	New semantic markup
\&\e*CComputer output\e*O	Computer Output	New semantic markup
_
\&.sS	 Start synopsis definition	New semantic markup
\&.sE	 End synopsis definition	New semantic markup

\&.fS	 Start function definition 	New semantic markup
\&.fE	 End function definition 	New semantic markup

\&.dS [opt]	Start type declaration 	New semantic markup
\&.dE	End type declaration 	New semantic markup
.TE
.ne 15
.TB "GPSML Macros for Tagging Index, Key, and Glossary Entries"
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
\&.kY "key"	Name of keyboard key	New semantic macro
\&.K, "key" "text"	Keyboard key name + ordinary text	New semantic macro
\&.,K "text" "key"	ordinary text + keyboard key name	New semantic macro

\&.gL "term" 	Glossary term	New semantic macro
\&.G, "term" "text"	Keyboard key name + ordinary text	New semantic macro
\&.,G "text" "term"	ordinary text + keyboard key name	New semantic macro

\&.eM "phrase"	Emphasized phrase	New semantic macro
\&.G, "phrase" "text"	Emphasized phrase + ordinary text	New semantic macro
\&.,G "text" "phrase"	ordinary text + emphasized phrase	New semantic macro

\&.OK	Key words	Existing \fBmm\fP macro

\&.iX	Index entry	New semantic macro
.TE
.ne 10
.TB "GPSML Macros That Include, Define Strings, and Mark Up Pages" 
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
\&.dI subdocument_name	Include subdocument of same type	New semantic macro
\&.eI subdocument_name	Include subdocument of example type	New semantic macro
\&.pI subdocument_name	Include PostScript subdocument	New semantic macro

\&.ds	Define string for expansion	Existing markup

\&.pM	Page markup information	New semantic macro
.TE
.ne 10
.TB "GPSML Markup For Escapes" 
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
\&.nP	Force a page break here	New "semantic" macro
\&.ne x	Reserve x lines on one page	Existing markup
\&.nL	Force a line break	New "semantic" macro	

\&.wH	Tag text converted from another language, not recognized	New semantic macro
.TE
.ne 6 
.TB "RSML Macros That Define Document Structure"
.TS
center,box;
l | l l.
\fBMacro Name	Macro Function	Macro Origin and Status\fR 
_
\&.TH	Top head in reference page	Existing \fBman\fP Macro
\&.SH	Text head in reference page	Existing \fBman\fP Macro
\&.SS	Subhead in reference page	Existing \fBman\fP Macro
.TE
.ne 15
.TB "RSML Macros That Delimit Titled Elements of a Document"
.TS H
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status\fR 
_
.TH
_
\&.TB	Table title	Existing \fBmm\fP/\fBman\fP macro
\&.TS	Start table	Existing \fBmm\fP/\fBman\fP macro
\&.TE	End table	Existing \fBmm\fP/\fBman\fP macro
\&.T&	Table continue	Existing \fBmm\fP/\fBman\fP macro
\&.tH	Table header ends	New semantic macro (equiv. to .TH) 
			
\&.FG	Figure title	Existing \fBmm\fP/\fBman\fP macro
\&.PS	\fBpic\fP drawing start	Existing \fBmm\fP/\fBman\fP macro
\&.PE	\fBpic\fP drawing end	Existing \fBmm\fP/\fBman\fP macro
			
\&.EC	Equation caption	Existing \fBmm\fP/\fBman\fP macro
\&.EN	End equation	Existing \fBmm\fP/\fBman\fP macro
\&.EQ	Start equation	Existing \fBmm\fP/\fBman\fP macro

\&.EX	Exhibit caption	\fBmm\fP macro
.TE
.ne 15
.TB "RSML Macros That Delimit Untitled Elements of a Document"
.TS H
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status\fR 
.TH
_
\&.P	Paragraph	\fBmm\fP macro
\&.PP	Paragraph	\fBman\fP macro; we add to \fBmm\fP
_
\&.ML	Start nonsequential invariant list	\fBmm\fP macro; we add to \fBman\fP
\&.VL	Start nonsequential variant list	\fBmm\fP macro; we add to \fBman\fP
\&.AL	Start sequential invariant list	Existing \fBmm\fP macro; we add to \fBman\fP
\&.LI	List item	\fBmm\fP macro; we add to \fBman\fP
\&.LE	End of list	\fBmm\fP macro; we add to \fBman\fP
_
\&.oS	Start system output example region	New semantic macro
\&.oE	End system output example region	New semantic macro
			
\&.iS	Start user input example region	New semantic macro
\&.iE	End user input example region	New semantic macro

\&.RS	Start reference region	\fBmm\fP macro; we add to \fBman\fP
\&.RF	End reference region	\fBmm\fP macro; we add to \fBman\fP

\&.rS	Start indent region	Equivalent to .RS* 
\&.rE	End indent region	Equivalent to .RE
			
\&.cS	Start comment region	New semantic macro
\&.cE	End comment region	New semantic macro
\&...\e"	One-line comment	Existing markup

\&.lS	Start localization region	New semantic macro
\&.lE	End localization region	New semantic macro
.TE
.P
*We do not recommend the use of .rS/.rE.
.ne 15
.TB "RSML Meaningful Text Markup"
.TS H
center,box;
l | l | l.
\fBMarkup code	Function	Macro Origin and Status \fR 
.TH
_
\&\e*Lname\e*O	Literal	New semantic markup
\&\e*Vname\e*O	Variable	New semantic markup
\&\e*Aname\e*O	Alphabetic constant 	New semantic markup
\&\e*Nname\e*O	Numeric constant 	New semantic markup
\&\e*Oordinary text	Ordinary Text 	New semantic markup
\&\e*ISystem input\e*O	System Input 	New semantic markup
\&\e*CComputer output\e*O	Computer Output 	New semantic markup
_
\&.sS	 Start synopsis definition	New semantic markup
\&.sE	 End synopsis definition	New semantic markup

\&.fS	 Start function definition 	New semantic markup
\&.fE	 End function definition 	New semantic markup

\&.dS [opt]	Start type declaration 	New semantic markup
\&.dE	End type declaration 	New semantic markup
.TE
.ne 20
.TB "RSML Macros for Tagging Index, Key, and Glossary Entries"
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
\&.kY "key"	Name of keyboard key	New semantic macro
\&.K, "key" "text"	Keyboard key name + ordinary text	New semantic macro
\&.,K "text" "key"	ordinary text + keyboard key name	New semantic macro

\&.gL "term" 	Glossary term	New semantic macro
\&.G, "term" "text"	Keyboard key name + ordinary text	New semantic macro
\&.,G "text" "term"	ordinary text + keyboard key name	New semantic macro

\&.eM "phrase"	Emphasized phrase	New semantic macro
\&.G, "phrase" "text"	Emphasized phrase + ordinary text	New semantic macro
\&.,G "text" "phrase"	ordinary text + emphasized phrase	New semantic macro

\&.OK	Key words	Existing \fBmm\fP macro

\&.iX	Index entry	New semantic macro
.TE
.ne 10
.TB "RSML Macros That Include, Define Strings, and Mark Pages" 
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
\&.dI subdocument_name	Include subdocument of same type	New semantic macro
\&.eI subdocument_name	Include subdocument of example type	New semantic macro
\&.pI subdocument_name	Include PostScript\u*\d subdocument	New semantic macro

\&.ds	Define string for expansion	Existing markup

\&.pM	Page markup information	New semantic macro
.TE
.ne 10
.TB "RSML Markup For Escapes" 
.TS
center,box;
l | l | l.
\fBMacro Name	Macro Function	Macro Origin and Status \fR 
_
\&.nP	Force a page break here	New semantic macro
\&.ne x	Reserve x lines on one page	Existing markup
\&.nL	Force a line break	New semantic macro	

\&.wH	Tag text converted from another language, not recognized	New semantic macro
.TE
