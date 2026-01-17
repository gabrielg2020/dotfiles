#!/bin/bash

# Check if swaync is installed
if ! command -v swaync-client &> /dev/null; then
    echo '{"text":"\uf0f3", "tooltip":"Install swaync"}'
    exit 0
fi

# Get notification count
COUNT=$(swaync-client -c 2>/dev/null || echo 0)

if [ "$COUNT" -gt 0 ]; then
    echo "{\"text\":\"\uf0f3 $COUNT\", \"tooltip\":\"$COUNT notifications\"}"
else
    echo "{\"text\":\"\uf0f3\", \"tooltip\":\"No notifications\"}"
fi
