#!/bin/bash

source $(dirname $0)/_utils.sh

SVCTM=$(required_header_index 'svctm' "$4")
AWAIT=$(header_index 'await' "$4")
if [ ! -z "$AWAIT" ]; then

  gnuplot <<_EOF_
set terminal png
set output "$3"
set title "$2: Service time"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%H:%M\n%d/%m"
set xtics nomirror scale 3,2
set ylabel "Miliseconds"
set samples 10
plot "$1" using 1:$AWAIT title "average wait time in ms (await)" with lines, \
"$1" using 1:$SVCTM title "average service time in ms (svctm)" with lines
_EOF_

  exit
fi

RAWAIT=$(header_index 'r_await' "$4")
WAWAIT=$(header_index 'w_await' "$4")

gnuplot <<_EOF_
set terminal png
set output "$3"
set title "$2: Service time"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%H:%M\n%d/%m"
set xtics nomirror scale 3,2
set ylabel "Miliseconds"
set samples 10
plot "$1" using 1:$RAWAIT title "average read wait time in ms (r_await)" with lines, \
"$1" using 1:$WAWAIT title "average write wait time in ms (w_await)" with lines, \
"$1" using 1:$SVCTM title "average service time in ms (svctm)" with lines
_EOF_
