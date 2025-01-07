#!/bin/bash

source $(dirname $0)/_utils.sh

KEY='avgqu-sz'
AVGQ=$(header_index "$KEY" "$4")
if [ -z "$AVGQ" ]; then
  KEY='aqu-sz'
  AVGQ=$(required_header_index "$KEY" "$4")
fi

gnuplot <<_EOF_
set terminal png size 1280,960
set output "$3"
set title "$2: Queue Size"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%H:%M\n%d/%m"
set xtics nomirror scale 3,2
set ylabel "Requests"
set samples 10
plot "$1" using 1:$AVGQ title "average queue length ($KEY)" with lines
_EOF_


