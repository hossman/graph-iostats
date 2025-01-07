#!/bin/bash

source $(dirname $0)/_utils.sh

RKBS=$(required_header_index 'rkB/s' "$4")
WKBS=$(required_header_index 'wkB/s' "$4")

gnuplot <<_EOF_
set terminal png size 1280,960
set output "$3"
set title "$2: Read/Write thoughput"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%H:%M\n%d/%m"
set xtics nomirror scale 3,2
set ylabel "kBs"
set samples 10
plot "$1" using 1:$RKBS title "reads KB per sec (rkB/s)" with lines, \
"$1" using 1:$WKBS title "writes KB per sec (wkB/s)" with lines
_EOF_


