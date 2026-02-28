#!/bin/bash

# Check if playerctl is installed
if ! command -v playerctl &> /dev/null; then
    echo '{"text":"  ", "tooltip":"Install playerctl"}'
    exit 0
fi

# Get player status
STATUS=$(playerctl status 2>/dev/null)

if [ "$STATUS" = "Playing" ]; then
    ICON="  "
elif [ "$STATUS" = "Paused" ]; then
    ICON="  "
else
    echo '{"text":"", "tooltip":"No media playing"}'
    exit 0
fi

# Get track info
ARTIST=$(playerctl metadata artist 2>/dev/null)
TITLE=$(playerctl metadata title 2>/dev/null)

if [ -n "$ARTIST" ] && [ -n "$TITLE" ]; then
    TEXT="$ICON$ARTIST - $TITLE"
    TOOLTIP="$ARTIST - $TITLE"
elif [ -n "$TITLE" ]; then
    TEXT="$ICON$TITLE"
    TOOLTIP="$TITLE"
else
    TEXT="$ICON"
    TOOLTIP="Media playing"
fi

# Truncate if too long
if [ ${#TEXT} -gt 50 ]; then
    TEXT="${TEXT:0:47}..."
fi

echo "{\"text\":\"$TEXT\", \"tooltip\":\"$TOOLTIP\"}"
