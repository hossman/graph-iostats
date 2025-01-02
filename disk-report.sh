#!/bin/bash
#
# Loop through all discs to produce the iostat graphs
CWD=$(dirname $0)

if [ $# -ne 2 ];then
	echo "Generate the iostat graphs for a single disk"
	echo ""
	echo "Useage: $0 <disk name> <iostats output>"
	echo ""
	exit 1
fi

DISK=$1
IOSTATS=$2

$CWD/iostat-readwrite-requests.sh $IOSTATS $DISK $DISK-requests.png
$CWD/iostat-readwrite-throughput.sh $IOSTATS $DISK $DISK-throughput.png
$CWD/iostat-queue-length.sh $IOSTATS $DISK $DISK-queue-length.png
$CWD/iostat-queue-size.sh $IOSTATS $DISK $DISK-queue-size.png
$CWD/iostat-service.sh $IOSTATS $DISK $DISK-service.png
$CWD/iostat-utilisation.sh $IOSTATS $DISK $DISK-utilisation.png
