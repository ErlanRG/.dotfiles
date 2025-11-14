#!/bin/bash

# Kill any running Waybar processes
pkill -x waybar

# Wait briefly to ensure Waybar is fully terminated
sleep 1

# Start Waybar again
nohup waybar -c "$HOME"/.config/mango/waybar/config.jsonc -s "$HOME"/.dotfiles/wms/mango/mango/.config/mango/waybar/style.css >/dev/null 2>&1 &
