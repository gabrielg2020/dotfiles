#!/usr/bin/env bash
# TUI-style volume OSD — a text bar rendered as a replacing swaync notification.
# Usage: osd.sh up|down|mute|mic

set -euo pipefail

case "${1:-}" in
    up)   wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ ;;
    down) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
    mute) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
    mic)  wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle ;;
    *)    echo "usage: $0 up|down|mute|mic" >&2; exit 1 ;;
esac

show() {
    notify-send -a osd -t 1200 \
        -h string:x-canonical-private-synchronous:osd \
        -h boolean:transient:true "$1"
}

if [[ "$1" == "mic" ]]; then
    read -r _ _ state < <(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
    [[ "${state:-}" == "[MUTED]" ]] && show "mic  [--------------------] muted" || show "mic  [====================] on"
    exit 0
fi

read -r _ vol state < <(wpctl get-volume @DEFAULT_AUDIO_SINK@)
pct=$(awk -v v="$vol" 'BEGIN { printf "%d", v * 100 + 0.5 }')
filled=$(( pct / 5 ))
bar=$(printf '%*s' "$filled" '' | tr ' ' '=')
pad=$(printf '%*s' $(( 20 - filled )) '' | tr ' ' '-')

if [[ "${state:-}" == "[MUTED]" ]]; then
    show "vol  [--------------------] muted"
else
    show "vol  [${bar}${pad}] ${pct}%"
fi
