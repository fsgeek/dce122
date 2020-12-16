#!/usr/bin/rexx
/**************************************************************************
* RPC Atomics, Client side  .... 2 K blocksize for UDP  4K, 8K transfer
* Inputs:
*   %1 - server inet address
*   %2 - outfile name
*   %3 - udp/tcp prot seq
* 4/20/93 DAB   added 2m testcase
**************************************************************************/

/* load functions */

parse arg server_addr outfile protseq .

if protseq = 'udp' | protseq = 'UDP'  then do
   pps = 'udp'
   ps = 'ncadg_ip_udp'
end
else do
   pps = 'tcp'
   ps = 'ncacn_ip_tcp'
end

if (server_addr = '?') | (server_addr = '') | (outfile = '') | (protseq = '') then
do
   call PrintHelp
   exit 'Help'
end




/* initialize the output file */
outfile = outfile'.out'
'echo "                                           FILENAME="' outfile' >'outfile
'echo ----------------------- >>'outfile
'echo RPC Atomic Measurements >>'outfile
'echo ----------------------- >>'outfile

/* Connection-less cases */
'echo atomic:' pps ' null >>'outfile
'appperfc' ps server_addr ' 0 200 4 0 0 0 null | tee -a' outfile
'echo atomic:' pps ' 100 byte exchange >>'outfile
'appperfc' ps server_addr ' 0 200 4 100 100 100 byte | tee -a' outfile
'echo atomic:' pps ' 1K byte transfer >>'outfile
'appperfc' ps server_addr ' 0 200 4 1024 0 1024 byte | tee -a' outfile
'echo atomic:' pps ' 2K byte transfer >>'outfile
'appperfc' ps server_addr ' 0 200 4 2048 0 2048 byte | tee -a' outfile
'echo atomic:' pps ' 4K byte transfer >>'outfile
'appperfc' ps server_addr ' 0 200 4 4096 0 4096 byte | tee -a' outfile
'echo atomic:' pps ' 8K byte transfer >>'outfile
'appperfc' ps server_addr ' 0 200 4 8192 0 8192 byte | tee -a' outfile
'echo atomic:' pps ' 8K byte transfer server to client>>'outfile
'appperfc' ps server_addr ' 0 200 4 0 8192 8192 byte | tee -a' outfile
'echo atomic:' pps ' 2M byte transfer blocked at 16K >>'outfile        /* 4/20 */
'appperfc' ps server_addr ' 0 1 10 2097152 0 16384 byte | tee -a' outfile

/* kill the server */
'echo kill the server run, ignore output >>'outfile
'appperfc' ps server_addr ' 0 1 1 0 0 0 null kill >>'outfile

/* wait for server to restart */
'sleep 5'
'echo "*********************************************************" >>'outfile

exit 0

/***************************************************************************/
/* PrintHelp subroutine prints the help on how to use this command file    */
/***************************************************************************/
PrintHelp:
   say ' '
   say 'RPCVAC: Input parameters HELP'
   say '   There are 3 input parameters: '
   say '      %1 - server_addr '
   say '   This is the server''s internet address (4 numbers separated by dots).'
   say '      %2 - outfile_w/o_extension'
   say '   This is the output file name without an extension.  The .OUT extension'
   say '   will be added by this program.'
   say '      %3 - tcp/udp              '
   say '   This indicated which protocol sequence to run '
   RETURN
