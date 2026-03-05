#!/bin/bash
# Remove old temp files (older than 30 days)
sudo find /tmp -type f -mtime +30 -delete
echo "Deleted old temp files(older than 30 days)"
echo "....."
echo "..."
# Remove old log files (older than 90 days)
sudo find /var/log -type f -name "*.log" -mtime +90 -delete
echo "Deleted old log files(older than 90 days)"
echo "......"
echo "..."
# Clean apt cache
sudo apt clean
echo "Cleanup completed"
