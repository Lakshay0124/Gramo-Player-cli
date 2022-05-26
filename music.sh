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
        case $song_req in
                mass-download)
                chmod +x mass-downloader.sh
                ./mass-downloader.sh
                ;;
                *)
                echo "Downloading Please Wait!"
                echo "$song_req" > req.txt
                link=$(curl -s https://vid.puffyan.us/search?q=$(sed 's/ /+/g' req.txt) | awk '/Watch/{print}' | head -n 1 | awk '{print $5}' |
sed 's/href="//' | sed 's/">//')
                yt-dlp --extract-audio --audio-format mp3 -o "$song_req.%(ext)s" "$link" > /dev/null 2>&1
                rm *.txt > /dev/null 2>&1
                printf "Success!\n"
                sleep 0.1
                ;;
        esac

        if [[ -f $song_req.mp3 ]]; then
                echo "press enter to save the default one"
                printf "name of song to save: "
                read nameyy
                mv "$song_req.mp3" songs/
                cd songs/
                if [[ "$nameyy" == "" ]]; then
                        echo "$song_req.mp3" > name.txt
                        nameyy=$(sed s'/ /-/g' name.txt)
                        mv "$song_req.mp3" "$nameyy" > /dev/null 2>&1
                        rm name.txt
                        cd ..

                else
                        echo $nameyy > name.txt
                        nameyy=$(sed s'/ /-/g' name.txt)
                        mv "$song_req.mp3" "$nameyy.mp3" > /dev/null 2>&1
                        rm *.txt


                fi


        fi


elif [[ $decision == "2" ]]; then
        cd songs/
        ls
        printf "which song to play: "
        read query
        check=$(echo "$query" | awk '{print $1,$2}')
        case "$query" in
                "shuffle")
                        cd ..
                        chmod +x shuffler.sh
                        ./shuffler.sh
                        ;;


                "$check")
                        while :
                                do
                                        echo $query > ques.txt
                                        name="$(sed s'/loop.//' ques.txt)"
                                        rm *.txt
                                        mpv "$name.mp3"

                                done

                        ;;

                *)

                        mpv "$query.mp3"
                        ;;
esac
fi

