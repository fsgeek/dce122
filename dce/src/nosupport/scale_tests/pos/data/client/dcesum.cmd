#!/usr/bin/rexx
/************************************************************************
* RPCSUM - Summarizes RPC atomic benchmark measurements
************************************************************************/

/*#parse upper arg infile .*/
parse arg infile .
if (infile = '') then do
   say 'Program to summarize output (.OUT) file obtained from'
   say 'running the RPCAC command file.'
   say 'Syntax - RPCSUM test_case_output_file_name_w/o_extension'
   say '  The program takes one input.  The test case output file name'
   say '  without an extension.  This is the output file from running the'
   say '  RPCAC command file.'
   exit
end

outfile = infile'.sum'
infile = infile'.out'

if stream(infile, 'c', 'query exists') = '' then do
   say infile 'does not exist'
   exit
end
linein(infile, 1, 0)

/* print a header in the output file */
if stream(outfile, 'c', 'query exists') <> '' then do
/* '@echo off'*/
   'rm' outfile
end
temp = '                                                     FILENAME=' outfile
rc = lineout(outfile, temp)
rc = lineout(outfile, '------------------------------')
rc = lineout(outfile, 'RPC Atomic Measurement Summary')
rc = lineout(outfile, '------------------------------')

if (lines(infile) = 0) then exit
inputline = linein(infile)

do while (1=1)

   /* if atomic found */
   parse var inputline 'atomic:' atomic_name
   if (atomic_name <> '') then do

      /* initialize */
      min = 9999999; max = 0
      total = 0; num = 0; avg = 0
      meas = ''; meas_alt = '';

      /* find the measurements */
      do while (meas = '')
         if (lines(infile) = 0) then exit
         inputline = linein(infile)
         call MeasParse
      end

      /* repeat while there are measurements */
      do while (meas <> '')
         /* calculate min, max, total, and number of measurements */
         if (meas < min) then min = meas
         if (meas > max) then max = meas
         total = total + meas
         num = num + 1
         /* read next line */
         if (lines(infile) = 0) then exit
         inputline = linein(infile)
         call MeasParse
      end

      /* print atomic name and min, max, avg */
      temp = left(atomic_name,30) 'min:' right(min,10) 'max:' right(max,10)
      temp = temp 'avg:' right(trunc(total/num,3),10)
      rc = lineout(outfile, temp)

   end
   else /* not an atomic */
   do
      /* read the next line */
      if (lines(infile) = 0) then exit
      inputline = linein(infile)
   end /* if an atomic */
end
exit 0
/***************************************************************************/
/* MeasParse - Parses a line to see if it has a measurement                */
/***************************************************************************/
MeasParse:
   parse var inputline . 'real/call:' meas 'ms' .
   parse var inputline . 'Time:' meas_alt1 'ms' .
   parse var inputline . 'ms/call:' meas_alt2';' .
   parse var inputline . 'ms/call:' meas_alt3 .
   if (meas = '') then
      if (meas_alt1 <> '') then
         meas = meas_alt1
      else if (meas_alt2 <> '') then
         meas = meas_alt2
      else
         meas = meas_alt3
   RETURN
