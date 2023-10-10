#!/bin/bash
export GZIP=-9
BACKUP_DIR="/backup200g/folder_backup/daily"
DATE=$(date "+%Y%m%d%H%M")
BACKUPFILE="${BACKUP_DIR}/files.${DATE}.tgz"
RETENTION=14
ret_time=$(date -d"${RETENTION} days ago" +%s)

echo "Performing backup"
tar -cvzvf ${BACKUPFILE} /home/httpd /home/eis

echo "Removing files older than ${RETENTION} days..."

currentdate=$(date +%s)
echo $currentdate
for FILENAME in ${BACKUP_DIR}/files.*; do
 	echo $FILENAME
        extracted_date=$(echo $FILENAME | tr "[_\.]" " "|cut -d " " -f3)
	echo $extracted_date
	split_date=$(echo ${extracted_date} |sed "s/.\{8\}/& /g")
	echo $split_date
	backup_date_sec=$(date -d"${split_date}" +%s)
	backup_diff=$(expr $currentdate - $backup_date_sec)
	days=$(expr $backup_diff / 86400) 
	if [ $backup_date_sec -lt $ret_time ]; then
                echo "$FILENAME was created $days days ago, (older than $RETENTION days) and will be deleted"
                rm -rf $FILENAME
        else 
                echo "$FILENAME was created $days days ago"
	fi
done

