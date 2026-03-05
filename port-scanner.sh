#!/bin/bash
echo "Services listening on ports:"
sudo netstat -tlnp | grep LISTEN | awk '{print $4, $7}'
# Alternative using ss:
# ss -tlnp | grep LISTEN
