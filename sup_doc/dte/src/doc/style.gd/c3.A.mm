...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c3.A.mm,v $
.\" Revision 1.1.2.6  1994/06/24  15:15:10  fred
.\" 	free copyright
.\" 	[1994/06/23  20:21:21  fred]
.\"
.\" Revision 1.1.2.5  1994/06/23  18:39:05  fred
.\" 	free copyright
.\" 	[1994/06/22  19:09:02  fred]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:05:46  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:02:15  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:35:44  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:32:45  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:04:39  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:57:16  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
.H 1 "Usage Guidelines"
.iX "usage"
This chapter contains miscellaneous guidelines on usage, arranged
alphabetically. It also contains extensive information pertaining to
translations considerations. Follow these guidelines whether or not
you think your documentation will be translated.
.P
Considerations of
internationalization, online documentation, help, and human factors
are interspersed throughout this document, rather than appearing in discrete
appendixes.  In this way, we hope to make this information more usable and
more readily available.
.H 2 "Abbreviations"
.iX "-: Internationalization" "Translation considerations" 
.iX "abbreviations" "rules for using"
.P
Use the following guidelines for abbreviations:
.iX "internationalization" "abbreviations"
.BL 
.LI
Whenever possible, avoid using abbreviations.  Abbreviations are easy
to misinterpret, especially abbreviations for words that are not
translated.  Also, users may encounter an
abbreviation after its definition, and must then search through previous
pages or screens to find the meaning.
.iX "abbreviations" "in text"
.iX "abbreviations" "first use"
.iX "abbreviations" "in long manuals"
.iX "abbreviations" "later occurrences of"
.LI
When you use an abbreviation, spell out the name and follow it with the
abbreviation in parentheses the first time you use it in each chapter. 
.DS 1
The Central Processing Unit (CPU) interprets the instruction.
.DE
.iX "abbreviations" "in titles"
.LI
Generally, avoid using abbreviations in chapter and section titles.  
When you must use an abbreviation in a title, define the abbreviation in the
text that follows.  In later occurrences, use either the spelled-out term or
the abbreviation, but be consistent throughout the manual.
.iX "abbreviations" "in tables"
.iX "abbreviations" "in figures"
.iX "abbreviations" "in examples"
.iX "abbreviations" "in footnotes"
.LI
You may use abbreviations in tables, examples, figures,
and footnotes.  Define abbreviations before using them in
tables; do not define abbreviations in tables.
.LI
Generally, avoid beginning sentences with abbreviations.
.LI
Do not use periods with abbreviations, unless the abbreviation can be
confused with an actual word (no. for number;  in. for inch).
.LI
.iX "abbreviations" "and numbers"
Insert one space between a number and the abbreviation or unit
symbol it modifies.  Exceptions include KB, MB, kHz, MHz, GHz, and K
unless they are used as modifiers in which case insert a hyphen (for
example, a 512-MB memory).
.DS 1
6 ft	6MB	6KB	6MHz	6kHz
.DE
.iX "abbreviations" "plurals of"
.LI
Form plurals of most abbreviations by adding a
lowercase
.I s .  
.P
Plural abbreviations of units of measurement are exceptions to this
guideline. Singular and plural abbreviations of units of measurement are
identical.  
.DS 1
1 lb	10 lb
1 h	20 h
1 km	4 km
1 in.	6 in.   
.DE
.iX "abbreviations" "in a series"
.LI
When using abbreviations in a series with two or more items, place the
abbreviation for a unit of measurement at the end of the
series.
.DS 1
1200, 1400, or 1600MHz
.DE
.LI
If the series has only two items, repeat the abbreviation for a unit
of measurement. 
.\" 
.\" This material is duplicated in the "numbers" and  "symbols" entries.
.\" 
.DS 1 
10 ft to 12 ft
.DE
.LI
Avoid examples that require an alphabetically ordered list of abbreviations
to convey meaning.  This can cause translation difficulties because the
translated list will probably not be in alphabetical order.  If you cannot
avoid using an alphabetically ordered list, 
include a comment in the source file
indicating the purpose of the example so that the translators can
design an example that is appropriate for their country.
.LI
The abbreviation
.I K
can mean either 1024 (a binary
thousand) or Kelvin. The difference between these two uses of
K is usually clear in context.  
.DS 1
For proper operation, a superconducting board with 64K words of 
memory must be cooled to a temperature of 5K.
.DE
.LE
.P
See also
.B "acronyms, mnemonics" ,
and
.B  measurements.
.H 2 "acronyms and Mnemonics"
.P
Acronyms are words formed from the initial letters  or parts of
compound terms.  Mnemonics are memory aids,  often created by
combining letters to form word-like expressions.
.iX "acronyms" "rules for using"
.iX "mnemonics" "rules for using"
.iX "formin" "plurals, of acronyms"
.iX "acronyms" "translating"
.iX "mnemonics" "translating"
.BL 
.LI
Use acronyms to refer to product names.  Never spell out acronyms that
are trademarks.  If the acronyms are trademarks, acronyms may
include lowercase letters. 
.P 1
.I Use
.DS 1
LSE is a text editor.
.DE
.LI
Whenever possible, avoid using
acronyms or mnemonics unless referring to product names.
Acronyms and mnemonics are not directly translatable, and
can have negative connotations in other languages.  
.P 1
.I "Do not use"
.DS 1
Acronyms are an I18N concern.
.DE
.LI
When you use an acronym or mnemonic, spell out the word or phrase and 
follow it with the shortened form in parentheses the first time you use it.
In later occurrences, use the acronym or mnemonic.  Define acronyms in a
glossary.
.iX "acronyms" "in titles"
.iX "mnemonics" "in titles"
.LI
Whenever possible, avoid using acronyms and mnemonics in chapter and section
titles.  
When you must use an acronym or mnemonic in a title, define it in the
text that follows. In later occurrences, use the acronym or mnemonic. 
.iX "acronyms" "in tables"
.iX "acronyms" "in examples"
.iX "acronyms" "in figures"
.iX "acronyms" "in footnotes"
.iX "mnemonics" "in tables"
.iX "mnemonics" "in examples"
.iX "mnemonics" "in figures"
.iX "mnemonics" "in footnotes"
.LI
Use acronyms and mnemonics in tables, examples, 
figures, and footnotes, provided that you have explained them fully
in the preceding text.
.LI
Use acronyms and mnemonics to start sentences, provided that
you have explained them fully in the preceding text.
.iX "acronyms" "plurals of"
.iX "mnemonics" "plurals of"
.LI
Form plurals of acronyms and mnemonics by adding a 
lowercase
.I s .
.DS 1
OEMs
ACLs
PCs
Ns
.DE
.iX "acronyms" "alphabetizing"
.LI
Avoid examples that require an alphabetically ordered list of acronyms
to convey meaning.  This can cause translation difficulties because the
translated list will probably not be in alphabetical order.  If you must
use an alphabetically ordered list, include a comment in the source file
indicating the purpose of the list so that the translators can
design an example that is appropriate for their country.
.LI
Spell acronyms and mnemonics without periods or intervening spaces.
.LI
In general, use uppercase letters for acronyms and mnemonics.  Acronyms
can include
lowercase letters if the acronyms are trademarks.
.LI
Many product names are acronyms for longer phrases that describe
the product.  The derivation of the acronym may be of
little importance to the reader, or the acronym may be so commonly used that 
its expansion is unnecessary; for example, BASIC or FORTRAN.   In this case, 
omit the descriptive phrase.  Do not capitalize the letters of the
acronym in the spelled-out version unless their capitalization is required.
.P 1
.I Use
.DS 1
data exchange control (DXC)
Institute of Electrical and Electronics Engineers (IEEE)
.DE
.P 1
.I "Do not use"
.DS 1
Data eXchange Control (DXC)
.DE
.LE
.H 2 "Adjectives, Strings of"
.iX "adjectives" "strings of"
.iX "internationalization" "adjectives, strings of"
.P
Do not overuse adjectives. A string of adjectives is difficult to follow
and can lead to misinterpretation and incorrect translation.
The following sentence is clearer (and the
hyphenation problem disappears) with the use of a wider variety of parts of
speech.
.P 1
.I Use
.DS 1
Four constants partition the range of the function; these 
constants are determined by the data type.
.DE
.P 1
.I "Do not use"
.DS 1
Four data-type-dependent constants partition the range of the function.
.DE
.P
.H 2 "Alphabetizing (International Issues Must be Addressed)" 
.P
Use the following guidelines for alphabetizing acronyms, symbols, and
numbers in the English language.  Use collating order for non-English languages.
.iX "alphabetizing" "lists"
.iX "alphabetizing" "tables"
.iX "-:" "indexes" "alphabetizing, indexes"
.iX "Translation considerations" "alphabetizing"
.BL 
.LI
Avoid examples that require an alphabetically ordered list or table to convey
meaning.  This can cause translation difficulties because the translated
list or table will
probably not be in alphabetical order.  If you must use an
alphabetically ordered list or table, include a comment in the source file
indicating the purpose of the list or table so that the translators can
design an example that is appropriate for their country.
.LI
Alphabetize acronyms according to their shortened form.
.LI
Alphabetize symbols as though they were spelled out. 
.DS 1
&	(ampersand)
@	(at)
%	(percent)
.DE
.LI
In an alphabetized list, arrange numbers in ascending order. 
.P 1
.I Use
.DS 1
18
24
56
89
.DE
.LE
.H 2 "And/or"
.iX "and/or"
.iX "internationalization" "and/or"
.P
Use the and/or construction sparingly. It is preferable to rewrite the
sentence entirely, or to use the two
choices, followed by
.I "or both" .
.P 1
.I Use
.DS 1
File specifications or logical names, or both
.DE
.P 1
.I "Do not use"
.DS 1
File specifications and/or logical names
.DE
.H 2 "Apostrophes"
.iX "apostrophes" "to form possessives"
.P
Use the following guidelines when using apostrophes to form plurals:
.iX "apostrophes" "to form plurals"
.BL
.LI
Do not use an apostrophe to form the plural of an acronym, mnemonic, or
number.  Use
just a lowercase
.I s .  
.DS 1
OEMs
4s
1920s
.DE
.LI
Use an apostrophe and a lowercase
.I s
to form the plural of a
lowercase letter used as a noun. 
.DS 1
a's	s's	x's	y's
.DE
.LI
Use the term single quotes instead of apostrophe to describe syntax
for parallelism with double quotes.
.P 1
.I Use
.DS 1
Enclose a character string in single quotes or double quotes.
.DE
.P 1
.I "Do not use"
.DS 1
Enclose a character string in apostrophes or double quotes.
.DE
.LE
.H 2 "Articles"
.iX "articles" "use of"
.iX "the, used as article"
.iX "internationalization" "articles"
.iX "a" "used  as article"
.iX "an" "used as article"
.P
In English, the articles are
.I a ,
.I an ,
and
.I the .
Omit articles only when limited by space considerations such as
in tables.  Otherwise, do
not use instructions that omit articles.  This telegraphic
style of writing can lead to misinterpretations and incorrect translation.
.P 1
.I Use
.DS 1
Remove \fIthe\fP diskette from \fIthe\fP envelope.
.DE
.P 1
.I "Do not use"
.DS 1
Remove diskette from envelope.
.DE
