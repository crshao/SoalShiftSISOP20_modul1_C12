#!/bin/bash

for (( i=1; i<29; i++ ))
do
  wget -O /home/hao/Documents/SistemOperasi/soal3/pdkt_kusuma_$i https://loremflickr.com/320/240/cat -a "wget.log";
done
