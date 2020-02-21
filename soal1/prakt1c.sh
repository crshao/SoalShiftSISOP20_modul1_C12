#!/bin/bash

awk -F'\t' '{if($11 == "Illinois"|| $11 == "Texas") a[$17]+=$21;}END{for(x=0;x<10;x++) {{bool=1;for(i in a)
{
 if(bool==1){min=a[i];bool=0}
 if(min>a[i]){min=a[i];prod=i}
 
} print prod; delete a[prod]}
}}' Sample-Superstore.tsv
