#!/bin/bash

# Default directory: ./data

for fname in training/label_2/*.txt 
do 
    count=$(cat $fname | grep 'Pedestrian\|Person\|Cyclist' | wc -l)
    if [ $count -eq 0 ]
    then
        prefix=$(echo "$fname" | grep -o '[0-9]*\.' | grep -o '[0-9]*')
        rm "training/velodyne/$prefix.bin"
        rm "training/calib/$prefix.txt"
        rm "$fname"
    else 
        cat $fname | grep 'Person\|Pedestrian\|Cyclist\|DontCare\|Misc' > abc.tmp 
        cat abc.tmp > $fname
    fi
done 

rm abc.tmp
