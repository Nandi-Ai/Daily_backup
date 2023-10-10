#!/bin/bash
###############################################################################


# define variables
BACKUP_DIR="$HOME/backup"
DATE_TIME=$(date +"%Y%m%d-%H%M%S")
BACKUP_FILE="$BACKUP_DIR/backup_$DATE_TIME.tar.gz"
SOURCE=$1


# functions
# ---------
# Function to remove old backups
remove_old_backups() {
    find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +7 -exec rm {} \;
}


# load environments and parameter
# -------------------------------
# Check if the script is run with the -r parameter to remove old backups regardless of time of day
if [ "$1" = "-r" ]; then
  remove_old_backups
  exit 0
fi

# Check if source directory argument is provided
if [ -z "$SOURCE" ]; then
    echo "Usage: $0 <source_directory>"
    exit 1
fi

# Create the backup directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "Directory backup was created"
else
    echo "Directory exists"
fi

# Create the backup
tar -czf "$BACKUP_FILE" "$SOURCE"

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Backup completed successfully: $BACKUP_FILE"
else
    echo "Backup failed"
fi


