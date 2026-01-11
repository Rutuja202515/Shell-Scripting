#!/bin/bash

<< TASK
This is script for backup with 5 day rotation.
Usage :
./backup.sh <Path to your Source> <Path to backup folder>

TASK

function display_usage {
	echo "./backup.sh <Path to your Source> <Path to backup folder>"
}

if [ $# -eq 0 ]; then 
	display_usage
fi

Sourec_Dir=$1
timestamp=$(date '+%Y-%m-%d-%-H-%S')
Backup_Dir=$2

function create_backup {
	zip -r "${Backup_Dir}/backup_${timestamp}.zip" "${Source_Dir}" > /dev/null
if [ $? = 0 ]; then
echo "backup generated successfully for ${timestamp}"
fi
}

function perform_rotation {
	backups=($(ls -t "{backup_dir}/backup_*.zip"))

	if [ "${#backups[@]}" -gt 5 ]; then
		echo "Performing rotation for 5 days"

		backups_to_remove=("${backups[@]:5}")

		for backup in "${backups_to_remove[@]}";
		do 
			rm -f ${backup}
		done
	fi


}

#Calling function

create_backup
perform_rotation

#./backup.sh /root/Shell-Scripting/dev /root/Shell-Scripting/Backups
#create crontab job
#crontab -e add the entry : eg . * * * * * (crontab guru) bash /root/Shell-Scripting/backup.sh /root/Shell-Scripting/dev /root/Shell-Scripting/Backups
#old 5 days backup and data older than 5 days will be removed
