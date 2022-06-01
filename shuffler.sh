#!/bin/sh
cd songs/
printf  "$(ls)\n" > songs.txt
no=$(wc -l songs.txt | awk '{print $1}')
i=0
while [ $i -lt $no ]
do

        i=$((i+1))
        rand=$(($RANDOM%$no+1))
        name=$(cat songs.txt | head -n $rand | tail -n 1)
        mpv "$name"
done

rm *.txt
