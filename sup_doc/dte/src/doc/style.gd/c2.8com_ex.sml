...\" Copyright 1991,1992,1993 Open Software Foundation, Inc.,
...\" Cambridge, Massachusetts
...\" All rights reserved.
...\"
.\" @OSF_FREE_COPYRIGHT@
.\" 
.\" HISTORY
.\" $Log: c2.8com_ex.sml,v $
.\" Revision 1.1.2.6  1994/06/24  15:15:06  fred
.\" 	free copyright
.\" 	[1994/06/23  20:21:11  fred]
.\"
.\" Revision 1.1.2.5  1994/06/23  18:38:59  fred
.\" 	free copyright
.\" 	[1994/06/22  19:08:37  fred]
.\" 
.\" Revision 1.1.2.4  1993/06/11  19:06:36  josh
.\" 	Completely revised version of Style Guide by Noreen Casey (not josh)
.\" 	[1993/06/11  19:02:09  josh]
.\" 
.\" Revision 1.1.2.3  1993/04/10  01:35:40  bowe
.\" 	Add OSF copyright.
.\" 	[1993/04/10  01:32:40  bowe]
.\" 
.\" Revision 1.1.2.2  1992/05/28  20:04:26  bowe
.\" 	Initial revision.
.\" 	[1992/05/28  19:57:07  bowe]
.\" 
.\" $EndLog$
.\" _____________________________________________________
.\\"
...\"build rmifdef
...\"
.TH mail "1" "" "" ""
.iX "mail command"
.iX "binmail command"
.iX "sending" "messages"
.iX "messages" "sending"
.iX "mail" "sending"
.SH NAME
.PP 
\*Lmail\*O, \*Lbinmail\*O - Sends and displays messages from system users
.SH SYNOPSIS 
.PP 
.sS
\*Lmail\*O
\*O[\*L-e\*O]
|
\*O[\*L-pqrt\*O]
\*O[\*L-d \*Vdirectory_path\*O]
|
\*O[\*L-f\*O
\*Vfile\*O]
.PP
\*Lmail\*O
\*Vuser\*O
\&...
\*O[\*L< \*Vfile\*O]
.PP 
\*Lbinmail\*O
\*O[\*L-e\*O]
|
\*O[\*L-pqrt\*O]
\*O[\*L-d \*Vdirectory_path\*O]
|
\*O[\*L-f\*O
\*Vfile\*O]
.PP 
\*Lbinmail\*O
\*Vuser\*O
\&...
\*O[\*L< \*Vfile\*O]
.sE 
.PP
The \*Lmail\*O command writes to standard output all stored mail
addressed to the your login name, one message at a time, or sends
a mail message to another user or users.
.SH FLAGS
.PP 
.VL 4m
.LI "\*L-d \*Vdirectory_path\*O"
Saves mail in the specified directory instead of the directory
\*L/usr/spool/mail\*O.  (This flag cannot be used with \*L-f\*O).
.LI "\*L-e\*O"
Does not display any messages.
This flag causes \*Lmail\*O to return an exit value of 0 if the
user has mail and an exit value of 1 if the user has no mail.
.LI "\*L-f \*Vfile\*O" 
Saves mail to and reads mail from \*Vfile\*O
instead of in the default mail file, \*L$HOME/mbox\*O.
(This flag cannot be used with \*L-d\*O.)
.LI "\*L-p\*O" 
Displays mail without prompting for a disposition code.
This flag does not delete, copy, or forward any messages.
.LI "\*L-q\*O" 
Causes \*Lmail\*O to exit when you press
the Interrupt key sequence.
.PP
Normally, pressing the Interrupt key sequence stops only the
message being displayed.
(In this case, the next message sometimes does not display until you
enter the \*Lp\*O subcommand.)
.LI "\*L-r\*O" 
Displays mail in first-in, first-out order.
.LI "\*L-t\*O" 
Prefixes each message with the names of all recipients of the mail.
(Normally, only the individual recipient's name appears as addressee.)
.LE 
.SH DESCRIPTION
.PP 
Following each message, \*Lmail\*O prompts you with a
\*L?\*O question mark.
Press \*L<Return>\*O to display the next mail
message, or enter one of the
subcommands that control the disposition of the message.
.PP 
When sending mail, you specify users, and then
\*Lmail\*O reads a message from standard input until you press
the End-of-File key sequence or
enter a line containing only a \&. (dot).
It prefixes this message with the sender's name and the date and time of
the message (its \*Vpostmark\*O) and adds this message to the file
\*L/var/spool/mail/\*Vuser\*O for each \*Vuser\*O specified
on the command line.
.PP 
Usually, \*Vuser\*O is a name recognized by the \*Llogin\*O
command.  If the system does not recognize one or more of the specified
users or if \*Lmail\*O is interrupted during input,
\*Lmail\*O saves messages in the file \*L$HOME/dead.letter\*O
to allow for editing and resending.
.PP 
The action of \*Lmail\*O can be modified in two ways
by manipulating \*L/var/spool/mail/\*Vuser\*O:
.ML  
.LI 
The default permission assignment for other users is read-only.
If you change this permission assignment to read/write or to
All Permissions Denied, the system preserves the file, even when it is
empty, in order to maintain the desired permissions; you will not be able to
remove the file.
.LI
You can edit the file to contain the following as its first line:
.iS
Forward to \*Vperson\*O
.iE
.PP
This causes all messages sent to \*Vuser\*O to be sent to
.iX "forwarding" "mail"
\*Vperson\*O instead.
The \*LForward to\*O feature is especially useful for sending all
of a person's mail to a particular machine in a network environment.
.LE 
.PP 
To specify a recipient on a remote system, prefix the system name and
an \*L!\*O (exclamation mark) to
\*Vuser\*O.  See the \*Luucp\*O command for a
detailed discussion of how to address remote systems.  Also see \*Lmailx\*O
and \*Lsendmail\*O for other network connections.
#ifdef SEC_BASE
#ifdef SEC_MAC
.PP 
The system tries to create the \*Ldead.letter\*O file in the user's
home directory if \*Lmail\*O is interrupted and the home directory
has a sensitivity label below the user's clearance.  Unless
you are running in a process at a sensitivity label equal to that of
your home directory, \*Lmail\*O will not be able to save the messages.
.PP 
Because the user's mailbox is stored at the user's clearance, you must
edit that file from a process created at your clearance to change
forwarding information, and so on.
.SS Security Restrictions
.PP 
If the system is configured with Mandatory Access Control, users can
only read mail at their own clearance.  In addition, saved mail messages
and interrupted messages must be saved in directories with sensitivity
levels equal to the current process level.
#endif /* SEC_MAC */
#endif /* SEC_BASE */
.SH SUBCOMMANDS
.PP 
The following subcommands control message disposition.
#ifdef SEC_BASE
#ifdef SEC_MAC
To print any of your mail, you must be running a process with a
sensitivity level equal to your clearance.
#endif /* SEC_MAC */
#endif /* SEC_BASE */
.VL 4m
.LI "\*L\(pl\*O"
Displays the next mail message (the same as pressing \*L<Return>\*O).
.LI "\*L-\*O" 
Displays the previous message.
.LI "\*Ld\*O" 
Deletes the current message and displays the next message.
.LI "\*Lp\*O" 
Displays the current message again.
.LI "\*Ls\*O [\*Vfile\*O]" 
Saves the message in \*Vfile\*O
instead of in the default mail file \*L$HOME/mbox\*O.
.LI "\*Lw\*O [\*Vfile\*O]" 
Saves the message, without its postmark, in
\*Vfile\*O instead of in the default mail file, \*L$HOME/mbox\*O.
.LI "\*Lm\*O \*Vuser\*O" 
Forwards the message to \*Vuser\*O.
.LI "\*Lq\*O" 
Writes any mail not yet deleted to
\*L/var/spool/mail/\*Vuser\*O and exits.
Pressing the End-of-File key sequence has the same effect.
.LI "\*Lx\*O" 
Writes all mail unchanged to \*L/var/spool/mail/\*Vuser\*O
and exits.
.LI "\*L!\*Vsystem_command\*O" 
Runs the specified command.
.LI "\*L*\*O (asterisk)"
Displays a subcommand summary.
.LI "\*Lhelp\*O" 
Displays a subcommand summary.
.LE 
.SH EXAMPLES
.PP 
.AL 3m 
.LI
To display your mail, enter:
.iS
mail
\*O\c
.iE
.PP
After the most recent message is displayed, a \*L?\*O (question
mark) indicates that \*Lmail\*O is waiting for one of the
subcommands explained previously (\*L\(pl\*O, \*L-\*O, \*Ld\*O, \*Lp\*O,
and so on).  Enter \*Lhelp\*O or
\*L*\*O (asterisk) to list the subcommands available.
.LI
If the End-of-File key sequence is \*L<Ctrl-d>\*O, you send
mail to other users by entering:
.iS
mail tom rachel
Don't forget the meeting tomorrow at 9:30.
<Ctrl-d>
\*O\c
.iE
.PP
In this example, the system
mails the message \*CDon't forget the meeting
tomorrow at 9:30.\*O to the users \*Ltom\*O and \*Lrachel\*O.
The End-of-File key sequence (in this case, \*L<Ctrl-d>\*O) indicates the
end of the message, but it is not sent with the text.
.LI
To send a file to another user, enter:
.iS
mail fran < proposal
\*O\c
.iE
.PP
This command sends the contents of the file \*Lproposal\*O to \*Lfran\*O.
.LI
To save a message to the default mail file, enter:
.iS
mail
\*O\c
.iE
.PP
This command displays each message mailed to you.
Press \*L<Return>\*O after the \*L?\*O prompt until the desired
message is displayed.
.PP
When the appropriate message is displayed, enter:
.iS
s
\*O\c
.iE
.PP
The message is saved in the default mail file, \*L$HOME/mbox\*O.
.LI
To save a message to a specific file, enter:
.iS
mail
\*O\c
.iE
.PP
This command displays each message mailed to you.
Press \*L<Return>\*O after the \*L?\*O prompt until the desired
message is displayed.
When the appropriate message is displayed, enter:
.iS
s mycopy
\*O\c
.iE
.PP
This command saves the message in a file named \*Lmycopy\*O in the
current directory, rather than in the default mail file.
.LE 
.SH FILES
.PP 
.VL 11m
.LI "\*L$HOME/mbox\*O"
Holds saved mail.
.LI "\*L$HOME/dead.letter\*O" 
Holds unmailable text.
.LI "\*L/etc/passwd\*O" 
Contains user information.
.LI "\*L/var/spool/mail/\*Vuser\*O" 
Holds incoming mail for \*Vuser\*O.
.LI "\*L/var/spool/mail/*.lock\*O" 
Lock for mail directory.
.LE 
.SH EXIT VALUES
For information about exit values, see the \*LFLAGS\*O section.
.SH RELATED INFORMATION
.PP 
Commands:  \*Llogin\*O(1), \*Lmailx\*O(1)/\*LMail\*O(1), \*Lsendmail\*O(8),
\*Lwrite\*O(1), \*Luucp\*O(1).
#ifdef SEC_BASE
.PP 
\*(sU.
#endif SEC_BASE
