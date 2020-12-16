#! /usr/bin/rexx

/* this is the pgm that runs the atomic benchmarks for security and cds  */
/* init - ? Weeks                                                        */
/* 6/2/93 DAB added check for outpath, removed hardcode path for dce code*/

arg input
if ((input = "?") | (length(input) == 0)) then call HelpMe

/* init all flags to 0 */
RunAll   = 0
RunCDS   = 0
RunSec   = 0
RunRPC   = 0
VDisk    = ""
UseVDisk = 0
DeBug    = 0
tcp = 0
udp = 0
both = 0


RC=WORDPOS('AIX', input)
if RC=0 then do
	Aix   = 0
	OSYS = "OS/2 "
	SrcPath  = ".\"
	OutPath  = ".\"
	EchoOff="@echo off"
	EchoOn=""
	Clear="cls"
	Mkdir = "md"
	DevNull = ">nul 2>nul"
	DevNul = ">nul"
	Dir = "dir"
	Erase = "erase"
	EraseAsk = "echo Y | erase"
	Copy = "copy"
	Pause = "@PAUSE"
end
else do
	Aix   = 1
	OSYS="AIX  "
	SrcPath="./"
	OutPath="./"
	EchoOff="stty -echo"
	EchoOn="stty echo"
	Clear="clear"
	Mkdir="mkdir"
	DevNull=">/dev/null 2>&1"
	DevNul=">/dev/null"
	Dir="ls"
	Erase="rm"
	EraseAsk = "rm -i"
	Copy = "cp"
	Pause="read a"
end

/* ------------------------------------------------------------------ +
 |                                                                    |
 | Parse the command line arguments and set options                   |
 |                                                                    |
 + ------------------------------------------------------------------ */

do forever
  parse upper var input parm input
  if parm == "" then leave

  if parm == "ALL" then do
    RunAll = 1
    RunCDS = 1
    RunSec = 1
    RunRPC = 1
    udp = 1
    tcp = 1
    iterate
  end

  if parm == "CDS" then do
    RunCDS = 1
    iterate
  end

  if parm == "SEC" then do
    RunSec = 1
    iterate
  end

  if parm == "RPC" then do
    RunRPC = 1
    iterate
  end

  if parm == "SRC" then
    parse upper var input SrcPath input

  if parm == "V" then do
    UseVDisk = 1
    parse upper var input VDisk input
  end

  if parm == "OUT" then 
    parse upper var input OutPath input

  if parm == "DEBUG" then
    DeBug = 1

  if parm == "TCP" then
    tcp = 1

  if parm == "UDP" then
    udp = 1

  if parm == "BOTH" then do
    tcp = 1
    udp = 1
  end
  if parm == "AIX" then do
	Aix   = 1
  end
end


EchoOff
Clear
EchoOn
say ' '
say ' '
say 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
say '³                                                                     ³'
say '³                          DCE 1.0 for' OSYS'                          ³'
say '³                                                                     ³'
say '³                    Integrated Atomic Benchmarks                     ³'
say '³                                                                     ³'
say 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'

/* check to make sure the outpath dir exists, if not create it */

say 'outpath 'outpath
/*
'dir' outpath '>nul 2>nul'
*/
Dir outpath DevNull
if rc = 0 then nop
else do
  Mkdir outpath
  if rc = 0 then nop
  else do
     say 'Unable to create the outpath directory, ' outpath  'rc = 'rc '.'
     say 'Manually create and re-execute this program.'
     exit 90
  end
end
/* append slash (\) or backslash (/) to the paths */

call AppendSlash SrcPath Aix
SrcPath = result

call AppendSlash OutPath Aix
OutPath = result

call AppendSlash VDisk Aix
VDisk   = result


if RUNCDS then do
  say 'Have you logged on as an administrator?  If not, press Ctrl+Break'
  say 'to end this test now.  Otherwise....'
  say ' '
  Pause

  TestAPI = 1
  say ' '
  say 'Enter the name of the CDS clearinghouse (or press Enter to skip API test)...'
  say ' '
  parse pull  ClearH .
  if (length(ClearH) == 0 ) then do
    TestAPI = 0
    say ' '
    say 'No clearinghouse name entered.  CDS API will not be tested.'
    say ' '
  end
