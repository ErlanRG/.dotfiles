#!/usr/bin/env bash

options="󰍹  Main Monitor\n󰍺  Dual Monitor\n󰍹  Secondary Monitor"
chosen=$(echo -e "$options" | wofi --dmenu --prompt "Monitor configuration" --width 300 --height 250)

case "$chosen" in
    *Main*)         sh ~/.config/screenlayout/main.sh ;;
    *Dual*)         sh ~/.config/screenlayout/dual.sh ;;
    *Secondary*)    sh ~/.config/screenlayout/secondary.sh ;;
    *Exit*)       exit 0 ;;
    *)            exit 1 ;;
esac
