#!/bin/bash

source $(dirname $0)/_utils.sh

KEY='avgrq-sz'
EXT="Sectors"
AVG=$(header_index "$KEY" "$4")
if [ -z "$AVG" ]; then
  KEY='areq-sz'
  AVG=$(header_index "$KEY" "$4")
  EXT="kilobytes"
fi

if [ ! -z "$AVG" ]; then
  
  gnuplot <<_EOF_
set terminal png
set output "$3"
set title "$2: Request Sizes$EXT"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%H:%M\n%d/%m"
set xtics nomirror scale 3,2
set ylabel "Requests $EXT"
set samples 10
plot "$1" using 1:$AVG title "average request sizes $EXT ($KEY)" with lines
_EOF_

  exit
fi

READ=$(required_header_index 'rareq-sz' "$4")
WRITE=$(required_header_index 'wareq-sz' "$4")

gnuplot <<_EOF_
set terminal png
set output "$3"
set title "$2: Request Sizes"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%H:%M\n%d/%m"
set xtics nomirror scale 3,2
set ylabel "Kilobytes"
set samples 10
plot "$1" using 1:$READ title "average read request sizes (rareq-sz)" with lines, \
"$1" using 1:$WRITE title "average write request sizes (qareq-sz)" with lines
_EOF_
