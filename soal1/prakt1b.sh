#!/bin/bash

awk -F'\t' '{if($13 == "Central") a[$11]+=$21;}END{bool=1;for(i in a)
{
 if(bool==1){min1=a[i];min2=min1;bool=0}
 if(min>a[i]){min2=min1;min1=a[i];state2=state1;state1=i}
 
} print state1, state2

}' Sample-Superstore.tsv



#print i,a[i];
