#!/bin/sh

download()
{
	#songs="$(head -n $1 songs)"
        echo "Downloading Please Wait!" 
	name_song="$(cat "$(cat %Lks.txt)" | head -n $1 | tail -n 1)" 
	echo "$name_song" > "$1_req.txt"
	
	#link variable fetches link of video like fKopy74weus 
	
	link=$(curl -s https://vid.puffyan.us/search?q=$(sed 's/ /+/g' "$1_req.txt") | awk '/Watch/{print}' | head -n 1 | awk '{print $5}' | sed 's/href="//' | sed 's/">//' | cut -c 33-)

	audio_file="https://vid.puffyan.us/latest_version?id=$link&itag=139&local=true"

		#this makes link into its audio form like https://vid.puffyan.us/embed/fKopy74weus?listen=1' 
	curl -L -o "$(cat "$(cat %Lks.txt)" | head -n "$1" | tail -n 1).m4a" "$audio_file" 
        name_without_space=$(printf "$name_song" | sed s'/ /-/g')
	mv "$name_song.m4a" "$name_without_space.m4a" > /dev/null 2>&1 && mv "$name_without_space.m4a" "songs/"
	printf "Success!\n"
	
}
no="$(wc -l "$(cat %Lks.txt)" | awk '{print $1}')"
i=0


while [ "$i" -lt "$no" ];
do
	i=$((i+1))
	download $i &
done
wait

mv *.m4a songs > /dev/null 2>&1
rm *_req.txt > /dev/null 2>&1 ; rm %Lks.txt > /dev/null 2>&1