end /* runcds*/

if RunRPC then do
 /* if rpc is specified, then tcp and/or udp must be specified. */
  if (\tcp & \udp) then do
   say ' '
   say 'TCP, UDP or Both must be specified if RPC is specified.'
   say ' '
   exit 90
  end

  say 'Enter the net id of the server that DCE has been started on.'
  say 'RPC benchmarks must be running on the server (mstsrv1 or mstsrv).'
  pull netid .
  if netid = '' | netid = 'NETID' then do
    say ' '
    say 'The net id of the server machine is necessary to run the'
    say 'RPC benchmark.'
    say ' '
    exit 90
  end
end /* runrpc */

say ' '
say 'You will be asked 4 questions that pertain to the hardware and software'
say 'environment that the measurements will be running in.  The answers to'
say 'these questions will be stored at the end of each report file.'
say ' '

buildlevel = ''
os2level = ''
client = ''
server = ''

say ' '
say 'Enter the build level of DCE that you have installed'
pull buildlevel .

say ' '
say 'Enter the level of ' OSYS' that you have installed'
pull os2level .

say ' '
say 'Enter a description of the client machine'
say 'ex:  Mod 80 client 25 Mh'
pull client

say ' '
say 'Enter a description of the server machine'
say 'ex:  Mod 95 server 33 Mh'
pull server

outfile = outpath || 'measenv.out'
Erase outfile DevNull
'echo The build level for this run is' buildlevel'. >>' outfile
'echo The ' OSYS 'level for this run is' os2level'. >>' outfile
'echo The client configuration is ' client'. >>'outfile
'echo The server configuration is ' server'. >>' outfile

if (DeBug) then trace r

StartClock = time(M)

/* call each subcomponent based on input flags */
if (RunSec) then call SECAtomics
if (RunCDS) then call CDSAtomics
if (RunRPC) then call RPCAtomics

StopClock = time(M)
say "Elapsed time:" StopClock-StartClock "minutes."

return

/* ------------------------------------------------------------------ */
CDSAtomics: procedure EXPOSE UseVDisk VDisk SrcPath OutPath outfile TestAPI ,
clearh OSYS Aix 

if(Aix) then nop
else do
'SETLOCAL'
end

say 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
say '³                                                                     ³'
say '³                          DCE 1.0 for' OSYS'                          ³'
say '³                                                                     ³'
say '³                       Cell Directory Services                       ³'
say '³                                                                     ³'
say '³                   Performance Analysis Benchmark                    ³'
say '³                                                                     ³'
say 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
say ' '

RunIn = SrcPath
RunOut = Outpath


if(Aix) then do
	'rm' OutPath || 'perf1*.out >/dev/null 2>&1'
	'rm' OutPath || 'perf1*.rpt >/dev/null 2>&1'
	'rm' OutPath || '*.log >NUL >/dev/null 2>&1'
end
else do
	'erase' OutPath || 'perf1*.out >NUL 2>NUL'
	'erase' OutPath || 'perf1*.rpt >NUL 2>NUL'
	'erase' OutPath || '*.log >NUL 2>NUL'
	if (UseVDisk) then do
  		RunIn = VDisk
  		RunOut = VDisk
  		'echo Y | erase' VDisk || '*.* >NUL 2>nul'
  		'copy' SrcPath || 'perf1*.in' VDisk '>NUL'
  		if (TestAPI) then do
    			'copy' SrcPath || 'perfpi.exe' VDisk '>NUL'
    			'copy' SrcPath || 'perfobj' VDisk '>NUL'
    			'copy' SrcPath || 'perfdir' VDisk '>NUL'
  		end
	end
end




say ' '
say 'Setting up the CDS environment....  (' time(N) ')'
if(Aix) then do
	'sh cpperf.sh <' RunIn || 'perf1do.in >/dev/null 2>&1'
