#!/bin/sh
trap 'rm -f /tmp/rgyperf.sh; exit 1' 1 2 3 9 15
while read text
do
echo "$text"
done | rgy_edit | timestmp
