...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c3.K-N.mm,v $
.\" Revision 1.1.2.6  1994/06/24  15:15:26  fred
.\" 	free copyright
.\" 	[1994/06/23  20:21:46  fred]
.\"
.\" Revision 1.1.2.5  1994/06/23  18:39:22  fred
.\" 	free copyright
.\" 	[1994/06/22  19:09:50  fred]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:05:58  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:02:38  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:35:56  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:33:06  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:05:29  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:57:49  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
.H 2 "Keyboards"
.\" 
.\" ***PIP Rev. B***
.\" 
.iX "keyboards"
.iX "internationalization" "keyboards"
.iX "-: internationalization" "I18N"
.P
A variety of keyboards are in use around the world. Functions 
bound to particular keys in the U.S. version of a product may be bound to
entirely different keys for products that
are localized for other countries.  Follow these guidelines when
documenting keyboards:
.BL 
.LI
Select a default keyboard to document, and develop a method for
providing information about alternative keyboards.
.LI
Put as much keyboard information online as possible.  It is easier
to modify keyboard information that is presented online than it is to
modify hard-copy information.
.LI
Use
.I "function names"
rather than
.I "key cap names"
in documenting software applications.
.LE
.H 2 "Keys"
.iX "keys"
.P
Follow these guidelines when referring to keys on the keyboard: 
.BL 
.LI
Always use the verb
.I press
when referring to keys. Do not use the verbs
.I strike ,
.I punch ,
.I depress , 
or
.I hit .
.LI
Always refer to keys on the keyboard as
.I keys ,
never as 
.I buttons .
.LI
Do not use the name of a key as an adjective if the name appears on the
keyboard.
.P 1
.I Use
.DS 1
Press \fB<Return>\fR.
.DE
.P 1
.I "Do not use"
.DS 1
Press the \fBReturn\fR key.
.DE
.LI
Use initial capital letters for the name of a key if the key is labeled on 
the keyboard. 
.DS 1
\fB<Delete>
<Return>
<Shift>
<Tab>\fR
.DE
.LI
Use lowercase letters when the key to which you are referring is 
.I not
labeled on the keyboard. 
.DS 1
space bar
comma key
period key
up arrow key
slash key
.DE
.LI
Use
.I x
to refer to a generic letter key; use 
.I n
to refer to a generic number key.
.LI
You can refer to keys in text in two ways: by enclosing the
name of the key in angle brackets (for example, \fB<Return>\fR)
or by placing the name of the key in a phrase (for example, 
the \fBReturn\fR key).
.DS "" F 1i 
.in 1i
.ti -\w@\fBNOTE:\ \ \fR@u
.B "NOTE:\ \ \c"
The angle brackets replace the word key; do not write
"the \fB<Return>\fR key."
.DE
.P
In running text, you may find that it is clearer to use 
"the ___ key," for example, 
.DS 1
The Shell key creates a new shell process.
.DE
.P
In command lines and tables, it is probably clearer to use the
angle bracket convention.
.LI
To indicate a sequence such as \fB<Ctrl-\fIX\fB>\fR, in which you must hold down the
control key while you press another key or a mouse button, use
a slash between the two key names.
.LI
Use a dash between the key names when you want the use to press keys
simultaneously.  For example, \fB<Ctrl-C>\fR indicates that the user holds
down \fB<Ctrl>\fR while pressing \fB<C>\fR.
.LI
In text, when you want the user to press two keys sequentially, write the
text to say so.
.DS 1
Press and release the \fBF1\fR key, and then press the \fBW\fR key.
.DE
.P
In command lines and tables, use the angle bracket convention:
.DS 1
Press \fB<F1>\fR and \fB<W>\fR.
.DE
.LE
.H 2 "Latin Expressions"
.iX "Latin expressions"
.iX "abbreviations, Latin"
.iX "expressions, Latin"
.P
Do not use Latin expressions in technical documentation.
.I Versus ,
.I "vice versa" ,
.I per , 
and
.I via
are the only exceptions; they are commonly used in
technical documentation.  In general, substitute one of the 
corresponding English translations:
.iX "-: Latin expressions" "circa"
.iX "-: Latin expressions" "cf."
.iX "-: Latin expressions" "e.g."
.iX "-: Latin expressions" "et al."
.iX "-: Latin expressions" "etc."
.iX "-: Latin expressions" "i.e." 
.iX "-: Latin expressions" "versus"
.iX "-: Latin expressions" "via"
.iX "-: Latin expressions" "vice versa"
.iX "-: Latin expressions" "viz." 
.TS H 
center,box,tab(@);
lb | lb
lw(1.5i) | l.
.sp 4p
Latin@English
.sp 4p
_
.sp 4p
.TH
ca, circa@About
cf.@Compare
e.g.@For example
et al.@And others
etc.@And so forth, and so on
i.e.@That is
viz.@Namely
.sp 6p
.TE
.R
.H 2 "Lists"
.iX "lists"
.br
.P
Begin the first word of each item (bulleted or enumerated) with a 
capital letter.
.P
In a variable (2-column) list, bold the mark (the item in the
first column).
.P
Omit all ending punctuation (see Example A) unless an item is a complete
sentence.  If one item requires ending punctuation, then all
items should use ending punctuation (even if they are not
complete sentences (see Example B).
.P
When introducing a list, use 
a colon at the end of the introductory phrase when the phrase
includes the words "the following" or 
"as follows" (see Example A).
If the elements of the list are a complement of the
introductory phrase (see Example B), do not use a colon
at the end of the phrase. (In other words, do not put a colon
between a verb and its complement or object, or between a
preposition and its object).
.P
Second-level lists start with a dash (see Example C.)
.P
If you include sublistings to items in enumerated lists,
number the sublistings alphabetically; do not use
bullets with an enumerated list (see Example D).
.P
If a list clearly indicates a sequence (for example, a
series of steps in a procedure) or a hierarchy, 
use an enumerated list (see Example D).  Otherwise, use
bulleted lists.
.P
Use 1. instead of 1.) in enumerated lists.
.P
.B "Example A: Bulleted List With No Periods, Introduced With a Colon
.P
The graphics primitives include the following capabilities:
.BL
.LI
Drawing lines, circles, and rectangles
.LI
Loading text fonts and manipulating text
.LI
Filling polygon areas
.LI
Setting attributes
.LI
Storing bitmaps externally
.LE
.P
.B "Example B: Bulleted List With Periods, Introduced Without a Colon
.P
For the application, OSF/1 enables you to 
.BL
.LI
Write less code.  Because OSF/1 handles interactions with the
user, the application designer does not have to provide the code for 
doing so.
.LI
Achieve a modular approach to writing code that promotes phased and
iterative application development independent of user-interface
development.
.LE
.P
.B "Example C: Bulleted List With Sublist, Introduced Without a Colon"
.P
The product lets you
.BL
.LI
Do this, which consists of 
.DL
.LI
This thing
.LI
This other thing
.LE
.LI
Do this
.LE
.P
.B "Example D: Enumerated List With Periods and Sublist, Introduced With a Colon"
.P
Perform these steps to move the printer:
.AL
.LI
Shut down the  workstation.
.LI
Turn off the printer.
.AL a
.LI
Press the OFFLINE switch to place the printer off line.
.LI
Set the power switch to the off position.
.LE
.LI
Unplug the workstation.
.LE
.H 2 "Measurements"
.iX "measurements"
.iX "internationalization" "measurements"
.iX "height" "specifying"
.iX "weight" "specifying"
.iX "length" "specifying"
.iX "width" "specifying"
.iX "metric units"
.iX "precision" "in measurement"
.\" 
.\" ***PIP Rev. B***
.\" 
.P
.\"Software manuals often provide measurement information concerning bits,
.\"bytes, characters, lines, records, and blocks.  
.\"Hardware manuals, installation guides, and site set-up guides often provide
.\"information on height, length, width, and weight of products.  
Provide measurements in metric units and unit symbols.  When specifying product
requirements, use the following rules:
.BL 
.LI
Use the metric units first, followed by the U.S. equivalent in
parentheses.
.LI
Comment the source file indicating which units of measurement are
used.  That way, if the document is translated, the translator knows
which units of measurement were used.
.LI
Make sure that the precision of a converted measurement reflects the
precision of the original measurement. 
.DS 1
The data is from a body scan that is 3.05 meters (10.00 feet).
.DE
.LE
.P
See also
.B numbers .
.H 2 "Money"
.iX "money"
.iX "monetary values"
.iX "internationalization" "money"
.\" 
.\" ***PIP Rev. B***
.\" 
.P
Monetary values are country-specific information.
.BL 
.LI
Avoid reference to monetary values of products or services in user
documents.
.LI
If you use monetary values in examples, include a comment in the source file
indicating the purpose of the example.  That way, if the document is
translated, the translator can design an appropriate example using local
currency.
.LE
.H 2 "Mouse"
.iX "mouse"
.iX "puck"
.iX "stylus"
.iX "pointing device"
.iX "online" "mouse"
.P
Use the following guidelines in when refering to pointing devices, screen
buttons, and menu operations:
.BL 
.LI
You can use the term
.I mouse
to refer to any pointing device, such as graphic tablets, joy sticks, track balls, or special sets of graphics navigation keys. 
\".I mouse ,
\".I puck , 
\"or
\".I stylus .
.LI
If you use the term
.I mouse 
to refer to a 
.\".I puck
.\"or
.\".I stylus ,
one of the preceding devices,
you must define the usage in your document.
.LI
Always refer to a button on your pointing device as a
.I "mouse button" ,
.I "puck button" , 
or 
.I "stylus button" .
Avoid the generic 
.I button .
If it does not matter what pointing 
device is used, current documentation uses
.I "mouse button"
as the generic term.
.DL
.\".LI
.\"You can also use
.\".I MB1 ,
.\".I MB2 , 
.\"and
.\".I MB3
.\"for mouse buttons.
.\".LI
.\"You can also use
.\".I PB1 ,
.\".I PB2 ,
.\".I PB3 , 
.\"and
.\".I PB4
.\"for buttons on a puck.
.\".LI
.\"You can also use
.\".I SB1
.\"and
.\".I SB2
.\"for buttons on a stylus.
.LE
.LI
Always refer to a button on the screen as a
.I "screen button" ,
unless you are specifying a particular screen button.  
.DS 1
Click on the OK button.
Use your mouse to click on any screen buttons.
.DE
.LI
Use the verbs
.I click ,
.I "double-click" ,
.I drag ,
.I press ,
.I press
and
.I hold , 
and
.I release
when referring to mouse buttons. 
.DS 1
To move from one Calendar display to another, double-click
on the appropriate item in the current display.

