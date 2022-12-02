#!/bin/sh

download()
{
	#songs="$(head -n $1 songs)"
        echo "Downloading Please Wait!"
        echo ""$(cat songs.txt)" | head -n $1 | tail -n 1)" > "$1_req.txt"
	 #link variable fetches link of video like fKopy74weus 
	
	link=$(curl -s https://vid.puffyan.us/search?q=$(sed 's/ /+/g' "$1_req.txt") | awk '/Watch/{print}' | head -n 1 | awk '{print $5}' | sed 's/href="//' | sed 's/">//' | cut -c 33-)

	audio_file="https://vid.puffyan.us/latest_version?id=$link&itag=139&local=true"

		#this makes link into its audio form like https://vid.puffyan.us/embed/fKopy74weus?listen=1' 
	curl -L -o "$(cat songs.txt | head -n "$1" | tail -n 1).m4a" "$audio_file" 
                
	printf "Success!\n"
	
}
no="$(wc -l "$(cat songs.txt)" | awk '{print $1}')"
i=0


while [ "$i" -lt "$no" ];
do
	i=$((i+1))
	download $i &
done
wait
rm *.txt
