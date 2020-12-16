...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c2.7com_ex.sml,v $
.\" Revision 1.1.2.6  1994/06/24  15:15:03  fred
.\" 	free copyright
.\" 	[1994/06/23  20:21:08  fred]
.\"
.\" Revision 1.1.2.5  1994/06/23  18:38:56  fred
.\" 	free copyright
.\" 	[1994/06/22  19:08:24  fred]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:06:34  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:02:06  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:35:39  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:32:37  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:04:15  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:57:02  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
...\" 
.TH spell "1" "" "" ""
.iX "spell command"
.iX "spellin command"
.iX "spellout command"
.iX "finding" "spelling errors"
.iX "errors" "spelling"
.SH NAME
.PP 
\*Lspell\*O, \*Lspellin\*O, \*Lspellout\*O - Finds spelling errors
.SH SYNOPSIS 
.PP 
.sS
.in +.5i
.ti -.5i
\*Lspell\*O
\*O[\*L-b\*O]
\*O[\*L-i\*O
|
\*L-l\*O]
\*O[\*L-v\*O
|
\*L-x\*O]
\*O[\*L-d\*O
\*Vhash_list\*O]
\*O[\*L-s\*O
\*Vhash_stop\*O]
\*O[\*L-h\*O
\*Vhistory_list\*O]
.nL
\*O[\*L\(pl\*Vword_list\*O]
\*O[\*Vfile\*O
\&.\&.\&.]
.in -.5i
.PP 
\*Lspellin\*O
\*O[\*Vlist\*O]
\*O[\*Vnumber\*O]
.PP 
\*Lspellout\*O
\*O[\*L-d\*O]
\*Vlist\*O
.sE
.PP
The \*Lspell\*O command reads words in \*Vfile\*O and compares
them to those in a spelling list.  Default files contain
English words only, but you can supply
your own list of words in other languages.
.SH FLAGS
.PP 
The following flags are for the \*Lspell\*O command only.
.VL 4m
.LI "\*L-b\*O"
Checks for correct British spelling.
.LI "\*L-d\*O \*Vhash_list\*O" 
Specifies \*Vhash_list\*O as the alternate spelling list.
The default is \*L/usr/share/dict/hlist[ab]\*O.
.LI "\*L-h\*O \*Vhistory_list\*O" 
Specifies \*Vhistory_list\*O as the alternate history list
that is used to accumulate all output.
The default is \*L/usr/share/dict/spellhist\*O.
.LI "\*L-i\*O" 
Suppresses processing of included files.
.LI "\*L-l\*O" 
Follows the chain of all included files (\*L.so\*O
and \*L\&.nx\*O formatting commands).  Without this flag,
\*Lspell\*O follows chains of all included files. 
.LI "\*L-s\*O \*Vhash_stop\*O" 
Specifies \*Vhash_stop\*O as the alternate stop list
that is used to filter out misspellings (for example,
\*Lthier=thy-y\(plier\*O) that would otherwise pass.
The default is \*L/usr/share/dict/hstop\*O.
.LI "\*L-v\*O" 
Displays all words not literally in the spelling
list and indicates plausible derivations from the words.
.LI "\*L-x\*O" 
Displays every plausible word stem with an \*L=\*O (equal sign).
.LI "\*L\(pl\*Vword_list\*O" 
Checks \*Vword_list\*O for additional word spellings.
\*Vword_list\*O is a file containing a sorted list of words, one per line.
With this flag, you can specify, in addition to the \*Lspell\*O command's own
spelling list, a set of correctly spelled words.
.LE 
.SH DESCRIPTION
.PP 
Words that cannot be matched in the
spelling list or derived from words in the spelling list (by applying
certain inflections, prefixes, or suffixes) are written to standard
output.  If you do not specify a file to read, \*Lspell\*O reads
standard input.
.PP 
The \*Lspell\*O command ignores the same \*Lnroff\*O, \*Ltroff\*O,
\*Ltbl\*O, and \*Leqn\*O constructs as the \*Lderoff\*O command (see
\*LRELATED INFORMATION\*O).
.PP 
Certain auxiliary files can be specified by filename arguments
following the \*L-d\*O, \*L-s\*O, and \*L-h\*O flags.  Copies of all
output can be accumulated in the history file.
.SS Auxiliary Commands and Routines
.PP 
The \*Lspellin\*O command creates a spelling list for use by the
\*Lspell\*O command.  The argument for the \*Lspellin\*O command
can be a \*Vlist\*O file or a number.
The \*Lspellin\*O command combines the words from the standard input
and the preexisting \*Vlist\*O file and places a new list on the
standard output.  If no \*Vlist\*O file is specified, a new
list is created.  If \*Vnumber\*O is specified, the \*Lspellin\*O
command reads the specified \*Vnumber\*O hash code from standard
input and writes a compressed spelling list.
.PP 
The \*Lspellout\*O command looks up each word
from the standard input and prints on the standard output those that
are missing from the hashed \*Vlist\*O file.  The \*L-d\*O flag
reverses this, printing those that are present in the hashed
\*Vlist\*O file.  (Note that the \*L-d\*O flag of \*Lspellout\*O is not the
same as the \*L-d\*O flag of \*Lspell\*O.  See \*LFLAGS\*O.)
.PP 
Three routines help maintain and check the hash lists used by \*Lspell\*O:
.VL 4m
.LI "\*L/usr/lbin/spell/hashmake\*O"
Reads a list of words from standard input and writes the
corresponding 9-digit hash code to standard output.
.LI "\*L/usr/lbin/spell/hashcheck\*O \*Vspelling_list\*O" 
Reads a compressed \*Vspelling_list\*O and re-creates the
9-digit hash codes for all the words in it; it writes these codes to
standard output.
.LI "\*L/usr/bin/spellin\*O \*Vnumber\*O" 
Reads \*Vnumber\*O hash codes from standard input and writes a
compressed spelling list to standard output.
.LE 
.SH EXAMPLES
.PP 
.AL 3m 
.LI
To check the spelling of American English words
in the file \*Lchap1\*O, enter:
.iS
spell  chap1  >mistakes
\*O\c
.iE
.PP
This creates a file named \*Lmistakes\*O containing all the
words found in \*Lchap1\*O that are not in the system spelling
dictionary.  Some of these may be correctly spelled words that
\*Lspell\*O does not know about.  It is a good idea to save the
output of \*Lspell\*O in a file because the word list may be long.
.LI
To check British English spelling, enter:
.iS
spell  -b  chap1  >mistakes
\*O\c
.iE
.PP
This checks \*Lchap1\*O against the British dictionary and
writes the questionable words in \*Lmistakes\*O.
.LI
To see how \*Lspell\*O derives words, enter:
.iS
spell  -v  chap1  >deriv
\*O\c
.iE
.PP
This lists the words that are not found literally in the dictionary,
but are derived forms of dictionary words.  The prefixes and suffixes
used to form the derivative are indicated for each word.
Words that do not appear in the dictionary at all are also listed.
.LI
To check your spelling against an additional word list, enter:
.iS
spell  \(plnew_words  chap1
\*O\c
.iE
.PP
This checks the spelling of words in \*Lchap1\*O against the
system dictionary and against \*Vnew_words\*O.  The
file \*Vnew_words\*O lists words in alphabetical order, one per line.
You can create this file with a text editor, such as \*Led\*O,
and collate it with the \*Lsort\*O command.
.LI
To add a word to your spelling list, enter:
.iS
echo hooky \(br spellout /usr/lbin/spell/hlista
echo hooky \(br spellin /usr/lbin/spell/hlista > myhlist
spell -d myhlist huckfinn
\*O\c
.iE
.PP
This example verifies that \*Lhooky\*O is not on the default
spelling list, adds it to your private list, and then uses it with
the \*Lspell\*O command.
.PP
An alternative way is to place \*Lhooky\*O into the sorted file
\*Vnew_words\*O, as in Example 4.
.LE 
.SH FILES
.PP 
.VL 11m
.LI "\*L/usr/share/dict/hlist[ab]\*O"
Hashed spelling lists, American and British English.
.LI "\*L/usr/share/dict/hstop\*O" 
Hashed stop list.
.LI "\*L/usr/lbin/spell/spellhist\*O" 
History file.
.LI "\*L/usr/lbin/spell/compress\*O" 
Executable shell program to compress the history file.
.LI "\*L/usr/lbin/spell/spellprog\*O" 
Main program called by \*Lspell\*O.
.LE 
.SH NOTES
.PP 
The coverage of the spelling list is uneven.  For best results, create your
own dictionary of special words used in your files.
.SH RELATED INFORMATION
.PP 
Commands:  \*Lsed\*O(1), \*Lsort\*O(1), \*Ltee\*O(1).
.PP 
The \*Lnroff\*O, \*Ltroff\*O, \*Ltbl\*O, 
\*Leqn\*O, \*Lneqn\*O, \*Lcheckeq\*O, and \*Lcheckmm\*O
commands may be available on your system, but are not provided with OSF/1.
.SS Compatibility Notes
.PP 
Ported 4.3BSD dictionary must be rebuilt from the original word
list using the \*Lspellin\*O command.
