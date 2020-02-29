#!/bin/bash
a=$(echo $1 | tr -d [:digit:])
p = "`< /dev/urandom tr -dc A-Z | head -c5`"
q = "`< /dev/urandom tr -dc a-z | head -c5`"
r = "`< /dev/urandom tr -dc 0-9 | head -c5`"
s = "`< /dev/urandom tr -dc A-Za-z0-9 | head -c13`"
pw = $p$q$r$s
echo -e $pw > $a.txt
b=`date +%H`
echo "$a;$b" >> log.csv
