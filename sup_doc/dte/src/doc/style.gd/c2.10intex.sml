...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c2.10intex.sml,v $
.\" Revision 1.1.2.6  1994/06/24  15:14:48  fred
.\" 	free copyright
.\" 	[1994/06/23  20:20:40  fred]
.\"
.\" Revision 1.1.2.5  1994/06/23  18:38:39  fred
.\" 	free copyright
.\" 	[1994/06/22  19:07:09  fred]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:06:21  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:01:45  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:35:27  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:32:18  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:03:39  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:56:33  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
...\"build rmifdef
...\"
.TH ulimit 3
.iX "ulimit function"
.SH NAME
\*Lulimit\*O - Sets and gets user limits
.iX "user limits" "setting and getting"
.iX "setting user limits"
.iX "getting user limits"
.iX "limits" "for users"
.SH LIBRARY
Standard C Library (\*Llibc.a\*O)
.SH SYNOPSIS 
.sS
\*L#include <ulimit.h>
.sp .4v
\*Llong ulimit (
.nL
	\*Lint \*Vcommand\*O,\*L
.nL
	off_t \*Vnew_limit\*L,
.nL
	\|.\|.\|. \*L);
.sE 
.SH PARAMETERS
...\"from TP "  
.VL 
.LI "\*Vcommand"
\*OSpecifies the form of control. The \*Vcommand\*O
parameter values follow:
.wH .RS  Can not be used in nested lists
...\"from TP .5i"  
.VL
.LI "\*LUL_GETFSIZE (\|)" 
\*OReturns the process file size limit. The
limit is in units of UBSIZE blocks (see the \*Lsys/param.h \*Ofile)
and is inherited by child processes.  Files of any size can be read.
...\"from TP "  
.LI "\*LUL_SETFSIZE (\|)" 
\*OSets the process file size limit for output operations to the
value of the\*V new_limit\*O parameter, and returns the new file size
limit.  Any process can decrease
this limit, but only a process with the SEC_LIMIT system
privilege can increase the limit.
...\"from TP "  
.LI "\*LGET_GETBREAK (\|)" 
\*OReturns the maximum possible break value
(described in the \*Lbrk(\|)\*O and \*Lsbrk(\|)\*O functions).
.wH .RE
...\"from TP "  
.LE
.LI "\*Vnew_limit" 
\*OSpecifies the new limit.  The value of
the \*Vnew_limit\*O parameter depends on the \*Vcommand\*O parameter
value that is used.
.LE 
.SH DESCRIPTION
.PP 
The \*Lulimit(\|)\*O function controls process limits.
.PP 
\*OWith remote files, the \*Lulimit(\|)\*O function values of the
client node or local node are used.
.SH NOTES
The
\*Lulimit(\|)\*O
function is implemented in terms of
\*Lsetrlimit(\|)\*O;
therefore, the two interfaces should not be used in the same program.
The result of doing so is undefined.
.VL 1.5i
.LI "\*LAES Support Level:\*O"
Trial use
.LE
.SH EXAMPLE
\*OTo increase the size of the stack segment by 2048 bytes, and set
the \*Lrc\*O variable to the new lowest valid stack address, enter:
.oS
rc = ulimit(1006, ulimit(1005, 0) - 2048);
.oE
.SH RETURN VALUES
.PP 
Upon successful completion, a nonnegative value is returned.
If the \*Lulimit(\|)\*O function fails, a value of -1 is returned
and \*Lerrno\*O is set to indicate the error.
.SH ERRORS
.PP 
If the \*Lulimit(\|)\*O function fails, the limit remains unchanged
and
\*Lerrno\*O
may be set to one of the following values:
...\"from TP 1i"  
.VL 1i
.LI "[EPERM]"
A process without appropriate system
privilege attempts to increase the file size limit.
...\"from TP 1i"  
.LI "[EINVAL]" 
The \*Vcommand\*O parameter is invalid.
.LE 
.SH RELATED INFORMATION
.PP 
Functions:
\*Lbrk\*O(2),
\*Lgetrlimit\*O(2),
\*Lpathconf\*O(3),
\*Lwrite\*O(2)
.iX "ulimit function"
