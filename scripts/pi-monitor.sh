#!/bin/bash

# Pi monitoring script
# Displays status of Raspberry Pis

check_pi() {
    local hostname=$1
    local ip=$2

    # Ping with 1 second timeout
    if ping -c 1 -W 1 "$ip" &>/dev/null; then
        echo -e "\033[32m●\033[0m $hostname ($ip)"
    else
        echo -e "\033[31m●\033[0m $hostname ($ip)"
    fi
}

# Clear screen and move cursor to top
clear

while true; do
    # Move cursor to home position
    tput cup 0 0

    echo "=== Pi Status ==="
    echo ""
    check_pi "hermes " "10.0.0.1"
    check_pi "proteus" "10.0.0.3"
    echo ""
    echo "Updated: $(date '+%H:%M:%S')"

    # Wait 5 seconds before next check
    sleep 5
done
