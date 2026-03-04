#!/bin/bash

function explain {
    echo "This script checks the CPU, memory, and disk usage of the system."
    echo "Usage:"
    echo "  --cpu      : Displays current CPU utilization."
    echo "  --memory   : Displays current memory usage."
    echo "  --disk     : Displays current disk space usage."
    echo "  --explain  : Displays this help information."
    exit 0
}

if [[ "$1" == "--explain" ]]; then
    explain
fi

case "$1" in
    --cpu)
        echo "Current CPU Usage:"
        top -bn1 | grep "Cpu(s)"
        ;; 
    --memory)
        echo "Current Memory Usage:"
        free -h
        ;; 
    --disk)
        echo "Current Disk Usage:"
        df -h
        ;; 
    *)
        echo "Invalid option. Use --explain to see available options."
        exit 1
        ;; 
esac
