#!/bin/bash

# a script to download sth from terminal in linux
# NOTE: you need to have aria2 download manager

clear
get_minutes(){
	local hour="$1"
	local minutes="$2"
	hour=${hour/0/}
	minutes=${minutes/0/}

	if [ -z "$hour" ];then
		minutes="0"
	fi
	if [ -z "$minutes" ];then
		hour="0"
	fi
		echo "$(( hour * 60 + minutes ))"	
}

get_time(){
	local Time="$( date +%H:%M )"
	echo "$( get_minutes $Time )"
}

start_download(){
	local system_time="$( get_time )"
	local user_time="$( get_minutes $stime )"
	while [ "$system_time" != "$user_time" ];do echo "$(( system_time - user_time )) minutes until start"
		sleep 20	
	done
}

download_link(){
	if [ -d "$path" ];then
		aria2c -c -x 16 -d "$path" "$li"
	else
		aria2c -c -x 16	"$li"
	fi	
	echo "1" > /tmp/"$random_name".txt 
}

end_download(){
	local system_time="$( get_time )"
	local user_time="$( get_minutes $etime )"	
	while [ "system_time" != "$user_time" ];do
		sleep 20
		if [ -f /tmp/"$random_name".txt ];then
			break
		fi
	done	
	if [ ! -f /tmp/"$random_name".txt ];then
		killall	aria2c 
	fi
}

IFS=":"
random_name="$RANDOM"

while getopts "s:e:l:d:v" options;do
	case "$options" in
		s)
			stime="$OPTARG"
			;;
		e)
			etime="$OPTARG"
			;;
		l)
			li="$OPTARG"
			if [ -z "$li" ];then
				echo "a link must be exists!"
				exit
			fi
			;;
		d)
			path="$OPTARG"
			;;
		v)
			./about.sh		
			;;
	esac
done

if [ ! -z "$stime" ];then
		start_download $stime
fi
if [ ! -z "$etime" ];then
		download_link $li &
		end_download $etime
else
		download_link $li
fi

li=${li##*/} # this line remove path from file 

zenity --notification --text "$li downloaded!!" # show notification that your download is finished
rm /tmp/$random_name.txt
