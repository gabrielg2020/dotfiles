#!/bin/bash

# Get local IP address
# Returns the IP of the primary network interface

# Get the main IP address (the one used for internet)
IP=$(ip route get 1.1.1.1 2>/dev/null | awk '{print $7; exit}')

if [ -z "$IP" ]; then
    # Fallback: get first non-loopback IP
    IP=$(hostname -I | awk '{print $1}')
fi

if [ -z "$IP" ]; then
    IP="No IP"
fi

echo "$IP"
