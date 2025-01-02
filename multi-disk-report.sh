#!/bin/bash
#
# Loop through all discs to produce the iostat graphs
CWD=$(dirname $0)

if [ $# -ne 2 ];then
	echo "Generate the iostat graphs from a list of discs"
	echo ""
	echo "Useage: $0 <file listing disk names> <iostats output>"
	echo ""
	exit 1
fi

DISKS=$1
IOSTATS=$2

while read DISK
do
    $CWD/disk-report.sh $DISK $IOSTATS
done < $DISKS
