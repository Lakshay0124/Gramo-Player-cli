#!/bin/bash

folder=songs
if [[ -e $folder ]]; then
	echo ""
else
	mkdir songs
fi
sleep 1

if [[ $1 == "-d" ]]; then
	echo "(without any space)"
	printf "Song Name: "
	read a
	echo $a > song_needy.txt
	song_req=$(cat song_needy.txt) 
	curl -s https://invidious.kavin.rocks/search?q=$song_req > song_qr.txt  #curl it using invidious
	sed '240!d' song_qr.txt > song_final.txt    #all sed command filter everything and make the link to use for youtube-dl
	sed 's/"//g' song_final.txt > son_output.txt 
	sed 's/<//g' son_output.txt > song_out.txt  
	sed 's/>//' son_output.txt > song_out.txt   
	cat song_out.txt | cut -c 32-       #cut first 32 chars from the link
	youtube-dl --extract-audio --audio-format mp3 -o "$song_req.%(ext)s.%(ext)s" $(cat song_out.txt | cut -c 32-)
	sleep 1
	if [[ -f $song_req.webm.mp3 ]]; then
		mv $song_req.webm.mp3 songs

	elif [[ -f $song_req.m4a.mp3 ]]; then
		mv $song_req.m4a.mp3 songs
	
	else
		echo "error 404\n"
	
	fi


elif [[ $1 == "-p" ]]; then
	cd songs/
	sleep 1 
	ls
	echo "(just its name no extension)"
	printf "which song to play: "
	read query

	if [[ -f "$query.webm.mp3" ]]; then
		mpv "$query.webm.mp3"

	elif [[ -f "$query.m4a.mp3" ]]; then
		mpv "$query.m4a.mp3"
	
	else
		printf "error 404\n"
	
	fi

fi #done
