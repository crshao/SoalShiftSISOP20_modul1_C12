#!/bin/bash
x=$(echo $1 | tr -d [:digit:])
< /dev/urandom tr -dc A-Za-z0-9 | head -c28 > $x.txt
y=`date +%H`
echo "$x;$y" >> log.csv 
