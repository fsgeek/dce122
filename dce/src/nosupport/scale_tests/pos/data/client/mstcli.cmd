#!/usr/bin/rexx
/* This is the master file that starts the client commands. */
/*  It must be started on the client machine.                */
/* 5/4/93 DAB init                                          */

parse arg netid protseq dceon outpath .
if netid = '' | protseq = '' | dceon = '' then call errtn

if protseq = 'udp' | protseq = 'UDP' then char = 'u'
else char = 't'


if lastpos("/",outpath) \= length(outpath) then outpath = outpath||'/'


say 'rpcpfc.cmd' netid outpath||'pipef'||char protseq
'rpcpfc.cmd' netid outpath||'pipef'||char protseq

/* wait for pipef server to die and vary server to start */
'sleep 30'
say 'rpcvac.cmd' netid outpath||'vary'||char protseq
'rpcvac.cmd' netid outpath||'vary'||char protseq

'sleep 20'
say 'threadc' netid protseq
'threadc' netid protseq

if dceon then do
  'sleep 20'
  say 'perfc.cmd' netid outpath||'security'||char protseq
  'perfc.cmd' netid outpath||'security'||char protseq
end

in. = ''
in.0 = 4
in.1 = outpath||'pipef'
in.2 = outpath||'vary'
in.3 = outpath||'threads'
in.4 = outpath||'security'


do i = 1 to in.0
  say 'dcesum.cmd' in.i||char
  'dcesum.cmd' in.i||char

end



exit 0

ERRTN:

 say 'usage: mstcli netid protseq (udp or tcp) dceon (1 or 0) outpath'
 exit 99


