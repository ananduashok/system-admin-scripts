#!/bin/bash
HOSTS=("8.8.8.8" "1.1.1.1" "google.com")
for host in "${HOSTS[@]}"; do
    if ping -c 1 $host &> /dev/null; then
        echo "✓ $host is reachable"
    else
        echo "✗ $host is unreachable"
    fi
done
