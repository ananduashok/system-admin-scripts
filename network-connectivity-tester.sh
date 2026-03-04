#!/bin/bash

###############################################################################
# Network Connectivity Tester
# Purpose: Tests network connectivity to critical services
# Target: Ubuntu systems
#
# Usage:
#   ./network-connectivity-tester.sh
#   ./network-connectivity-tester.sh 8.8.8.8 1.1.1.1 google.com
###############################################################################

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Network Connectivity Tester                                ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Default hosts to test
HOSTS=("8.8.8.8" "1.1.1.1" "google.com" "github.com")

# If arguments provided, use those instead
if [ $# -gt 0 ]; then
    HOSTS=("$@")
fi

# Initialize counters
REACHABLE=0
UNREACHABLE=0

echo -e "${YELLOW}Testing connectivity to hosts:${NC}"
echo "─────────────────────────────────────────────────"

for host in "${HOSTS[@]}"; do
    echo -n "Testing $host ... "
    
    if ping -c 1 -W 2 "$host" &>/dev/null; then
        echo -e "${GREEN}✓ Reachable${NC}"
        ((REACHABLE++))
        
        # Get response time
        RESPONSE=$(ping -c 1 -W 2 "$host" 2>/dev/null | grep "time=" | awk -F'time=' '{print $2}')
        echo "  └─ Response time: $RESPONSE"
    else
        echo -e "${RED}✗ Unreachable${NC}"
        ((UNREACHABLE++))
    fi
done

echo ""

# DNS Resolution Test
echo -e "${YELLOW}DNS Resolution Test:${NC}"
echo "─────────────────────────────────────────────────"

DNS_SERVERS=("8.8.8.8" "1.1.1.1" "$(grep nameserver /etc/resolv.conf 2>/dev/null | head -1 | awk '{print $2}')")

for dns in "${DNS_SERVERS[@]}"; do
    [ -z "$dns" ] && continue
    echo -n "Testing DNS Server $dns ... "
    
    if nslookup google.com "$dns" &>/dev/null; then
        echo -e "${GREEN}✓ Working${NC}"
    else
        echo -e "${RED}✗ Not Working${NC}"
    fi
done

echo ""

# Network Interface Status
echo -e "${YELLOW}Network Interface Status:${NC}"
echo "─────────────────────────────────────────────────"

ip link show | grep -E "^[0-9]+:|link/ether|inet " | awk '
    /^[0-9]+:/ {
        gsub(/[0-9]+:/, "");
        gsub(/:/, "");
        interface=$1;
        gsub(/^ +/, "", interface);
    }
    /link\/(ether|loopback)/ {
        if (/UP/) {
            status="UP";
            color="\033[0;32m";
        } else {
            status="DOWN";
            color="\033[0;31m";
        }
    }
    END {
        if (status) printf "%s%-15s %s%s\n", color, interface, status, "\033[0m"
    }
'

# Detailed interface info
ip addr show | grep -E "^[0-9]+:|inet " | awk '
    /^[0-9]+:/ {
        gsub(/[0-9]+:/, "");
        gsub(/:/, "");
        interface=$1;
        gsub(/^ +/, "", interface);
    }
    /inet / && !/inet6/ {
        gsub(/\/.*/, "");
        gsub(/^.*inet /, "");
        printf "  %-10s IP: %s\n", interface, $0
    }
'

echo ""

# Gateway and Routing
echo -e "${YELLOW}Gateway and Routing:${NC}"
echo "─────────────────────────────────────────────────"

DEFAULT_GATEWAY=$(ip route | grep default | awk '{print $3}')
if [ -n "$DEFAULT_GATEWAY" ]; then
    echo "Default Gateway: $DEFAULT_GATEWAY"
    echo -n "Testing gateway connectivity ... "
    if ping -c 1 -W 2 "$DEFAULT_GATEWAY" &>/dev/null; then
        echo -e "${GREEN}✓ Gateway is reachable${NC}"
    else
        echo -e "${RED}✗ Gateway is unreachable${NC}"
    fi
else
    echo -e "${RED}No default gateway found${NC}"
fi

echo ""

# Internet Speed Test (basic)
echo -e "${YELLOW}Basic Internet Quality Check:${NC}"
echo "─────────────────────────────────────────────────"

echo "Packet loss test to 8.8.8.8 (10 packets):"
PACKET_LOSS=$(ping -c 10 -W 2 8.8.8.8 2>/dev/null | grep -oP '\d+(?=% packet loss)')

if [ -z "$PACKET_LOSS" ]; then
    PACKET_LOSS="Unknown"
elif [ "$PACKET_LOSS" -eq 0 ]; then
    echo -e "  ${GREEN}✓ No packet loss${NC}"
elif [ "$PACKET_LOSS" -lt 5 ]; then
    echo -e "  ${YELLOW}⚠ Low packet loss ($PACKET_LOSS%)${NC}"
else
    echo -e "  ${RED}✗ High packet loss ($PACKET_LOSS%)${NC}"
fi

echo ""

# Summary
echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo "Connectivity Summary:"
echo "─────────────────────────────────────────────────"
echo -e "Hosts Reachable:   ${GREEN}$REACHABLE${NC}"
echo -e "Hosts Unreachable: ${RED}$UNREACHABLE${NC}"

if [ "$UNREACHABLE" -eq 0 ]; then
    echo -e "Overall Status: ${GREEN}✓ All systems operational${NC}"
else
    echo -e "Overall Status: ${RED}✗ Some connectivity issues detected${NC}"
fi
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"