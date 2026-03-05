#!/bin/bash
BACKUP_DIR="/backups"
SOURCE_DIR="/home/anandu"
DATE=$(date +%Y%m%d_%H%M%S)
sudo tar -czf $BACKUP_DIR/backup_$DATE.tar.gz $SOURCE_DIR
echo "Backup completed: backup_$DATE.tar.gz"
