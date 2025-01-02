#!/usr/bin/perl -p

# Reads the output of `S_TIME_FORMAT=ISO iostat -t ...` from STDIN, and spits it 
# back out line by line -- adding a prefix to each line based on the las timestamp line seen.
# (using a slightly different output time format based on what the gnuplot scripts currently expect)
#
# NOTE: The output timeformat discards timezone info, which gnuplot implicitly assumes is UTC
# So you are strongly encouraged to use the `TZ=UTC` env variable when running iostat as well

if (/^(\d{4}-\d{2}-\d{2})T(\d{2}:\d{2}:\d{2})\+\d{4}$/) {
    $last_ts = "$1 $2 ";
}
$_ = "${last_ts}${_}";
