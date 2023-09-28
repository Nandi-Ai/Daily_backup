# Daily_backup

This bash script allows you to create backups of a specified directory using the tar command. The script creates a compressed tarball (.tar.gz) of the source directory and saves it in a designated backup directory with a timestamp in the file name.

## Usage

To use the script, follow these steps:

1. Ensure that the script file has execute permissions. If not, run the following command:  chmod +x daily_backup.sh

2. Run the script with the source directory as the argument. For example, to backup the directory "/path/to/source/directory", execute: ./daily_backup.sh /path/to/source/directory

3. The script will create a backup directory (if it doesn't exist) at "/home/yoni-golan/Desktop/backups" (you can change this location by modifying the `backup_dir` variable in the script).

4. After execution, a compressed backup file named "backup_YYYYMMDD-HHMMSS.tar.gz" will be created in the backup directory, where "YYYYMMDD" represents the current date and "HHMMSS" represents the current time.

5. The script will also check the exit status of the backup creation. If the backup is successful, it will display the message "Backup of [source directory] completed successfully!" Otherwise, it will display "Backup of [source directory] failed!"


## Automating Daily Backups

To schedule daily backups using the script, you can utilize the cron utility. The provided script includes a line that adds the backup command to the crontab.

The script will be scheduled to run at midnight (0:00) every day with the specified source directory as the argument. If you wish to modify the schedule, adjust the cron expression in the script.

To add the scheduled backup task to the crontab, follow these steps:
1. Open a terminal and execute the following command:   crontab -e
2. In the crontab file, the text editor will open. Add the following line at the end:    0 0 * * * /path/to/script/daily_backup.sh /path/to/source/directory

Replace "/path/to/script/daily_backup.sh" with the actual path to the script file and "/path/to/source/directory" with the actual path to the source directory.

3. Save the file and exit the text editor.

Now, the script will run automatically at the specified time, creating daily backups of the source directory.
