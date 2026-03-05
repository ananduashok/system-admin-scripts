#!/bin/bash
echo "=== Recent User Logins ==="
last | head -10
echo ""
echo "=== Recent Sudo Commands ==="
sudo grep "sudo:" /var/log/auth.log | tail -5
