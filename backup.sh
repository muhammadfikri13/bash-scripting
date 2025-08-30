#!/bin/bash

SOURCE="/home/fikri"
DEST="/home/backups"
DATE=$(date +"%Y%m%d_%H%M%S")
FILENAME="backup-$DATE.tar.gz"

#  Make sure backup folder exist
mkdir -p $DEST

# Create backup from home/fikri to home/backups
tar -czvf $DEST/$FILENAME $SOURCE

# Delete previous backup (>7 days)
find $DEST -type f -name "backup-*.tar.gz" -mtime +7 -exec rm {} \;

echo "Backup complete! File : $DEST/$FILENAME"