end
else do
	'sh cpperf.sh <' RunIn || 'perf1do.in >NUL'
end

say ' '
say 'Beginning benchmark run....'
say 'Running PERF1CO...  (' time(N) ')'
'sh cpperf.sh <' RunIn || 'perf1co.in  >' RunOut || 'perf1co.out'
say 'Running PERF1SET...  (' time(N) ')'
'sh cpperf.sh <' RunIn || 'perf1set.in >' RunOut || 'perf1set.out'
say 'Running PERF1RST...  (' time(N) ')'
'sh cpperf.sh <' RunIn || 'perf1rst.in >' RunOut || 'perf1rst.out'
say 'Running PERF1DIR...  (' time(N) ')'
'sh cpperf.sh <' RunIn || 'perf1dir.in >' RunOut || 'perf1dir.out'

say 'Running NSI...  (' time(N) ')'
/* initialize the namespace  - setup */
'nsiserve >' RunOut || 'nsiserve.out'
'nsi /.:/NSI_Test_Group >' RunOut || 'nsi.rpt'

/* output written to nul since perfpi writes output to infile.log */
if (TestAPI) then do
 if (UseVDisk) then do
  curdir = directory()
  newdir = substr(vdisk,1,1)||':'
  newdir
 end
  if(Aix) then do
  	say 'Running PERFDIR...  (' time(N) ')'
  	'perfpi' RunIn || 'perfdir /.:/ /.:/'||clearh '>/dev/null 2>&1'
  	say 'Running PERFOBJ...  (' time(N) ')'
  	'perfpi' RunIn || 'perfobj /.:/ /.:/'||clearh '>/dev/null 2>&1'
  end
  else do
  	say 'Running PERFDIR...  (' time(N) ')'
  	'perfpi' RunIn || 'perfdir /.:/ /.:/'||clearh '>nul'
  	say 'Running PERFOBJ...  (' time(N) ')'
  	'perfpi' RunIn || 'perfobj /.:/ /.:/'||clearh '>nul'
  end
 if (UseVDisk) then do
  olddir = substr(curdir,1,2)
  olddir
 end
end

if (UseVDisk) then do
  'copy' VDisk || '*.out' Outpath '>NUL'
  'copy' VDisk || '*.log' Outpath '>NUL'
  'copy' VDisk || 'nsi.rpt' Outpath '>NUL'
end

say ' '
say 'Producing reports...  (' time(N) ')'

if(Aix) then do
say 'PERF1CO...'
'awk -f dceawk.awk' OutPath || 'perf1co.out  >' OutPath || 'perf1co.rpt'
'cat' outfile '>>'outpath||'perf1co.rpt'
say 'PERF1SET...'
'awk -f dceawk.awk' OutPath || 'perf1set.out >' OutPath || 'perf1set.rpt'
'cat' outfile '>>'outpath||'perf1set.rpt'
say 'PERF1RST...'
'awk -f dceawk.awk' OutPath || 'perf1rst.out >' OutPath || 'perf1rst.rpt'
'cat' outfile '>>'outpath||'perf1rst.rpt'
say 'PERF1DIR...'
'awk -f dceawk.awk' OutPath || 'perf1dir.out >' OutPath || 'perf1dir.rpt'
'cat' outfile '>>'outpath||'perf1dir.rpt'
'cat' outfile '>>'outpath||'nsi.rpt'
end
else do
say 'PERF1CO...'
'awk -f dceawk.awk' OutPath || 'perf1co.out  >' OutPath || 'perf1co.rpt'
'type' outfile '>>'outpath||'perf1co.rpt'
say 'PERF1SET...'
'awk -f dceawk.awk' OutPath || 'perf1set.out >' OutPath || 'perf1set.rpt'
'type' outfile '>>'outpath||'perf1set.rpt'
say 'PERF1RST...'
'awk -f dceawk.awk' OutPath || 'perf1rst.out >' OutPath || 'perf1rst.rpt'
'type' outfile '>>'outpath||'perf1rst.rpt'
say 'PERF1DIR...'
'awk -f dceawk.awk' OutPath || 'perf1dir.out >' OutPath || 'perf1dir.rpt'
'type' outfile '>>'outpath||'perf1dir.rpt'
'type' outfile '>>'outpath||'nsi.rpt'
end


