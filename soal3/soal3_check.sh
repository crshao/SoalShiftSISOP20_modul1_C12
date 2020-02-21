#!/bin/bash

kcount=$(ls -l kenangan | wc -l)
dcount=$(ls -l duplicate | wc -l)

for ((i=1 ; $i<=28 ; i++))
do
	wget -O "pdkt_kusuma_$i" "https://loremflickr.com/320/240/cat" -a "wget.log"
done

for ((i=1 ; $i<=28 ; i++))
do
	for ((j=$((i+1)) ; $j<=28 ; j++))
	do
		value=$(compare -metric AE pdkt_kusuma_$i pdkt_kusuma_$j null: 2>&1)
		if [[ $value == 0 ]]
		then
			mv pdkt_kusuma_$j duplicate/duplicate_$dcount
			dcount=$((dcount+1))
		fi
	done
done

for ((i=1 ; $i<=28 ; i++))
do
	if [[ -f pdkt_kusuma_$i ]]
	then
		mv pdkt_kusuma_$i kenangan/kenangan_$kcount
		kcount=$((kcount+1))
	fi
done

cp wget.log wget.log.bak
