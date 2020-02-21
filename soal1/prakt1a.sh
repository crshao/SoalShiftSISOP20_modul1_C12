#!/bin/bash

awk -F '\t' '{if($13 != "Region") a[$13]+=$21;}END{bool=1;for(i in a)
{
 if(bool==1){min=a[i];bool=0}
 if(min>a[i]){min=a[i];reg=i}
 
} print reg

}' Sample-Superstore.tsv





#print i,a[i];
