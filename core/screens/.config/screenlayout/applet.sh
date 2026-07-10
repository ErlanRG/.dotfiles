#!/usr/bin/env bash

desktop="${XDG_CURRENT_DESKTOP,,}"

case "$desktop" in
    hyprland)
        options="󰍹  Main Monitor\n󰍺  Dual 2K\n󰍺  Dual 4K\n󰍹  Secondary Monitor"
        chosen=$(echo -e "$options" | wofi --dmenu --prompt "Monitor configuration" --width 300 --height 250)
        case "$chosen" in
            *Main*)      nwg-displays-apply -p main ;;
            *2K*)        nwg-displays-apply -p dual-2k ;;
            *4K*)        nwg-displays-apply -p dual-4k ;;
            *Secondary*) nwg-displays-apply -p secondary ;;
        esac
        ;;
    mango|niri)
        options="󰍹  Main Monitor\n󰍺  Dual Monitor\n󰍹  Secondary Monitor"
        chosen=$(echo -e "$options" | wofi --dmenu --prompt "Monitor configuration" --width 300 --height 250)
        case "$chosen" in
            *Main*)      sh ~/.config/screenlayout/main.sh ;;
            *Dual*)      sh ~/.config/screenlayout/dual.sh ;;
            *Secondary*) sh ~/.config/screenlayout/secondary.sh ;;
        esac
        ;;
esac