if (TestAPI) then do
 if \(UseVDisk) then do
  'copy perfobj.log' OutPath||'perfobj.log >nul 2>nul'
  'erase perfobj.log >nul 2>nul'
  'copy perfdir.log' OutPath||'perfdir.log >nul 2>nul'
  'erase perfdir.log >nul 2>nul'
 end
 if(Aix) then do
  say 'PERFOBJ...'
  'awk -f perfobj.awk' OutPath ||'perfobj.log >'OutPath ||'perfobj.rpt'
  'cat' outfile '>>'outpath||'perfobj.rpt'
  say 'PERFDIR...'
  'awk -f perfdir.awk' OutPath ||'perfdir.log >'OutPath ||'perfdir.rpt'
  'cat' outfile '>>'outpath||'perfdir.rpt'
  end
  else do
  say 'PERFOBJ...'
  'awk -f perfobj.awk' OutPath ||'perfobj.log >'OutPath ||'perfobj.rpt'
  'type' outfile '>>'outpath||'perfobj.rpt'
  say 'PERFDIR...'
  'awk -f perfdir.awk' OutPath ||'perfdir.log >'OutPath ||'perfdir.rpt'
  'type' outfile '>>'outpath||'perfdir.rpt'
  end
end

/* clean up after nsi */
 if(Aix) then do
'cdscp delete object /.:/Member_01 >/dev/null 2>&1'
'cdscp delete object /.:/Member_02 >/dev/null 2>&1'
'cdscp delete object /.:/Member_03 >/dev/null 2>&1'
'cdscp delete object /.:/Member_04 >/dev/null 2>&1'
'cdscp delete object /.:/Member_05 >/dev/null 2>&1'
'cdscp delete object /.:/Member_06 >/dev/null 2>&1'
'cdscp delete object /.:/Member_07 >/dev/null 2>&1'
'cdscp delete object /.:/Member_08 >/dev/null 2>&1'
'cdscp delete object /.:/Member_09 >/dev/null 2>&1'
'cdscp delete object /.:/Member_10 >/dev/null 2>&1'
'cdscp delete object /.:/Member_11 >/dev/null 2>&1'
'cdscp delete object /.:/Member_12 >/dev/null 2>&1'
'cdscp delete object /.:/Member_13 >/dev/null 2>&1'
'cdscp delete object /.:/Member_14 >/dev/null 2>&1'
'cdscp delete object /.:/Member_15 >/dev/null 2>&1'
'rpccp remove entry  /.:/NSI_Test_Group >/dev/null 2>&1'
end
else do
'cdscp delete object /.:/Member_01 >nul 2>nul'
'cdscp delete object /.:/Member_02 >nul 2>nul'
'cdscp delete object /.:/Member_03 >nul 2>nul'
'cdscp delete object /.:/Member_04 >nul 2>nul'
'cdscp delete object /.:/Member_05 >nul 2>nul'
'cdscp delete object /.:/Member_06 >nul 2>nul'
'cdscp delete object /.:/Member_07 >nul 2>nul'
'cdscp delete object /.:/Member_08 >nul 2>nul'
'cdscp delete object /.:/Member_09 >nul 2>nul'
'cdscp delete object /.:/Member_10 >nul 2>nul'
'cdscp delete object /.:/Member_11 >nul 2>nul'
'cdscp delete object /.:/Member_12 >nul 2>nul'
'cdscp delete object /.:/Member_13 >nul 2>nul'
'cdscp delete object /.:/Member_14 >nul 2>nul'
'cdscp delete object /.:/Member_15 >nul 2>nul'
'rpccp remove entry  /.:/NSI_Test_Group >nul 2>nul'
'ENDLOCAL'
end
return

