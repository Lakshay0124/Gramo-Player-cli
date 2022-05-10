#!/bin/bash

folder=songs
if [[ -e $folder ]]; then
        :
else
        mkdir songs
fi
sleep 0.1


if [[ $1 == "download" ]]; then
        printf "Song Name: "
        read song_req 
        echo "Downloading Please Wait!"
        echo "$song_req" > req.txt
        sed 's/ /+/g' req.txt > req1.txt
        curl -s https://invidious.snopyta.org/search?q=$(cat req1.txt) > data0.txt
        awk '/Watch/{print}' data0.txt  | head -n 1 > data1.txt
        cat data1.txt | cut -c 43- > data3.txt
        yt-dlp --extract-audio --audio-format mp3 -o "$song_req.%(ext)s" $(cat data3.txt | sed 's/>//' | sed 's/"//'
        )> /dev/null 2>&1
        rm *.txt
        printf "Success!\n"
        sleep 0.1

        if [[ -f $song_req.mp3 ]]; then
                ffmpeg -i "$song_req.mp3" "$song_req.wav" > /dev/null 2>&1;rm "$song_req.mp3"
                printf "name of song to save: "
                read nameyy
                mv "$song_req.wav" songs/
                cd songs/
                mv "$song_req.wav" "$nameyy.wav" > /dev/null 2>&1
                cd ..

        else

                printf "error 404\n"

        fi


elif [[ $1 == "play" ]]; then
        cd songs/
        ls
        printf "which song to play: "
        read query
        if [[ -f "$query.wav" ]]; then
                paplay "$query.wav"

        else
                printf "error 404\n"


        fi


fi