Click on the OK button.
.DE
.LI
Use the verb
.I choose
when you refer to picking an operation from a menu.  
.DS 1
Choose Save from the File menu.
.DE
.LI
Use the verb
.I select
to designate information that will be
the object of a subsequent operation or operations. 
.DS 1
Select the text that you want to copy.
.DE
.LI
Use the verb
.I "click on"
when you refer to controls on the screen.  
.DS 1
Click on the help icon.
.DE
.LE 
.H 2 "n, x (Variable Letters and Numbers)"
.P
Use the following guidelines for variable letters and numbers:
.iX "generic letters
.iX "letters" "generic"
.iX "numbers" "generic"
.iX "generic numbers"
.iX "\fIn\fR variable"
.iX "\fIx\fR variable"
.iX "variables" "\fIn, x\fR"
.BL 
.LI
Use a lowercase, italicized
.I x
to represent a variable letter. 
.DS 1
The \fBsearch\fR \fIx\fP function searches the options for \fIx\fP, 
where \fIx\fP is the letter of the option you are selecting.
.DE
.LI
Use a lowercase, italicized
.I n
to represent a variable number.
.DS 1
At the menu prompt, type in a number from 1 to \fIn\fP, 
where \fIn\fP is the highest number on the menu you are using.
.DE
.LE
.H 2 "Names in Text"
.iX "names, using proper"
.P
Vary your use of names in documentation.  Use non-Anglo-Saxon names (such as
Akio Asada, Juanita Sanchez, Pat McCoy, Yehuda Goldman, Kim Tae Woh, and Antonia Siracuso)
as well as Anglo-Saxon names, and female names as well as
male names.  Look through a telephone directory for ideas.
.H 2 "Numbers"
.P
Follow these guidelines for using and punctuating numbers.
.iX "decimals"
.iX "numbers" "decimals"
.iX "numbers" "in text"
.iX "numbers" "as figures"
.iX "figures" "numbers in"
.BL 
.LI
Do not use commas in binary, octal, hexadecimal, or 4-digital decimal
numbers.
.P 1
.I Use
.DS 1
0001111010101110
4000
.DE
.LI
'B "Express numbers as figures (numerals) in text in the following cases" :
.DL
.LI
If the number is 10 or more and does not begin a sentence.
.DS 1
This system supports 10 peripheral devices.
This program reports 15 system errors.
.DE
.LI
In a group of two or more numbers within a sentence when at least one of 
the numbers is 10 or more. 
.DS 1
3 nodes, 7 directories, and 15 files 
.DE
.LI
With units of measurement and time. 
.XX R "Units of measurement and time"
.DS 1
3 bytes
24 hours
4 characters
16 weeks
.DE
.LI
For memory descriptions.  
.DS 1
1 gigabyte = 1 GB
512-MB memory space
256KB
.DE
.LI
For a decimal, even if it is less than 10. 
.DS 1
5.5%
.DE
.LI
To identify objects by number. 
.DS 1
a value of 0
a value of 1
steps 3 and 4
bits 0 and 1
column 1
register 1
.DE
.LI
In a unit modifier. 
.DS 1
1/2-inch diameter
8-bit bytes
.DE
.LI
If the number precedes an abbreviation or symbol. 
.iX "abbreviations" "with numbers"
.iX "numbers" "with abbreviations"
.DS 1
8%
2 lb  
.DE
.LI
Rewrite sentences that include a spelled-out hyphenated number so that it
can be used as a numeral.  If the number does not include a hyphen, you may
spell it out.
.P 1
.I Use
.DS 1
The LAN operates with a maximum of 21 terminals.
Twenty people attended the meeting.
There were 20 people at the meeting.
.DE
.P 1
.I "Do not use"
.DS 1
Twenty-one terminals is the maximum allowed on the LAN.
.DE
.LE
.iX "numbers" "as words"
.LI
'B "Write numbers as words in the following cases" :
.DL
.LI
If the number is the first element of a sentence or heading or closely
follows another number that is the first element of a sentence or heading. For
example:
.DS 1
Twelve terminals can operate at the same time.

