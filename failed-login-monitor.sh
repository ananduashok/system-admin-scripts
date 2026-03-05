#!/bin/bash
sudo echo "Failed Login Attempts:"
sudo grep "Failed password" /var/log/auth.log | wc -l
sudo echo ""
sudo echo "Top 10 IP addresses with failed attempts:"
sudo grep "Failed password" /var/log/auth.log | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sort | uniq -c | sort -rn | head -10
