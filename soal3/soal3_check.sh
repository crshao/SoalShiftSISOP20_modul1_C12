#!/bin/bash

for ((i=1 ; $i<=28 ; i++))
do
	wget -O "pdkt_kusuma_$i" "https://loremflickr.com/320/240/cat" -a "wget.log"
done

cat wget.log | grep Location: > location.log


mkdir duplicate 
mkdir kenangan

awk '{ printf("%s\t%02d\n", $2, i + 1); i += 1 }' location.log | sort -n -k1 > file.log
temp=$(ls duplicate/ |awk -F '_' '{print $2}' | sort -rn | head -1)
temp1=$(ls kenangan/ |awk -F '_' '{print $2}' | sort -rn | head -1)
awk -F '\t' -v temp=$temp -v temp1=$temp1 '{ i = $2+0; 
		if( L != $1 ){
			  L = $1; 
			  move = " mv pdkt_kusuma_" i " kenangan/kenangan_" count2+1 ; count2++; }
				system(move); } 
  		else if( L == $1 ) { 
			
			move = " mv pdkt_kusuma_" i " duplicate/duplicate_" count1+1; count1++; } ' file.log 

for name in *.log; 
do 
	mv "$name" "${name%.log}.log.bak"
done 
