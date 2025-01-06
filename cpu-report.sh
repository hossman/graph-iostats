#!/bin/bash
#
CWD=$(dirname $0)

if [ $# -ne 1 ];then
	echo "Generate the iostat CPU graphs"
	echo ""
	echo "Useage: $0 <iostats output>"
	echo ""
	exit 1
fi

source $CWD/_utils.sh

HEADER=$(grep -m 1 ' avg-cpu:' "$1")
if [ -z "$HEADER" ]; then
  echo "Unable to find header line in $1" 1>&2
  exit -1;
fi

# headers for CPU are off by one since we have no device name...
USER=$(($(required_header_index '%user' "$HEADER") - 1))
NICE=$(($(required_header_index '%nice' "$HEADER") - 1))
SYS=$(($(required_header_index '%system' "$HEADER") - 1))
IOWAIT=$(($(required_header_index '%iowait' "$HEADER") - 1))
STEAL=$(($(required_header_index '%steal' "$HEADER") - 1))
IDLE=$(($(required_header_index '%idle' "$HEADER") - 1))

CPU_IOSTATS=$(mktemp "$IOSTATS.cpu.tmp.XXXXXX")
cat $1 | grep -A 1 avg-cpu | grep -v avg-cpu | grep -v -- '--' > $CPU_IOSTATS

gnuplot <<_EOF_
set terminal png
set output "cpu.png"
set title "Avg CPU"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%H:%M\n%d/%m"
set xtics nomirror scale 3,2
set ylabel "Miliseconds"
set samples 10
set key below
plot \
  "$CPU_IOSTATS" using 1:(\$$IOWAIT+\$$SYS+\$$NICE+\$$USER+\$$STEAL+\$$IDLE) title "Idle" with filledcurves x1, \
  "$CPU_IOSTATS" using 1:(\$$IOWAIT+\$$SYS+\$$NICE+\$$USER+\$$STEAL) title "Steal" with filledcurves x1, \
  "$CPU_IOSTATS" using 1:(\$$IOWAIT+\$$SYS+\$$NICE+\$$USER) title "User" with filledcurves x1, \
  "$CPU_IOSTATS" using 1:(\$$IOWAIT+\$$SYS+\$$NICE) title "Nice" with filledcurves x1, \
  "$CPU_IOSTATS" using 1:(\$$IOWAIT+\$$SYS) title "System" with filledcurves x1, \
  "$CPU_IOSTATS" using 1:(\$$IOWAIT) title "I/O Wait" with filledcurves x1
_EOF_

rm $CPU_IOSTATS
