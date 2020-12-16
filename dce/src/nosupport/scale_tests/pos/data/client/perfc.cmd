#!/usr/bin/rexx
/**************************************************************************
* RPC PERF (security) Atomics, Client side
* Inputs:
*   %1 - server inet address
*   %2 - outfile_w/o_extension
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
'echo                                             FILENAME=' outfile' >'outfile
'echo --------------------------------------- >>'outfile
'echo RPC PERF \(security\) Atomic Measurements >>'outfile
'echo --------------------------------------- >>'outfile

'echo' pps 'cases >>'outfile

'echo atomic:' pps 'null security=none           >>'outfile
'client -p default,dce,none          0' ps':'server_addr'[2001] 4 200 n n | tee -a 'outfile
'echo atomic:' pps 'null security=connect        >>'outfile
'client -p default,dce,connect       0' ps':'server_addr'[2001] 4 200 n n | tee -a 'outfile
'echo atomic:' pps 'null security=call           >>'outfile
'client -p default,dce,call          0' ps':'server_addr'[2001] 4 200 n n | tee -a 'outfile
'echo atomic:' pps 'null security=pkt            >>'outfile
'client -p default,dce,pkt           0' ps':'server_addr'[2001] 4 200 n n | tee -a 'outfile
'echo atomic:' pps 'null security=pkt_integrity  >>'outfile
'client -p default,dce,pkt_integrity 0' ps':'server_addr'[2001] 4 200 n n | tee -a 'outfile
'echo atomic:' pps 'null security=pkt_privacy    >>'outfile
'client -p default,dce,pkt_privacy   0' ps':'server_addr'[2001] 4 200 n n | tee -a 'outfile

'echo atomic:' pps '1024 security=none           >>'outfile
'client -p default,dce,none          1' ps':'server_addr'[2001] 4 200 n n 1024 | tee -a 'outfile
'echo atomic:' pps '1024 security=connect        >>'outfile
'client -p default,dce,connect       1' ps':'server_addr'[2001] 4 200 n n 1024 | tee -a 'outfile
'echo atomic:' pps '1024 security=call           >>'outfile
'client -p default,dce,call          1' ps':'server_addr'[2001] 4 200 n n 1024 | tee -a 'outfile
'echo atomic:' pps '1024 security=pkt            >>'outfile
'client -p default,dce,pkt           1' ps':'server_addr'[2001] 4 200 n n 1024 | tee -a 'outfile
'echo atomic:' pps '1024 security=pkt_integrity  >>'outfile
'client -p default,dce,pkt_integrity 1' ps':'server_addr'[2001] 4 200 n n 1024 | tee -a 'outfile
'echo atomic:' pps '1024 security=pkt_privacy    >>'outfile
'client -p default,dce,pkt_privacy   1' ps':'server_addr'[2001] 4 200 n n 1024 | tee -a 'outfile

'echo atomic:' pps '4096 security=none           >>'outfile
'client -p default,dce,none          1' ps':'server_addr'[2001] 4 200 n n 4096 | tee -a 'outfile
'echo atomic:' pps '4096 security=connect        >>'outfile
'client -p default,dce,connect       1' ps':'server_addr'[2001] 4 200 n n 4096 | tee -a 'outfile
'echo atomic:' pps '4096 security=call           >>'outfile
'client -p default,dce,call          1' ps':'server_addr'[2001] 4 200 n n 4096 | tee -a 'outfile
'echo atomic:' pps '4096 security=pkt            >>'outfile
'client -p default,dce,pkt           1' ps':'server_addr'[2001] 4 200 n n 4096 | tee -a 'outfile
'echo atomic:' pps '4096 security=pkt_integrity  >>'outfile
'client -p default,dce,pkt_integrity 1' ps':'server_addr'[2001] 4 200 n n 4096 | tee -a 'outfile
'echo atomic:' pps '4096 security=pkt_privacy    >>'outfile
'client -p default,dce,pkt_privacy   1' ps':'server_addr'[2001] 4 200 n n 4096 | tee -a 'outfile

'echo "*****" >>'outfile

/* kill the server */
'client -p default,dce,none 11 ' ps':'server_addr'[2001] 3'

exit 0

/***************************************************************************/
/* PrintHelp subroutine prints the help on how to use this command file    */
/***************************************************************************/
PrintHelp:
   say ' '
   say 'PERFC: Input parameters HELP'
   say '   There are three input parameters: '
   say '      %1 - server_addr '
   say '   This is the server''s internet address (4 numbers separated by dots).'
   say '      %2 - outfile_w/o_extension'
   say '   This is the output file name without an extension.  The .OUT extension'
   say '   will be added by this program.'
   say '      %3 - protocol sequence   '
   say '   protocol sequence - udp or tcp '
   RETURN
