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
        curl -s https://invidious.snopyta.org/search?q=$song_req > data0.txt
        awk '/Watch/{print}' data0.txt  | head -n 1 > data1.txt
        cat data1.txt | cut -c 43- > data3.txt
        yt-dlp --extract-audio --audio-format mp3 -o "$song_req.%(ext)s.%(ext)s" $(cat data3.txt | sed 's/>//' | sed 's/"//'
        )> /dev/null 2>&1
     	rm *.txt
	printf "Success!\n"	
	sleep 0.1

	if [[ -f $song_req.webm.mp3 ]]; then
		nameyy=$(ls $song_req.webm.mp3 | sed 's/+/ /g')
		mv $song_req.webm.mp3 songs/
		cd songs/
		mv "$song_req.webm.mp3" "$nameyy" > /dev/null 2>&1
		cd ..


	elif [[ -f $song_req.m4a.mp3 ]]; then
		nameyy=$(ls $song_req.m4a.mp3 | sed 's/+/ /g')
		mv $song_req.m4a.mp3 songs/
		cd songs/
		mv "$song_req.m4a.mp3" "$nameyy" > /dev/null 2>&1
		cd ..

	else

		printf "error 404\n"
	
	fi


elif [[ $1 == "play" ]]; then
	cd songs/
	ls
	printf "(just its name no extension)\n"
	printf "which song to play: "
	read query

	if [[ -f "$query.webm.mp3" ]]; then
		mpv "$query.webm.mp3"

	elif [[ -f "$query.m4a.mp3" ]]; then
		mpv "$query.m4a.mp3"
	
	else
		printf "error 404\n"
	
	fi

fi



