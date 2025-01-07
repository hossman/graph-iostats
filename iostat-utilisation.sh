#!/bin/bash


source $(dirname $0)/_utils.sh
UTIL=$(required_header_index '%util' "$4")

gnuplot <<_EOF_
set terminal png size 1280,960
set output "$3"
set title "$2: Utilisation"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%H:%M\n%d/%m"
set xtics nomirror scale 3,2
set ylabel "Percent"
set samples 10
plot "$1" using 1:$UTIL title "utilisation (%util)" with lines
_EOF_