/* ------------------------------------------------------------------ */
SECAtomics: procedure EXPOSE UseVDisk VDisk SrcPath OutPath outfile Aix OSYS 

if(Aix) then nop
else do
'SETLOCAL'
end

say 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
say '³                                                                     ³'
say '³                          DCE 1.0 for' OSYS'                          ³'
say '³                                                                     ³'
say '³                          Security Services                          ³'
say '³                                                                     ³'
say '³                   Performance Analysis Benchmark                    ³'
say '³                                                                     ³'
say 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
say ' '

dcelogfile = 'dcelog.out'

if(Aix) then do
'rm' OutPath || 'dcelog.* >/dev/null 2>&1'
'rm' OutPath || 'acl*.out >/dev/null 2>&1'
'rm' OutPath || 'acl*.rpt >/dev/null 2>&1'
'rm' OutPath || 'rgy*.out >/dev/null 2>&1'
'rm' OutPath || 'rgy*.rpt >/dev/null 2>&1'
end
else do
'erase' OutPath || 'dcelog.* >NUL 2>NUL'
'erase' OutPath || 'acl*.out >NUL 2>NUL'
'erase' OutPath || 'acl*.rpt >NUL 2>NUL'
'erase' OutPath || 'rgy*.out >NUL 2>NUL'
'erase' OutPath || 'rgy*.rpt >NUL 2>NUL'
end

RunIn = SrcPath
RunOut = Outpath
if (UseVDisk) then do
  RunIn = VDisk
  RunOut = VDisk
  'echo Y | erase' VDisk || '*.* >NUL 2>NUL'
  'copy' SrcPath || 'acl*.in' VDisk '>NUL'
  'copy' SrcPath || 'rgy*.in' VDisk '>NUL'
end


say ' '
say 'Beginning benchmark run....'

if(Aix) then do
iter=5
Do n=1 to iter by 1
 t0 = time('R')
'dce_login_noexec cell_admin -dce- >' RunOut || 'KRB5NAME'
 dt = time('E')
 call LINEOUT RunOut || dcelogfile, '# ####' || dt 'dce_login_noexec Time'
end
t0 = time('R')
end
else do     		/* OS/2 portion */
/* find the drive that dce is installed on 6/2/93 */
 env = 'OS2ENVIRONMENT'
 svepath = VALUE('path',,env)
 notdone = 1
 dcepath = ''
 do while (notdone & svepath \= '')
  parse upper var svepath info ';' svepath
  if pos('\OPT\DCELOCAL\BIN',info) \= 0  then do
    notdone = 0
    dcepath = substr(info,1,2)
  end
 end  /* do while */
 if dcepath = '' then do
  say 'Error: dce code (\opt\dcelocal\bin) could not be found in path stmt'
  say 'DCE must be installed and started to execute this program'
 end

say 'Running DCELOGIN...  (' time(N) ')'
'@copy' dcepath||'\opt\dcelocal\bin\dcelogin.exe' ,
dcepath||'\opt\dcelocal\bin\dcelogne.exe >NUL 2>NUL'
env = 'OS2ENVIRONMENT'
bps=1
do until bps=0
 bps = VALUE('BIND_PE_SITE',0,env)
end
'erase' dcepath||'\OPT\DCELOCAL\ETC\SECURITY\PE_SITE.BAK >NUL 2>NUL'
'rename' dcepath||'\OPT\DCELOCAL\ETC\SECURITY\PE_SITE PE_SITE.BAK >NUL 2>NUL'


iter=5
Do n=1 to iter by 1
 t0 = time('R')
'dcelogne cell_admin -dce- >' RunOut || 'KRB5NAME'
 dt = time('E')
 call LINEOUT RunOut || dcelogfile, '# ####' || dt 'dcelogne Time'
end
t0 = time('R')

'@SET KRB5CCNAME='LINEIN(RunOut || 'KRB5NAME',1,1)
'@SET DCEUSRNAME=cell_admin'
'@SET DCEUSRID=100'
'@SET DCEGRPID=12'
end

