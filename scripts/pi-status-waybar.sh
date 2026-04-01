#!/bin/bash

# Pi status script for waybar
# Returns JSON with dots showing Pi status

check_pi() {
    local ip=$1
    # Ping with 1 second timeout
    if ping -c 1 -W 1 "$ip" &>/dev/null; then
        echo "●"
    else
        echo "○"
    fi
}

# Check both Pis
hermes=$(check_pi "192.168.0.35")
proteus=$(check_pi "192.168.0.20")

# Output JSON for waybar
echo "{\"text\":\"[$hermes $proteus]\", \"tooltip\":\"hermes (192.168.0.35)\\nproteus (192.168.0.20)\"}"
