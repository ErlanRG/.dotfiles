#!/usr/bin/env bash

set +e

# Polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Start gnome-keyring
gnome-keyring-daemon --start &

# Network Applet
nm-applet &

# Octopi notifier
octopi-notifier &

# Nextcloud
nextcloud &

# Set wallpaper
swww img "$HOME/Nextcloud/Wallpapers/huawei-matebook-2560x1080-22554.png" &

# Wallpaper daemon
swww-daemon &

# Mango notifier
mako &

# Waybar
waybar -c "$HOME"/.config/mango/waybar/config.jsonc -s "$HOME"/.dotfiles/wms/mango/mango/.config/mango/waybar/style.css &