say ' '
say 'Setting up the Security environment...  (' time() ')'
'cdscp create dir /.:/dir'
'rgy_edit <addp50 >NUL'

say 'Running ACL_Edit exit...  (' time() ')'
call LINEOUT RunOut || dcelogfile, '-'
Do n=1 to iter by 1
 t0 = TIME('R')
 'acl_edit /.:/dir < exit'
 dt = TIME('E')
 call LINEOUT RunOut || dcelogfile, '# ####' || dt 'acl_edit + exit Time'
end

say 'Running RGY_Edit exit...  (' time() ')'
call LINEOUT RunOut || dcelogfile, '-'
Do n=1 to iter by 1
 t0 = Time('R')
 'rgy_edit < quit'
 dt = time('E')
 call LINEOUT RunOut || dcelogfile, '# ####' || dt 'rgy_edit + quit Time'
end

 call LINEOUT RunOut || dcelogfile      /* close the file */


say 'Running ACLTIMES...  (' time() ')'
'sh aclperf.sh <' RunIn || 'acltimes.in  >' RunOut || 'acltimes.out'


say 'Running RGYAAI.....  (' time() ')'
'sh rgyperf.sh <' RunIn || 'rgyaai.in    >' RunOut || 'rgyaai.out'
say 'Running RGYAPI.....  (' time() ')'
'sh rgyperf.sh <' RunIn || 'rgyapi.in    >' RunOut || 'rgyapi.out'
say 'Running RGYAGI.....  (' time() ')'
'sh rgyperf.sh <' RunIn || 'rgyagi.in    >' RunOut || 'rgyagi.out'
say 'Running RGYAOI.....  (' time() ')'
'sh rgyperf.sh <' RunIn || 'rgyaoi.in    >' RunOut || 'rgyaoi.out'

say 'Running RGYCPI.....  (' time() ')'
'sh rgyperf.sh <' RunIn || 'rgycpi.in    >' RunOut || 'rgycpi.out'
say 'Running RGYCGI.....  (' time() ')'
'sh rgyperf.sh <' RunIn || 'rgycgi.in    >' RunOut || 'rgycgi.out'
say 'Running RGYCOI.....  (' time() ')'
'sh rgyperf.sh <' RunIn || 'rgycoi.in    >' RunOut || 'rgycoi.out'


say 'Running RGYVAI.....  (' time() ')'
'sh rgyperf.sh <' RunIn || 'rgyvai0.in   >' RunOut || 'rgyvai0.out'
'rgy_edit < adda1 >NUL'
'sh rgyperf.sh <' RunIn || 'rgyvai1.in  >>' RunOut || 'rgyvai1.out'
'rgy_edit < dela1 >NUL'
'rgy_edit < adda10 >NUL'
'sh rgyperf.sh <' RunIn || 'rgyvai10.in >>' RunOut || 'rgyvai10.out'
'rgy_edit < dela10 >NUL'
say 'Running RGYVPI.....  (' time() ')'
'sh rgyperf.sh <' RunIn || 'rgyvpi0.in   >' RunOut || 'rgyvpi0.out'
'rgy_edit < addp1 >NUL'
'sh rgyperf.sh <' RunIn || 'rgyvpi1.in  >>' RunOut || 'rgyvpi1.out'
'rgy_edit < delp1 >NUL'
'rgy_edit < addp10 >NUL'
'sh rgyperf.sh <' RunIn || 'rgyvpi10.in >>' RunOut || 'rgyvpi10.out'
'rgy_edit < delp10 >NUL'
say 'Running RGYVGI.....  (' time() ')'
'sh rgyperf.sh <' RunIn || 'rgyvgi0.in   >' RunOut || 'rgyvgi0.out'
'rgy_edit < addg1 >NUL'
'sh rgyperf.sh <' RunIn || 'rgyvgi1.in  >>' RunOut || 'rgyvgi1.out'
'rgy_edit < delg1 >NUL'
'rgy_edit < addg10 >NUL'
'sh rgyperf.sh <' RunIn || 'rgyvgi10.in >>' RunOut || 'rgyvgi10.out'
'rgy_edit < delg10 >NUL'
say 'Running RGYVOI.....  (' time() ')'
'sh rgyperf.sh <' RunIn || 'rgyvoi0.in   >' RunOut || 'rgyvoi0.out'
'rgy_edit < addo1 >NUL'
'sh rgyperf.sh <' RunIn || 'rgyvoi1.in  >>' RunOut || 'rgyvoi1.out'
'rgy_edit < delo1 >NUL'
'rgy_edit < addo10 >NUL'
'sh rgyperf.sh <' RunIn || 'rgyvoi10.in >>' RunOut || 'rgyvoi10.out'
'rgy_edit < delo10 >NUL'

