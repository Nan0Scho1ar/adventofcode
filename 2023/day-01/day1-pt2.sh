#!/usr/bin/env sh

LEGAL='\d|one|two|three|four|five|six|seven|eight|nine'
INTIFY='s/one/1/g; s/two/2/g; s/three/3/g; s/four/4/g; s/five/5/g; s/six/6/g; s/seven/7/g; s/eight/8/g; s/nine/9/g;'

perl -pe "s/^.*?(\d).*(\d).*$|^.*(\d).*$/\1\2\3\3/" day-01/input-2023-01.txt | perl -nle '$sum += $_; END { print "Day 1: $sum" }'
perl -pe "s/^.*?($LEGAL).*($LEGAL).*$|^.*($LEGAL).*$/\1\2\3\3/; $INTIFY" day-01/input-2023-01.txt | perl -nle '$sum += $_; END { print "Day 2: $sum" }'
