#!/usr/bin/env bash
# Set the wallpaper via awww and remember it for the next Hyprland start.
# Usage: wallpaper.sh <image>   (no argument = pick with fzf from ~/Documents/wallpapers)

set -euo pipefail

WALLPAPER_DIR="$HOME/Documents/wallpapers"
STATE_FILE="$HOME/.config/hypr/wallpaper"

if [[ $# -eq 0 ]]; then
    image=$(find "$WALLPAPER_DIR" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) | sort | fzf --prompt='wallpaper> ')
    [[ -n "$image" ]] || exit 0
else
    image=$(realpath "$1")
fi

awww img "$image" -t fade --transition-duration 1
echo "$image" > "$STATE_FILE"
