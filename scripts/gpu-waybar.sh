#!/bin/bash

# Report discrete AMD GPU usage for waybar.
# References the GPU by its stable PCI slot so it survives card0/card1
# renumbering across reboots. Outputs JSON (usage as text; temp + VRAM
# in the tooltip).

DEV="/sys/bus/pci/devices/0000:03:00.0"

busy=$(cat "$DEV/gpu_busy_percent" 2>/dev/null)
if [ -z "$busy" ]; then
    echo '{"text":"N/A","tooltip":"GPU not found"}'
    exit 0
fi

# Temperature (millidegrees -> degrees); hwmon index is unstable, so glob it
temp_raw=$(cat "$DEV"/hwmon/hwmon*/temp1_input 2>/dev/null | head -n1)
if [ -n "$temp_raw" ]; then
    temp=$((temp_raw / 1000))
else
    temp="?"
fi

# VRAM (bytes -> GiB, one decimal)
vram_used_raw=$(cat "$DEV/mem_info_vram_used" 2>/dev/null)
vram_total_raw=$(cat "$DEV/mem_info_vram_total" 2>/dev/null)
if [ -n "$vram_used_raw" ] && [ -n "$vram_total_raw" ]; then
    vram=$(awk -v u="$vram_used_raw" -v t="$vram_total_raw" \
        'BEGIN { printf "%.1f/%.1f GB", u/1073741824, t/1073741824 }')
else
    vram="?"
fi

printf '{"text":"%s","tooltip":"GPU %s%% | %s°C | VRAM %s"}\n' \
    "$busy" "$busy" "$temp" "$vram"
