#!/bin/bash
#
# iostat grapher. Note, in the following line the data
# points will start at field $4 for rrqm/s
#
# 2015-10-29 16:31:08 Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %uti#
# 2015-10-29 16:31:08 sda               0.00     2.60    0.00    3.40     0.00    22.40    13.18     0.00    0.18   0.18   0.06

echo "usage: $0 <device-filtered-iostat.log> <disk name> <out.png>"
echo "procesing $1 for device $2, plotting $3"



gnuplot <<_EOF_
set terminal png
set output "$3"
set title "$2: Queue Size"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%H:%M\n%d/%m"
set xtics nomirror scale 3,2
set ylabel "Requests"
set samples 10
plot "$1" using 1:11 title "average queue length (avgqu-sz)" with lines
_EOF_


