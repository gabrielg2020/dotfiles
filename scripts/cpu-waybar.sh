#!/bin/bash

# Report CPU usage for waybar.
# Bar text shows aggregate usage; the tooltip adds temperature and a
# per-core breakdown. Usage is derived from two /proc/stat samples taken
# SAMPLE seconds apart.

SAMPLE=0.4

s1=$(grep '^cpu' /proc/stat)
sleep "$SAMPLE"
s2=$(grep '^cpu' /proc/stat)

# Compute aggregate + per-core usage from the two snapshots.
calc=$(awk '
    FNR==NR { for (i = 1; i <= NF; i++) p[$1, i] = $i; next }
    {
        t = 0
        for (i = 2; i <= NF; i++) t += ($i - p[$1, i])
        idle = ($5 - p[$1, 5]) + ($6 - p[$1, 6])   # idle + iowait
        u = (t > 0) ? 100 * (t - idle) / t : 0
        if ($1 == "cpu") printf "TOTAL %.0f\n", u
        else printf "CORE %d %.0f\n", substr($1, 4), u
    }
' <(echo "$s1") <(echo "$s2"))

total=$(awk '/^TOTAL/ {print $2}' <<< "$calc")
[ -z "$total" ] && total=0

# CPU temperature from k10temp (hwmon index is unstable, so match by name).
temp="?"
for h in /sys/class/hwmon/hwmon*; do
    if [ "$(cat "$h/name" 2>/dev/null)" = "k10temp" ]; then
        raw=$(cat "$h/temp1_input" 2>/dev/null)
        [ -n "$raw" ] && temp=$((raw / 1000))
        break
    fi
done

# Build the per-core tooltip section, four cores per line.
cores=""
i=0
while read -r _ n u; do
    cores+=$(printf 'C%-2s %3s%%  ' "$n" "$u")
    i=$((i + 1))
    [ $((i % 4)) -eq 0 ] && cores+='\n'
done < <(awk '/^CORE/ {print}' <<< "$calc" | sort -k2 -n)

printf '{"text":"%s","tooltip":"CPU %s%% | %s°C\\n%s"}\n' \
    "$total" "$total" "$temp" "$cores"
