#!/bin/bash

folder=songs
if [[ -e $folder ]]; then
        :
else
        mkdir songs
fi
sleep 0.1
echo "(press 1 to DOWNLOAD a song and press 2 to PLAY a song!)"
printf "What you want to do: "
read decision
if [[ $decision == "1" ]]; then
        printf "Song Name: "
        read song_req 
        echo "Downloading Please Wait!"
        echo "$song_req song" > req.txt
        link=$(curl -s https://vid.puffyan.us/search?q=$(sed 's/ /+/g' req.txt) | awk '/Watch/{print}' | head -n 1 | awk '{print $5}' | sed 's/href="//' | sed 's/">//')
        yt-dlp --extract-audio --audio-format mp3 -o "$song_req.%(ext)s" "$link" > /dev/null 2>&1
        rm *.txt
        printf "Success!\n"
        sleep 0.1

        if [[ -f $song_req.mp3 ]]; then
                echo "press enter to save the default one"
                printf "name of song to save: "
                read nameyy
                mv "$song_req.mp3" songs/
                cd songs/
                if [[ "$nameyy" == "" ]]; then
                        cd ..
                else
                        mv "$song_req.mp3" "$nameyy.mp3" > /dev/null 2>&1

                fi
        else

                printf "error 404\n"

        fi


elif [[ $decision == "2" ]]; then 
        cd songs/
        ls
        printf "which song to play: "
        read query
        if [[ -f "$query.mp3" ]]; then
                mpv "$query.mp3"

        elif [[ "$query"=="loop $query" ]]; 
        then
                while :
                do

                        mpv $(echo "$query.mp3" | awk '{print $2}')
                done
