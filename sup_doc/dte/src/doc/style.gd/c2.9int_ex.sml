...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c2.9int_ex.sml,v $
.\" Revision 1.1.2.6  1994/06/24  15:15:08  fred
.\" 	free copyright
.\" 	[1994/06/23  20:21:17  fred]
.\"
.\" Revision 1.1.2.5  1994/06/23  18:39:02  fred
.\" 	free copyright
.\" 	[1994/06/22  19:08:48  fred]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:06:38  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:02:12  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:35:42  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:32:43  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:04:32  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:57:11  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
.TH rexec 3
.iX "rexec function"
.SH NAME
\*Lrexec\*O - Allows command execution on a remote host
.iX "remote host" "executing commands on"
.iX "commands" "executing on remote host"
.iX "executing commands on remote host"
.SH LIBRARY
Standard C Library \*L(libc.a)
.SH SYNOPSIS 
.sS
\*Lint rexec\*O (\*L
.nL
	\*Lchar **\*Vhost\*L,
.nL
	\*Lint \*Vport\*L,
.nL
	char *\*Vuser\*L,
.nL
	char *\*Vpasswd\*L,
.nL
	char *\*Vcommand\*L,
.nL
	\*Lint *\*Verr_file_desc \*L);
.sE 
.SH PARAMETERS
...\"from TP "  
.VL 
.LI "\*Vhost"
\*OContains
the name of a remote host that is listed in the \*L/etc/hosts\*O
file or \*L/etc/resolv.conf
\*Ofile.  If the name of the host is not found in either file,
the \*Lrexec(\|)\*O fails.
...\"from TP "  
.LI "\*Vport" 
\*OSpecifies
the \*Owell-known DARPA Internet
port to use for the connection.  A pointer to the structure that contains
the necessary port can be obtained by issuing the following library
call:
.rS
\*Lgetservbyname(\|)\*O(\*(lqexec\*(rq,\*(lqtcp\*(rq)
.rE
...\"from TP "  
.LI "\*Vuser\*O" 
\*OPoints to a user ID valid at the host.
...\"from TP "  
.LI "\*Vpasswd" 
\*OPoints to the password of the specified user ID on the host.
...\"from TP "  
.LI "\*Vcommand" 
\*OPoints to
the name of the command to be executed at the remote host.
...\"from TP "  
.LI "\*Verr_file_desc" 
\*OSpecifies the file to which standard error from the remote command
is sent.
.P 
If the \*Verr_file_desc\*O parameter is 0 (zero),
the standard error of the remote command is the same
as standard output.  No provision is made for sending arbitrary
signals to the remote process.  In this case, however, it may be possible
to send \*Oout-of-band data to the
remote command.
.P 
If the \*Verr_file_desc\*O parameter is nonzero, an auxiliary channel to a control process is set
up, and a descriptor for it is placed in the \*Verr_file_desc \*Oparameter.
The control process provides diagnostic output from the remote
command on this channel and also accepts bytes as signal numbers to
be forwarded to the process group of the command.  This diagnostic
information does not include remote authorization failure, since this
connection is set up after authorization has been verified.
.LE 
.SH DESCRIPTION
.PP 
The \*Lrexec(\|)\*O (remote execution) function allows the calling
process to execute commands on a remote host.
.PP 
If the \*Lrexec(\|)\*O connection succeeds, a socket in theInternet domain of type
SOCK_STREAM is returned
to the calling process and is given to the remote command as standard
input and standard output.
.PP 
The
\*Vuser\*O
and
\*Vpasswd\*O
parameters specify a valid user ID and the associated
password for that user on the remote host.
If the \*Vuser\*O and
\*Vpasswd\*O
parameters are not supplied, the \*Lrexec(\|)\*O function takes the
following actions until finding a user ID and password to send to
the remote host:
...\"from TP 4"  
.AL 
.LI
\*OSearches the current environment for the user ID and password
on the remote host.
...\"from TP "  
.LI
\*OSearches the user's home directory for a file called \*L$HOME/.netrc\*O
that contains
a user ID and password.
...\"from TP "  
.LI
\*OPrompts the user for a user ID and password.
.LE
.PP
Note that action 3 does not apply when using the threadsafe version of
\*Lrexec(\|)\*O function.
.SH RETURN VALUES
.PP 
Upon successful completion, the system returns a socket to the
remote command.
\*OOtherwise,
-1 is returned, indicating that the specified hostname does not
exist.
.SH FILES
...\"from TP "  
.VL 
.LI "\*L/etc/hosts"
\*OContains
hostnames and their addresses for hosts in a network.  This file
is used to resolve a hostname into an Internet address.
...\"from TP "  
.LI "\*L/etc/resolv.conf" 
\*OContains the name server and domain
name.
...\"from TP "  
.LI "\*L$HOME/.netrc" 
\*OContains
automatic login information.
.LE 
.SH RELATED INFORMATION
.PP 
Functions:
\*Lgetservbyname\*O(3),
\*Lrcmd\*O(3),
\*Lrresvport\*O(3),
\*Lruserok\*O(3)
.PP 
Commands:
\*Lrexecd\*O(8)
.wH .RE
.iX "rexec function"
