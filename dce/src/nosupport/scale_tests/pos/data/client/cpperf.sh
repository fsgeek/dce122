#!/bin/sh
trap 'rm -f /tmp/cpperf.sh; exit 1' 1 2 3 9 15
while read text
do
echo "$text"
#done | cdscp | timestmp.exe
done | cdscp | timestmp