if (UseVDisk) then do
  'copy' VDisk || '*.out' Outpath '>NUL'
end

say ' '
say 'Producing reports...  (' time() ')'
say 'DCELOGIN...'
'awk -f dceawk.awk' OutPath || dcelogfile '>' OutPath || 'dcelog.rpt'
if(Aix) then 
'cat' outfile '>>'outpath||'dcelog.rpt'
else
'type' outfile '>>'outpath||'dcelog.rpt'

say 'ACLTIMES...'
'awk -f dceawk.awk' OutPath || 'acltimes.out  >' OutPath || 'acltimes.rpt'
if(Aix) then 
'cat' outfile '>>' outpath||'acltimes.rpt'
else
'type' outfile '>>' outpath||'acltimes.rpt'



say 'RGYADD.....'
'awk -f dceawk.awk' OutPath || 'rgyaai.out    >' OutPath || 'rgyadd.rpt'
'awk -f dceawk.awk' OutPath || 'rgyapi.out   >>' OutPath || 'rgyadd.rpt'
'awk -f dceawk.awk' OutPath || 'rgyagi.out   >>' OutPath || 'rgyadd.rpt'
'awk -f dceawk.awk' OutPath || 'rgyaoi.out   >>' OutPath || 'rgyadd.rpt'
if(Aix) then 
'cat' outfile '>>'outpath||'rgyadd.rpt'
else
'type' outfile '>>'outpath||'rgyadd.rpt'
say 'RGYCHG.....'
'awk -f dceawk.awk' OutPath || 'rgycpi.out    >' OutPath || 'rgychg.rpt'
'awk -f dceawk.awk' OutPath || 'rgycgi.out   >>' OutPath || 'rgychg.rpt'
'awk -f dceawk.awk' OutPath || 'rgycoi.out   >>' OutPath || 'rgychg.rpt'
if(Aix) then 
'cat' outfile '>>'outpath||'rgychg.rpt'
else
'type' outfile '>>'outpath||'rgychg.rpt'
say 'RGYVIEW....'
'awk -f dceawk.awk' OutPath || 'rgyvai0.out   >' OutPath || 'rgyvai.rpt'
'awk -f dceawk.awk' OutPath || 'rgyvai1.out  >>' OutPath || 'rgyvai.rpt'
'awk -f dceawk.awk' OutPath || 'rgyvai10.out >>' OutPath || 'rgyvai.rpt'
if(Aix) then 
'cat' outfile '>>'outpath||'rgyvai.rpt'
else
'type' outfile '>>'outpath||'rgyvai.rpt'
'awk -f dceawk.awk' OutPath || 'rgyvpi0.out   >' OutPath || 'rgyvpi.rpt'
'awk -f dceawk.awk' OutPath || 'rgyvpi1.out  >>' OutPath || 'rgyvpi.rpt'
'awk -f dceawk.awk' OutPath || 'rgyvpi10.out >>' OutPath || 'rgyvpi.rpt'
if(Aix) then 
'cat' outfile '>>'outpath||'rgyvpi.rpt'
else
'type' outfile '>>'outpath||'rgyvpi.rpt'
'awk -f dceawk.awk' OutPath || 'rgyvgi0.out   >' OutPath || 'rgyvgi.rpt'
'awk -f dceawk.awk' OutPath || 'rgyvgi1.out  >>' OutPath || 'rgyvgi.rpt'
'awk -f dceawk.awk' OutPath || 'rgyvgi10.out >>' OutPath || 'rgyvgi.rpt'
if(Aix) then 
'cat' outfile '>>'outpath||'rgyvgi.rpt'
else
'type' outfile '>>'outpath||'rgyvgi.rpt'
'awk -f dceawk.awk' OutPath || 'rgyvoi0.out   >' OutPath || 'rgyvoi.rpt'
'awk -f dceawk.awk' OutPath || 'rgyvoi1.out  >>' OutPath || 'rgyvoi.rpt'
'awk -f dceawk.awk' OutPath || 'rgyvoi10.out >>' OutPath || 'rgyvoi.rpt'
if(Aix) then 
'cat' outfile '>>'outpath||'rgyvoi.rpt'
else
'type' outfile '>>'outpath||'rgyvoi.rpt'

