#!/bin/bash

function print_help {
	
	printf 'creates a tar.gz archive of <directory> in $HOME/Scrivania/backups'
	printf " appending the current date to the filename\n "
	echo "usage:"
	echo "./backupit.sh <directory>"
}


function create_archive {

	folder=$1
	current_date=$2
	full_path=$3
	backup_dir=$HOME/Scrivania/backups
	end_file=${folder}_${current_date}.tar.gz

	#echo -e "\nfolder: $folder"
	#echo "current_date: $current_date"
	#echo "full_path: $full_path"
	#echo "backup_dir: $backup dir"
	#echo "end_file: $end_file" *
	

	file_exists=`ls $backup_dir | grep $end_file`
		if [ -z $file_exists ]; then
			echo "The file doesn't exist, creting the archive..."
			cd ${full_path}
			tar cfz ${backup_dir}/${end_file} *
			echo "aaaa"
		else
			printf "The file exists, do you want to overwrithe it? [Y/n] "
			read confirm
				if [ "$confirm" == "y" ]; then
					echo "Overwrithing..."
					cd ${full_path}
					tar cfz ${backup_dir}/${end_file} *
				elif [ "$confirm" == "n" ]; then
					echo "Quitting"
				else
					echo "quitting"
				fi
		fi
}

	if [ -d "$1" ]; then
		folder=$1
		full_path=`readlink -f $1`
		current_date=`date +"%Y%m%d_%H%M"`
		
		if [ ! -d "$HOME/Scrivania/backups" ]; then
			echo "$HOME/Scrivania/backups directory doesn't exist , creating it..."
			mkdir $HOME/Scrivania/backups
		fi
	echo "Compressing $full_path into archive $HOME/Scrivania/backups/${folder}_${current_date}.tar.gz..."
	create_archive $folder $current_date $full_path
	
	elif [ -z "$1" ]; then
		print_help
	else
		echo -e "Not a directory"
		print_help
	fi
