#!/bin/bash

source $(dirname $0)/_utils.sh

RRQMS=$(required_header_index 'rrqm/s' "$4")
WRQMS=$(required_header_index 'wrqm/s' "$4")
RS=$(required_header_index 'r/s' "$4")
WS=$(required_header_index 'w/s' "$4")
#=$(required_header_index '' "$4")

gnuplot <<_EOF_
set terminal png size 1280,960
set output "$3"
set title "$2: Read/Write requests"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%H:%M\n%d/%m"
set xtics nomirror scale 3,2
set ylabel "Requests"
set samples 10
plot "$1" using 1:$RRQMS title "read req merged per sec (rrqm/s)" with lines, \
"$1" using 1:$WRQMS title "write req merged per sec (wrqm/s)" with lines, \
"$1" using 1:$RS title "read req per sec (r/s)" with lines, \
"$1" using 1:$WS title "write req per sec (w/s)" with lines
_EOF_


