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

source $CWD/_utils.sh

HEADER_LINE=$(get_header_line $IOSTATS)

DISK_IOSTATS=$(mktemp "$IOSTATS.$DISK.tmp.XXXXXX")
cat $IOSTATS | grep "$DISK " > $DISK_IOSTATS

$CWD/iostat-readwrite-requests.sh $DISK_IOSTATS $DISK $DISK-requests.png "$HEADER_LINE"
$CWD/iostat-readwrite-throughput.sh $DISK_IOSTATS $DISK $DISK-throughput.png "$HEADER_LINE"
$CWD/iostat-queue-length.sh $DISK_IOSTATS $DISK $DISK-queue-length.png "$HEADER_LINE"
$CWD/iostat-request-size.sh $DISK_IOSTATS $DISK $DISK-request-size.png "$HEADER_LINE"
$CWD/iostat-service.sh $DISK_IOSTATS $DISK $DISK-service.png "$HEADER_LINE"
$CWD/iostat-utilisation.sh $DISK_IOSTATS $DISK $DISK-utilisation.png "$HEADER_LINE"

rm $DISK_IOSTATS
