#!/bin/bash
x="$1"

jam=`awk -v x=$x -F ";" 'FNR>1 {if(match($1, x))print $2}' log.csv`

#alphabet1=`expr $jam + 97`

alphabetBeforeValue=`expr $jam + 97`

alphabetBefore=`awk -v x=$alphabetBeforeValue 'BEGIN{printf "%c",x}'`
echo $alphabetBefore

alphabetAfterValue=`expr $alphabetBeforeValue - 1`

alphabetAfter=`awk -v x=$alphabetAfterValue 'BEGIN{printf "%c",x}'`
echo $alphabetAkhir
echo $x

newName=`echo $x | tr '['$alphabetBefore'-za-'$alphabetAfter']' '[a-z]'`

echo "$newName"
mv $x.txt $newName.txt