say 'Cleaning up the Security environment...  (' time() ')'
'cdscp delete dir /.:/dir'
'rgy_edit <delp50 >NUL'
if(Aix) then nop
else 
'rename' dcepath||'\OPT\DCELOCAL\ETC\SECURITY\PE_SITE.BAK PE_SITE >NUL 2>NUL'

say 'Security benchmark run complete........  (' time() ')'

if(Aix) then 
	'rm NUL nul'
else
	'ENDLOCAL'

return

/* ------------------------------------------------------------------ */
RPCAtomics: procedure EXPOSE OutPath outfile udp tcp netid Aix OSYS

if(Aix) then nop
else do
'SETLOCAL'
end

say 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
say '³                                                                     ³'
say '³                          DCE 1.0 for' OSYS'                          ³'
say '³                                                                     ³'
say '³                          RPC Services                               ³'
say '³                                                                     ³'
say '³                   Performance Analysis Benchmark                    ³'
say '³                                                                     ³'
say 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
say ' '



say ' RPC benchmark starting.........  (' time() ')'
select
  when udp & tcp then 'call mstcli1' netid '1' outpath
  when udp then 'call mstcli' netid 'udp 1' outpath
  when tcp then 'call mstcli' netid 'tcp 1' outpath
end

/*
if (UseVDisk) then do
  'copy' VDisk || '*.out' Outpath '>NUL'
end
*/

/* append outfile to each report */
 if udp then do
     char = 'u'
     'type' outfile '>>' outpath||'vary'||char||'.sum'
     'type' outfile '>>' outpath||'pipef'||char||'.sum'
     'type' outfile '>>' outpath||'security'||char||'.sum'
     'type' outfile '>>' outpath||'threads'||char||'.sum'
 end

 if tcp then do
     char = 't'
     'type' outfile '>>' outpath||'vary'||char||'.sum'
     'type' outfile '>>' outpath||'pipef'||char||'.sum'
     'type' outfile '>>' outpath||'security'||char||'.sum'
     'type' outfile '>>' outpath||'threads'||char||'.sum'
 end

say ' RPC benchmark run complete.........  (' time() ')'

'ENDLOCAL'
return



/* ------------------------------------------------------------------ */


/* ------------------------------------------------------------------ */
AppendSlash: procedure        /* append a '\' to the end of a string */
  arg string systype
  newstring = string
  if newstring <> "" then do
    l = length(string)
    lastchar = substr(string,l,1)
    if systype = 0 then do
    	if lastchar <> "\" then newstring = string || "\"
    end
    else do
    	if lastchar <> "/" then newstring = string || "/"
    end
  end

  return newstring


/* ------------------------------------------------------------------ */
HelpMe: procedure
  parse source . . name .
  say ' '
  say ' '
  say name || ":"
  say "          [all[ cds[ sec[ rpc]]]]"
  say "          [src sourcepath]"
  say "          [out outpath]"
  say "          [v vdiskdrive]"
  say "          [tcp/udp/both]"
  say "          [debug]"
  say "                 "
  say " tcp, udp or both must be specified if rpc is specified"
  say ' '
  exit
