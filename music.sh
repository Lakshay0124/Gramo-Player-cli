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
	read a
	echo $a > song_needy.txt
	sed 's/ /+/g' song_needy.txt > song_needy1.txt
	song_req=$(cat song_needy1.txt) 
	curl -s https://invidious.kavin.rocks/search?q=$song_req > song_qr.txt  #curl it using invidious
	sed '240!d' song_qr.txt > song_final.txt    #all sed command filter everything and make the link to use for youtube-dl
	sed 's/"//g' song_final.txt > son_output.txt 
	sed 's/<//g' son_output.txt > song_out.txt  
	sed 's/>//' son_output.txt > song_out.txt   
	cat song_out.txt | cut -c 32- > /dev/null 2>&1      #cut first 32 chars from the link
	yt-dlp --extract-audio --audio-format mp3 -o "$song_req.%(ext)s.%(ext)s" $(cat song_out.txt | cut -c 32-) > /dev/null 2>&1
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