Ten or twenty characters disappeared from the file.
.DE
.LI
If the number precedes a unit modifier that contains a number expressed as
a figure and if the number is less than 100.  
.DS 1
Three longwords contain twelve 8-bit bytes.
.DE
.P 1
.I But
.DS 1
A block contains 512 8-bit bytes.
.DE
.LI
If the number is used in expressions of complement. 
.DS 1
The program calculates the two's complement of the number.
.DE
.LI
If the number is a
.I one
or
.I zero
bit setting.
.LI
If the number is
.I zero , 
unless the information is in a table,
you are giving a range of numbers, or you are giving a specific value.  For
example:
.DS 1
This will indicate a zero to the counter.
Single byte transfers always occur on data lines 0 to 7; word transfers use data lines 0 to 15.
Supply a 0 as the third argument.
.DE
.LE
.iX "numbers" "forming plurals of"
.iX "forming plurals" "of numbers"
.iX "plurals" "of numbers"
.LI
'B "Form the plural of a number written as a figure by adding a lowercase"
.I s .
.DS 1
4s
10s
1920s
10,000s
.DE
.iX "numbers" "punctuating
.iX "punctuating" "numbers"
.LI
'B "Use the following guidelines when punctuating numbers" :
.DL
.LI
Use a comma in a whole decimal number that contains five or more digits.
.DS 1
  9000
