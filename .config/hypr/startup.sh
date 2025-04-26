#!/bin/bash

# Start kitty on workspace 1
hyprctl dispatch exec "[workspace 1] kitty"

# Start two Brave browsers on workspace 2
hyprctl dispatch exec "[workspace 2] brave --password-store=basic"
sleep 1
hyprctl dispatch exec "[workspace 2] brave --password-store=basic"

# Start Discord and Spotify on workspace 3
hyprctl dispatch exec "[workspace 3] discord"
sleep 2 # wait for discord to open -- its very slow...
hyprctl dispatch exec "[workspace 3] spotify"

# Start Obsidian and Todoist on workspace 4
hyprctl dispatch exec "[workspace 4] obsidian"
hyprctl dispatch exec "[workspace 4] todoist"

# Start KeePassXC on workspace 5
hyprctl dispatch exec "[workspace 5] keepassxc"

# Switch to workspace 5
sleep 2 # Wait for all apps to initialize
hyprctl dispatch workspace 5
