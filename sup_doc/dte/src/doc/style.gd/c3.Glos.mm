...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c3.Glos.mm,v $
.\" Revision 1.1.2.6  1994/06/24  15:15:18  fred
.\" 	free copyright
.\" 	[1994/06/23  20:21:34  fred]
.\"
.\" Revision 1.1.2.5  1994/06/23  18:39:14  fred
.\" 	free copyright
.\" 	[1994/06/22  19:09:26  fred]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:05:53  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:02:26  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:35:50  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:32:56  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:05:07  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:57:34  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
.H 2 "Glossaries"
.iX "-[" "glossaries"
.iX "creating" "glossaries"
.P
A glossary is a list of difficult or specialized words with their 
definitions, often placed at the back of a document.  It is important to recognize how vitally important glossaries are for nonative readers and translators.  The glossary is where they find out what new terms mean.
.P
The guidelines for creating glossaries focus on three things:
planning your glossary, whether it is new or a revision;
how your glossary entries should look and read, 
depending on the word or words you are defining; and some
reference books, which you can
use to help make your glossary entries as accurate
and useful as possible.
.H 3 "Planning Your Glossary"
.br
.iX "glossaries" "planning"
.iX "planning" "glossaries"
.P
First, decide whether your document warrants a glossary at all.
.P
You need to plan your glossary, much as you plan your index, while 
you are writing or revising your document.  If your document is new, you
must decide whether terms you are including
in text are likely to require more definition than their context
gives them\(emand if they do, you must come up
with definitions that are as accurate and contextually correct
as possible.  Equally, you must decide whether the terms are
.I difficult 
or 
.IR specialized .
.iX "internationalization"
If they are not, they should not be included in the glossary.  Keep in mind, too, that your audience is international. 
Terms that are 
.I not 
considered to be difficult or specialized among U.S. users may
seem arcane and awkward (particularly after translation) to
users in other countries.
.P
If your document is a revision, look at the current
glossary and decide what to keep, what to
revise (and perhaps correct), what to add, and what to cut \(em on 
basis that the terms are commonly defined in other glossaries, well-defined
within the document itself, or more elementary than the audience for
the document requires.
.P
You should include your glossary entries in your index: first,
index the term where it is defined within the text of your 
document and next, index the term where it is defined in the
glossary.  It is (theoretically) a simple matter to apply an
index token to your glossary 
entries at the same time you mark them 
at the introduction of the terms in text.  
.P
.iX "glossaries" "selecting terms"
.iX "terms, glossary"
You may include terms in your glossary that are
.I not 
included in the text of your document.  You should not, however, fill
your glossary with all the terms you can think of.  Add terms
that are synonymous with others in your glossary, or that
are informationally tied to other terms you have presented, and
cross-reference these terms to the ones you use 
in your document.
.H 3 "Creating Your Glossary Entries (Internationalization Issues Must be Addressed)"
.iX "entries, glossary"
.br
.P
Following are guidelines\(emprimarily grammatical\(emfor creating 
glossary entries.  This list includes guidelines most pertinent
to the glossaries we create to accompany our documentation.
The rules were culled from various reference documents.
.P
When creating or revising a glossary entry, adhere to the 
following guidelines:
.BL
.LI
Alphabetizing your English glossary, or using collating order for internationalization.
.P
Arrange your glossary in alphabetical order, ignoring spaces,
punctuation, and numbers in the entry titles.  Terms of two 
or more words should be alphabetized in the order
most familiar to the people who use them. For more information
about alphabetizing, see 
.B Alphabetizing
earlier in this chapter.
.br
[This example must be a leftover. No principles are described  here. nc]
.P
Here are two brief, alphabetically arranged lists that illustrate
some of these principles:
.DS 1
Clock cycle		DBMS
Clocked flip-flop	DC300, DC100 cartridges
Clocking		dc signaling
Clock pulses		DDC
Clock rate		DDCMP
.DE
.LI
Capitalizing a glossary
.P
Use either the initial-cap style or case-sensitive style of
capitalization (discussed in 
.BR "Capitalization" ,
but whichever system you follow, use it 
consistently throughout the glossary.
.DS "" F 1i 
.in 1i
.ti -\w@\fBNOTE:\ \ \fR@u
.B "NOTE:\ \ \c"
The examples in this section follow the initial-cap style.
.DE
.LI
Using descriptive phrases
.P
Following the glossary term, provide a 
.I "descriptive phrase" 
that defines the term.  Assume 
that this phrase is preceded by the phrase "\fIterm\fR is."  The
descriptive phrase completes the initial sentence.  The part of 
speech of the term being defined is indicated by the introductory
words in the descriptive phrase, where the word "to" indicates a
.IR verb ,
"pertaining to" indicates a 
.IR modifier , 
and other words indicate a 
.I noun 
or 
.IR "noun phrase" .
.P
Here are some examples:
.VL .5i
.LI "\fBtransmit\fR"
.br
To move data from one location to another location.
.I See
.BR Transfer .
.RI ( "verb form" )
.LI "\fBtransmission\fR"
.br
The electrical transfer of a signal, message, or other form of
intelligence from one location to another.
.RI ( "noun form" )
.LI "\fBaerodynamic\fR"
.br
Pertaining to forces acting upon any 
solid or liquid body moving relative to a gas
(especially air). 
.RI ( "modifier form" )
.LE 
.P
Other, more pertinent modifier forms are terms like 
.B hard
and 
.B soft
defined alone (as in hard or soft error). You should
have few modifier form references 
.RB ( "hard error" ,
for instance, would be included in your glossary in full, 
not just listed as 
.BR hard ).
.LI
Expanding the definition
.P
Following your descriptive phrase, you can include a brief 
amplification of your initial definition.  In 
addition, you can provide references to other terms within
your glossary.
.P
If an entry requires a generic definition
before you go on to provide a specific context for the term,
give the generic definition, then say something like:
.IR "In networking terms" ,
or 
.IR "From a communications point of view" .
Here is an example:
.VL .5i
.LI "\fBapplication program\fR"
.br
A program written for or by a user that applies to the user's work.
In networking terms, a program used to connect and communicate.
.I See
.BR Transfer .
.RI ( "verb form" )
.LE
.iX "cross-references" "in glossaries"
.LI
Making cross-references
.P
Use 
.I See 
references for multiple word terms that have the same last word or words.
Be judicious in your use of 
.I See
references for other kinds of terms.  Use 
.I "See also"
references for terms that have 
.IR similar ,
but 
.IR "not synonymous" ,
meanings.  Following are examples of uses of the 
.I See 
and 
.I "See also"
references:
.VL .5i
.LI "\fBtransmission gain\fR"
.br
.I See
.BR gain .
.br
(In this case, the main entry is listed under \fBgain\fR.)
.LI "\fBtransmitter-receiver\fR"
.br
.I See
.BR transceiver .
.br
(In this case, the \fISee\fR reference refers to the synonymous, widely used 
version
of the term.)
.LI "\fBopen circuit\fR"
.br
\fISee also\fB closed circuit\fR.
.P
The \fISee also\fR
reference is often used to contrast opposites: the meanings
of open and closed circuit, for instance, in that they describe
two states of a circuit; however, they are not synonymous
but opposite.
.LE
.LI
.iX "acronyms" "in glossaries"
.iX "abbreviations" "in glossaries"
.iX "glossaries" "acronyms and abbreviations"
Defining acronyms and abbreviations
.P
Place the definition of an acronym or abbreviation in either its
spelled-out form
or shortened form, depending on how
it is better known in the industry, and put a 
.I See
cross-reference where you list the other form.
Another rule of thumb is this: if you can 
pronounce the acronym or abbreviation ("scuzzy" 
as opposed to "S-C-S-I"), define it under
the shortened form with a cross-reference at its spelled-out form.
.VL .5i
.LI "\fBASCII\fR"
.br
Acronym for American National Standard Code for Information
Interchange...
.LE
.P
In this case, ASCII (asky), like SCSI (scuzzy) and NASA, is an
acronym that is commonly pronounced as a word.  As such, the
entry for it should follow the term ASCII, with the
spelled-out term providing a 
.I See
reference to ASCII.
.P
The definition for an abbreviation or acronym should 
.I usually
be placed with the spelled-out form for the term,
which then makes a cross-reference to the
abbreviation or acronym.  However, if the shorter form is in
.IR "common use" ,
then treat it as a pronounceable term.
.P
For example, define IEEE and SNA, which are widely known acronyms in
the industry, as primary entries, and put a 
.I See
reference at the spelled-out versions.
.LI
.iX "sources" "in glossaries"
.iX "glossaries" "citing other sources"
Citing other sources
.P
Use glossary definitions that can be found in a definitive form in the standards and other 
dictionaries.  You can include these already-written and 
approved definitions in your glossary by prefacing your glossaries 
with a reference to the sources that you use.
.P
Following is the general phrasing you should use to introduce you
glossary when in contains borrowed glossary definitions:
.DS I F \"*** I=standard indent; F=fill
This glossary contains definitions from the following sources:
the 
.IR "American National Dictionary for Information Processing Systems" ,
copyright 1982 by the Computer and Business Equipment Manufacturers 
Association; the 
.IR "IBM Dictionary of Computing" ,
Eighth Edition, 1987; and published sections of the 
.IR "ISO Vocabulary of Data Processing" .
An asterisk indicates that the definition is from the first
source, two asterisks indicate the second source, and
the label (ISO) indicates the definition is from the
last source.
.DE
.P
Here are examples of some terms and their definitions (some of the
conventions used in differing sources have been ignored in transferring
the definitions to this document).  [fix this Noreen!] The term
illustrated is the same; the definitions, which come from various
sources, are not.
.VL .5i
.LI "\fB*attenuation\fR"
.br
A general term used to denote a decrease in
signal magnitude in transmission
from one point to another.  Attenuation may be
expressed as a scalar ratio of the input
magnitude to the output magnitude or in decibels.
.LE
.P
The preceding example is a fairly straightforward entry.
.VL .5i
.LI "\fB**attenuation\fR"
.br
The reduction in amplitude of a 
.B signal 
when it passes through a medium
that dissipates its energy.  It is usually measured in decibels 
(attenuation then being negative while gain is 
positive).
.LE
.P
This example included a reference to another term entered in the
glossary: 
.BR signal .
.P
Use an asterisk (*) or other tag (ISO, for instance, as shown in 
the disclaimer example) to 
mark the terms that are excerpted from published 
dictionaries and glossaries other than those of OSF.
Your reference to 
.I all
of the works from which you borrowed definitions covers us 
legally.  However, be aware that if you have a very small book with a 
very large, borrowed glossary, you risk exceeding the \fIfair use\fR limitations that
allow us to use these informational bits of copyrighted text without special
permissions.
.LE
.H 3 "Going to the Source"
.br
.iX "glossaries" "finding sources"
.iX "finding, glossary sources"
.P
You can verify the accuracy and the global meaning of your glossary
entries in any library that has copies of the following reference works:
.BL
.LI
\fIIEEE Standard Dictionary of Electrical and Electronics Terms 
(ANSI/IEEE Standard 100-1984)\fR
.LI
\fIThe Dictionary of Computing\fR (Oxford University Press)
.LI
\fIMcGraw-Hill Dictionary of Scientific and Technical Terms\fR, 
Third Edition
.LI
\fIThe Dictionary of Computing\fR, Eighth Edition (IBM\(rg)
.LI
\fIAmerican National Dictionary for Information Processing Systems\fR
.LE
.P
You may also choose to use one or more of the definitions of
terms used in these books in your glossary.  
You may use these definitions in the following different ways:
.BL
.LI
You may use the definition verbatim, as long as you include a prefacing 
notation to your glossary that says you have 
used a definition from that source and that
the definition (or definitions, if you use more than one of them) is
marked with an asterisk or other tag that identifies the 
excerpted definition. Refer to the example in Section 3.31.2. 
.LI
You may reword the definition.  You should only choose to reword the
definition, however, if it is substantially different in tone from
the writing style used in your document, or if the definition is not specific to 
your product or technical area of discussion.
.LE
.P
In addition to providing you with industry-standard glossary definitions,
these reference works can give you some ideas for your own 
glossaries\(emideas for cross-references that you may
not have thought about, for instance.
.iX "-]" "glossaries"
