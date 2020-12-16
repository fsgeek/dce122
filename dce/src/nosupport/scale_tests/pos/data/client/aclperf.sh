#!/bin/sh
trap 'rm -f /tmp/aclperf.sh; exit 1' 1 2 3 9 15
while read text
do
echo "$text"
done | acl_edit /.:/dir | timestmp
