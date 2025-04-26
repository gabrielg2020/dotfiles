#!/bin/bash

# Path to wallpaper directory
WALLPAPER_DIR="$HOME/.config/wallpapers"

# Get a random wallpaper
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) | shuf -n 1)

# Kill existing swaybg process
killall swaybg 2>/dev/null

# Set the wallpaper
swaybg -i "$WALLPAPER" -m fill &