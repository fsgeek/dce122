#!/usr/bin/rexx
/* this exec will call the mstcli command twice. once with udp */
/* and once with tcp */

parse arg netid dceon outpath .

if netid = '' | dceon = '' then do
  say 'usage: mstcli1 netid dceon outpath'
  say 'where dceon = 1 or 0 '
  say ' ex:  mstcli1 129.35.66.247 1'
  exit 90
end

/*
if lastpos("\",outpath) \= length(outpath) then outpath = outpath||'\'
*/
if lastpos("/",outpath) \= length(outpath) then outpath = outpath||'/'

char.0 = 2
char.1 = 'u'
char.2 = 't'
do i = 1 to char.0
  'rm' outpath||'pipef'||char.i||'.out >nul 2>nul'
  'rm' outpath||'vary'||char.i||'.sum >nul 2>nul'
  'rm' outpath||'threads'||char.i||'.sum >nul 2>nul'
  'rm' outpath||'security'||char.i||'.sum  >nul 2>nul'
end


pps. = ''
pps.0 = 2
pps.1 = 'udp'
pps.2 = 'tcp'

do i = 1 to pps.0
'mstcli.cmd' netid pps.i dceon outpath
end


exit 0
