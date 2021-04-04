#!/bin/bash

# this shell can use only for linux mint
# but you can change path of directory and something else to work for your distro

DIR_PHOTOS=/usr/share/backgrounds/linuxmint/
MAIN_PHOTO=/usr/share/backgrounds/linuxmint/default_background.jpg

while [ true ]
do
	# ls -1 list -> list items each one in one line and sort -R sort it randomly
	# shuf -n 1 select first number of this file 
	FILE_SELECTED=$(ls -1 $DIR_PHOTOS | sort -R | shuf -n 1)

	# this file must not be choosen because we want change it further
	if [ $FILE_SELECTED != "default_background.jpg" ]
	then
		break
	fi	
done

sudo unlink $MAIN_PHOTO

# create a symbolink link for default_background...
sudo ln -s /usr/share/backgrounds/linuxmint/$FILE_SELECTED /usr/share/backgrounds/linuxmint/default_background.jpg



