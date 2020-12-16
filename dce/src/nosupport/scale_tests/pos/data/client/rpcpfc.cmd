#!/usr/bin/rexx
/**************************************************************************
* RPC Pipe (Fast Version) Atomics, Client side
* Inputs:
*   %1 - server inet address
*   %2 - protsequence udp/tcp
**************************************************************************/

/* load functions */


parse arg server_addr outfile protseq .

if (server_addr = '?') | (server_addr = '') | (outfile = '') | (protseq = '' ) then
do
   call PrintHelp
   exit 'Help'
end

if protseq = 'udp' | protseq = 'UDP' then do
   pps = 'udp'
   ps = 'ncadg_ip_udp'
end
else do
   pps = 'tcp'
   ps = 'ncacn_ip_tcp'
end
/* initialize the output file */
outfile = outfile'.out'
'echo "                                            FILENAME="' outfile' >'outfile
'echo ------------------------------------------- >>'outfile
'echo RPC Pipe \(Fast Version\) Atomic Measurements >>'outfile
'echo ------------------------------------------- >>'outfile


'echo atomic:' pps '1 byte pipef case >>'outfile
logcmd = 'pipefc' ps server_addr ' 0 200 4 1 1 1'
call logrun

'echo atomic:' pps '100 byte pipef case >>'outfile
logcmd = 'pipefc' ps server_addr ' 0 200 4 100 100 100'
call logrun

'echo atomic:' pps '1024 byte pipef case >>'outfile
logcmd = 'pipefc' ps server_addr ' 0 200 4 1024 1024 1024'
call logrun

'echo atomic:' pps '2048 byte pipef case >>'outfile
logcmd = 'pipefc' ps server_addr ' 0 200 4 2048 2048 2048'
call logrun

'echo atomic:' pps '4096 byte pipef case >>'outfile
logcmd = 'pipefc' ps server_addr ' 0 200 4 4096 4096 4096'
call logrun

'echo atomic:' pps '8196 byte pipef case >>'outfile
logcmd = 'pipefc' ps server_addr ' 0 200 4 8196 8196 8196'
call logrun

'echo atomic:' pps '2M byte pipef case >>'outfile
logcmd = 'pipefc' ps server_addr ' 0 1 10 2097152 16384 16384'
call logrun

/* kill the server */
'echo kill the server run, ignore output >>'outfile
logcmd = 'pipefc' ps server_addr ' 0 1 1 1 1 1 kill'
call logrun

'echo "*********************************************************" >>'outfile


exit 0

/***************************************************************************/
/* logrun subroutine executes the command and echos it and its results to  */
/* a file.                                                                 */
/***************************************************************************/
logrun:
  'echo' logcmd '>>'outfile
  logcmd '>>'outfile
return

/***************************************************************************/
/* PrintHelp subroutine prints the help on how to use this command file    */
/***************************************************************************/
PrintHelp:
   say ' '
   say 'RPCPFC: Input parameters HELP'
   say '   There are 3 input parameters: '
   say '      %1 - server_addr '
   say '   This is the server''s internet address (4 numbers separated by dots).'
   say '      %2 - outfile_w/o_extension'
   say '   This is the output file name without an extension.  The .OUT extension'
   say '   will be added by this program.'
   say '      %3 - protocol sequence    '
   say '   This is the protocol sequence to be used tcp or udp'
   RETURN