10,000
.DE
.LI
Hyphenate unit modifiers.
.DS 1
512-MB memory space
8-bit data transfers
\"6-character file name 
.DE
.LI
Hyphenate a fraction written as a word. 
.DS 1
three-fourths
.DE
.LI
Insert one space between a number and the abbreviation or unit symbol it 
modifies, as a general rule.  
.\"Hyphenate when used as a unit modifier.
.TS 
tab(@);
nw(1.0i) n.
.sp 4p
4 ft@250 Btu
3 mm@6 kHz
6758 A
\"@512-MB memory space
.sp 6p
.TE
.R
.P
Exceptions are as follows:
.TS 
tab(@);
lw(2.25i) l
lw(2.25i) l
l s
l s.
.sp 4p
binary thousand (64K)@degrees centigrade (20\(deC)
percent (9%)@degrees Fahrenheit (85\(deF)
degrees Kelvin (5K)
degrees, minutes, and seconds of an angle; and multiples of bytes.
.sp 6p
.TE
.R
.LE
.iX "numbers" "ranges of"
.iX "ranges of numbers"
.LI
.B "Use the following guidelines when handling numbers that span a range" :
.DL
.LI
Use the word
.I to 
rather than 
.I through
for inclusive
ranges of numbers written as words or figures and for numbers in a range that
are part of a modifier containing a hyphen.
.DS 1
Enter one to three bytes.
Enter a 1-byte to 6-byte string.
.DE
.LI
In tables and figures, use a dash to indicate a range of numbers.  
.iX "numbers" "in tables"
.iX "numbers" "in figures"
.iX "tables" "numbers in"
.iX "figures" "numbers in"
.DS 1
12-20
.DE
.LI
If a series has more than two items, place the abbreviation
or symbol for a unit of measurement at the end of the series.  
.DS 1
1200, 1400, or 1600MHz
.DE
.P 
If a series has only two items, repeat the abbreviation or symbol 
for a unit of measurement. 
.XX R "Abbreviations" "in a series"
.XX R "Symbols" "in a series"
.DS 1
10% to 50%
.DE
.LI
Use full years in ranges, not partial years. 
.P 1
.I Use
.DS 1
1980 to 1989
.DE
.P 1
.I "Do not use"
.DS 1
1980-89 (or 1980 to 89)
.DE
.LE
.LI
'B "Follow these guidelines when using decimals" :
.DL
.LI
Write decimal numbers of less than 1 with a zero preceding the decimal
point.
.DS 1
0.25
.DE
.LI
Emphasize exact measurement by following a whole number with a decimal
point and a zero.  Otherwise, omit the decimal point and the zero. For
example:
.DS 1
3.0 feet long
approximately 3 feet long
.DE
.LI
In lists, maintain consistency in decimal precision.  Add one or more
trailing zeros, if necessary, to achieve consistency.
.LI
Align columns of numbers containing decimal points
on the decimal point.  For example: 
\"right-justify all other columns of numbers. For example:
.DS F
.TS 
center,box,tab(@);
lb |lb |lb
l | n | c.
Air Flow Clearance@Centimeters@Inches
_
Front@15.2@6.0
Rear@30.5
Sides@15.2@6.0
.TE
.DE
.LI 
Right-justify columns of numbers.  For example:
.DS F
.TS  
center,box,tab(@);
lb |lb
n |n.
Units Sold@Unit Price
_
500@$0.50
27@$4.75
1@$0.33
.TE
.DE
.\".TS H 
.\"tab(@);
.\"lfB lfB
.\"nw(3.0i) n.
.\"_
\".sp 4p
.\"Units Sold@Unit Price
.\".sp 4p
.\"_
.\".sp 4p
.\".TH
.\"500@$0.50
.\"27@4.75
.\"1@0.33
.\".sp 6p
.\"_
.\".TE
.\".R
.LI
Do not use a decimal point as a radix indicator in text.
.LE
.LI
'B "Follow these guidelines when writing fractions" :
.DL
.LI
Write a fraction as a figure when it is attached to other figures.
.iX "fractions" "as figures"
.DS 1
1 1/2
.DE
.LI
Write a fraction as a figure when it is in a series of numbers written
as figures. 
.DS 1
1, 7, 3/4, 8
.DE
.LI
Write a fraction as a figure when it is part of a unit of measure used
as a modifier. 
.DS 1
1/2-inch margins
.DE
.LI
Hyphenate a fraction written as words. 
.iX "hyphenating" "fractions"
.iX "fractions" "hyphenating"
.DS 1
three-fourths
one and one-half
one-third
.DE
.LE
.iX "radix indicators"
.iX "base indicators"
.ix "indicators, base and radix"
.Li
'B "Follow these guidelines when using radix indicators" :
.DL
.LI
Indicate the radix of a number expressed as a figure by subscript (2, 8,
10, or 16) if you have the production capability to do so. For example: 
.DS 1
.EQ
23 sub 10
.EN
.DE
.LI
If you do not have the production capability to use subscripts, write the 
radix as a numeral enclosed in parentheses.
.DS 1
23(10)
.DE
.LI
If the radix is in parentheses, separate the number and its radix 
with a space.
.LI
Do not use a decimal point as a radix indicator in text.
.EQ
delim ##
.EN
.LI
If the radix of a number is part of a compound modifier, hyphenate it.
For example: 30(decimal)-byte buffer or #30 sub 10 #-byte buffer.
.EQ
delim off
.EN
.\".LI
.\"'B "Follow these guidelines for specifying tolerances" :
.\".DL
.\".LI
.\"There should 
.\".I not 
.\"be any space between the + - signs and the value.
.\".DS 1
.\"+10%, -15%
.\"+10%, -10%
.\"\(+-10%
.\".DE
.\".LI
.\"The tolerances should be enclosed in parentheses with a space preceding the
.\"open parenthesis.
.\".DS 1
.\"115 V ac (+15%, -21%)
.\"240 V ac (+10%, -25%)
.\"50 to 60 Hz (\(+-3 Hz)
.\".DE
.LE
.LE
.P
See also
.B measurements .
.\".H 2 "Order Numbers"
.\" 
.\" ***PIP Rev. B***
.\" 
.\"Most documents provide information on related documentation.  When order
.\"numbers are provided as part of this information, the order numbers may
.\"apply to one country or market only.  This can cause problems when
.\"readers want to order translated versions of the documentation for a
.\"product. Readers tend to assume that order numbers supplied in a
.\"document apply worldwide. 
.\".BL 
.\".LI
.\"Avoid including order information in documentation whenever possible.
.\".LI
.\"Do not include document order numbers in related documentation lists.
.\"Instead, provide them separately (so that they can be easily changed for
.\"other countries).
.\".LI
.\"Place material containing this information in an
.\"appendix.  Prepare for this in your documentation plan.
.\".LI
.\"Advise the user of any documents that are available in multiple languages.
