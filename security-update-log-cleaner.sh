#!/bin/bash
# Update system
sudo apt update && sudo apt upgrade -y
# Clean old logs
sudo journalctl --vacuum-time=30d
# Clean package cache
sudo apt autoclean && sudo apt autoremove -y
echo "System maintenance completed"
