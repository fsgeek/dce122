//
// @OSF_COPYRIGHT@
// COPYRIGHT NOTICE
// Copyright (c) 1990, 1991, 1992, 1993, 1994, 1996 Open Software Foundation, Inc
// ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
// the full copyright text.
// All Rights Reserved
//
//
// HISTORY
// $Log: t61_mapping.h,v $
// Revision 1.1.2.1  1996/11/13  20:36:00  arvind
// 	OSF DCE 1.2.2 Drop 5
// 	[1996/11/13  19:56:04  arvind]
//
// Revision /main/DCE_1.2.2/1  1996/11/04  22:27 UTC  arvind
// 	     Cert-API drop 2 from DEC
// 	     [1996/11/03  23:23 UTC  arvind  /main/DCE_1.2.2/arvind_capi2/1]
// 
// $EndLog$
//


char t61_to_local_array[256] = {
// This array maps t61 characters to local 'C' characrters.
// Unsupported T61 characters are mapped to the C '\0' character.
'\0',	// 0/0
'\0',	// 0/1
'\0',	// 0/2
'\0',	// 0/3
'\0',	// 0/4
'\0',	// 0/5
'\0',	// 0/6
'\0',	// 0/7
'\b',	// 0/8
'\0',	// 0/9
'\n',	// 0/10
'\0',	// 0/11
'\f',	// 0/12
'\r',	// 0/13
'\0',	// 0/14
'\0',	// 0/15

'\0',	// 1/0
'\0',	// 1/1
'\0',	// 1/2
'\0',	// 1/3
'\0',	// 1/4
'\0',	// 1/5
'\0',	// 1/6
'\0',	// 1/7
'\0',	// 1/8
'\0',	// 1/9
'\0',	// 1/10
'\0',	// 1/11
'\0',	// 1/12
'\0',	// 1/13
'\0',	// 1/14
'\0',	// 1/15

' ',	// 2/0    Space
'!',	// 2/1    !
'\"',	// 2/2    "
'\0',	// 2/3    
'\0',	// 2/4
'%',	// 2/5
'&',	// 2/6
'\'',	// 2/7
'(',	// 2/8
')',	// 2/9
'*',	// 2/10
'+',	// 2/11
',',	// 2/12
'-',	// 2/13
'.',	// 2/14
'/',	// 2/15

'0',	// 3/0
'1',	// 3/1
'2',	// 3/2
'3',	// 3/3
'4',	// 3/4
'5',	// 3/5
'6',	// 3/6
'7',	// 3/7
'8',	// 3/8
'9',	// 3/9
':',	// 3/10
';',	// 3/11
'<',	// 3/12
'=',	// 3/13
'>',	// 3/14
'?',	// 3/15

'@',	// 4/0
'A',	// 4/1
'B',	// 4/2
'C',	// 4/3
'D',	// 4/4
'E',	// 4/5
'F',	// 4/6
'G',	// 4/7
'H',	// 4/8
'I',	// 4/9
'J',	// 4/10
'K',	// 4/11
'L',	// 4/12
'M',	// 4/13
'N',	// 4/14
'O',	// 4/15

'P',	// 5/0
'Q',	// 5/1
'R',	// 5/2
'S',	// 5/3
'T',	// 5/4
'U',	// 5/5
'V',	// 5/6
'W',	// 5/7
'X',	// 5/8
'Y',	// 5/9
'Z',	// 5/10
'[',	// 5/11
' ',	// 5/12
']',	// 5/13
' ',	// 5/14
'_',	// 5/15

' ',	// 6/0
'a',	// 6/1
'b',	// 6/2
'c',	// 6/3
'd',	// 6/4
'e',	// 6/5
'f',	// 6/6
'g',	// 6/7
'h',	// 6/8
'i',	// 6/9
'j',	// 6/10
'k',	// 6/11
'l',	// 6/12
'm',	// 6/13
'n',	// 6/14
'o',	// 6/15

'p',	// 7/0
'q',	// 7/1
'r',	// 7/2
's',	// 7/3
't',	// 7/4
'u',	// 7/5
'v',	// 7/6
'w',	// 7/7
'x',	// 7/8
'y',	// 7/9
'z',	// 7/10
' ',	// 7/11
'|',	// 7/12
'\0',	// 7/13
'\0',	// 7/14
'\0',	// 7/15

'\0',	// 8/0
'\0',	// 8/1
'\0',	// 8/2
'\0',	// 8/3
'\0',	// 8/4
'\0',	// 8/5
'\0',	// 8/6
'\0',	// 8/7
'\0',	// 8/8
'\0',	// 8/9
'\0',	// 8/10
'\0',	// 8/11
'\0',	// 8/12
'\0',	// 8/13
'\0',	// 8/14
'\0',	// 8/15

'\0',	// 9/0
'\0',	// 9/1
'\0',	// 9/2
'\0',	// 9/3
'\0',	// 9/4
'\0',	// 9/5
'\0',	// 9/6
'\0',	// 9/7
'\0',	// 9/8
'\0',	// 9/9
'\0',	// 9/10
'\0',	// 9/11
'\0',	// 9/12
'\0',	// 9/13
'\0',	// 9/14
'\0',	// 9/15

'\0',	// 10/0
'�',	// 10/1
'�',	// 10/2
'�',	// 10/3
'$',	// 10/4
'�',	// 10/5
'#',	// 10/6
'�',	// 10/7
'�',	// 10/8
'\0',	// 10/9
'\0',	// 10/10
'�',	// 10/11
'\0',	// 10/12
'\0',	// 10/13
'\0',	// 10/14
'\0',	// 10/15

'�',	// 11/0
'�',	// 11/1
'�',	// 11/2
'�',	// 11/3
'\0',	// 11/4
'�',	// 11/5
'�',	// 11/6
'�',	// 11/7
'\0',	// 11/8
'\0',	// 11/9
'\0',	// 11/10
'�',	// 11/11
'�',	// 11/12
'�',	// 11/13
'\0',	// 11/14
'�',	// 11/15

'\0',	// 12/0
'\0',	// 12/1
'\0',	// 12/2
'\0',	// 12/3
'\0',	// 12/4
'\0',	// 12/5
'\0',	// 12/6
'\0',	// 12/7
'\0',	// 12/8
'\0',	// 12/9
'\0',	// 12/10
'\0',	// 12/11
'\0',	// 12/12
'\0',	// 12/13
'\0',	// 12/14
'\0',	// 12/15

'\0',	// 13/0
'\0',	// 13/1
'\0',	// 13/2
'\0',	// 13/3
'\0',	// 13/4
'\0',	// 13/5
'\0',	// 13/6
'\0',	// 13/7
'\0',	// 13/8
'\0',	// 13/9
'\0',	// 13/10
'\0',	// 13/11
'\0',	// 13/12
'\0',	// 13/13
'\0',	// 13/14
'\0',	// 13/15



'\0',	// 14/0
'�',	// 14/1
'\0',	// 14/2
'\0',	// 14/3
'\0',	// 14/4
'\0',	// 14/5
'\0',	// 14/6
'\0',	// 14/7
'\0',	// 14/8
'\0',	// 14/9
'�',	// 14/10
'\0',	// 14/11
'\0',	// 14/12
'\0',	// 14/13
'\0',	// 14/14
'\0',	// 14/15

'\0',	// 15/0
'\0',	// 15/1
'\0',	// 15/2
'\0',	// 15/3
'\0',	// 15/4
'\0',	// 15/5
'\0',	// 15/6
'\0',	// 15/7
'\0',	// 15/8
'\0',	// 15/9
'\0',	// 15/10
'\0',	// 15/11
'\0',	// 15/12
'\0',	// 15/13
'\0',	// 15/14
'\0'	// 15/15
};
