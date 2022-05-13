#!/bin/bash
printf "enter name of file to download songs from: "
read file
no=$(wc -l "$file" | awk '{print $1}')
i=0
while [ $i -lt $no ]
do
	i=$((i+1))
        name=$(sed -n $i,0p "$file")
	song_req="$name"
        echo "Downloading Please Wait!"
        echo "$song_req" > req.txt
        link=$(curl -s https://vid.puffyan.us/search?q=$(sed 's/ /+/g' req.txt) | awk '/Watch/{print}' | head -n 1 | awk '{print $5}' | sed 's/href="//' | sed 's/">//')
        yt-dlp --extract-audio --audio-format mp3 -o "$song_req.%(ext)s" "$link" > /dev/null 2>&1
        printf "Success!\n"
        sleep 0.1

        if [[ -f" $song_req.mp3" ]]; then
                mv "$song_req.mp3" songs/
      

        else
                printf "error 404\n"
	fi
              		
done
rm *.txt

