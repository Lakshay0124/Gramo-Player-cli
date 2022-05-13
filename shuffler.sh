#!/bin/bash

cd songs/
printf  "$(ls)\n" > songs.txt
no=$(wc -l songs.txt | awk '{print $1}')
i=0
while [ $i -lt $no ]
do

	i=$((i+1))
        name=$(sed -n $i,0p songs.txt)
        echo $name > name.txt
        mpv "$name"
                        #rm *.txt

		
done

