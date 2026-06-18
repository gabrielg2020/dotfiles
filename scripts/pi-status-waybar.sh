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
heimdall=$(check_pi "10.0.0.1")
zeus=$(echo "●")
proteus=$(check_pi "10.0.0.3")
ninkasi=$(check_pi "10.0.0.4")

# Output JSON for waybar
echo "{\"text\":\"[$heimdall $zeus $proteus $ninkasi]\", \"tooltip\":\"heimdall (10.0.0.1)\\nzeus     (10.0.0.2)\\nproteus  (10.0.0.3)\\nninkasi  (10.0.0.4)\"}"
