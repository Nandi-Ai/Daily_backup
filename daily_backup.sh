#!/bin/bash

#Define variables
backup_dir="/home/yoni-golan/Desktop/backups"
date_time=$(date +"%Y%m%d-%H%M%S")
backup_file="$backup_dir/backup_$date_time.tar.gz"
source_dir=$1

#Create the backup directory if it doesn't exist
if [ ! -d "$backup_dir" ]; then
mkdir -p "$backup_dir"
fi

#Create the backup
tar -czf "$backup_file" "$source_dir"

#Check if the backup was successful
if [ $? -eq 0 ]; then
echo "Backup of $source_dir completed successfully!"
else
echo "Backup of $source_dir failed!"
fi

old_files=$(find "$backup_dir" -type f -mtime +14)

if [ -n "$old_files" ]; then
    echo "The following files have not been modified in the last 14 days:"
    echo "$old_files"

    echo "Do you want to delete these files? (y/n)"
    read -r response
    if [ "$response" = "y" ]; then
        echo "Deleting files..."
        echo "$old_files" | xargs rm -f
        echo "Files deleted."
    else
        echo "No files were deleted."
    fi

else
    echo "There are no files in $backup_dir that haven't been modified in the last 14 days."
fi

(crontab -l ; echo "0 0 * * * /home/yoni-golan/daily_backup.sh $source_dir") | crontab -


# * * * * * command_to_run
# - - - - -
# | | | | |
# | | | | ----- Day of the week (0 - 6) (Sunday = 0 or 7)
# | | | ------- Month (1 - 12)
# | | --------- Day of the month (1 - 31)
# | ----------- Hour (0 - 23)
# ------------- Minute (0 - 59)

