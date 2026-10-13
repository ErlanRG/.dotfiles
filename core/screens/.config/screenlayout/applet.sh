#!/usr/bin/env bash

desktop="${XDG_CURRENT_DESKTOP,,}"

# noctalia's launcher when the shell is running (mango), wofi otherwise.
menu() {
    if pgrep -x noctalia >/dev/null; then
        noctalia dmenu --prompt "$1"
    else
        wofi --dmenu --prompt "$1" --width 300 --height 250
    fi
}

case "$desktop" in
    hyprland|niri)
        options="󰍹  Main Monitor\n󰍺  Dual 2K\n󰍺  Dual 4K\n󰍹  Secondary Monitor"
        chosen=$(echo -e "$options" | menu "Monitor configuration")
        case "$chosen" in
            *Main*)      nwg-displays-apply -p main ;;
            *2K*)        nwg-displays-apply -p dual-2k ;;
            *4K*)        nwg-displays-apply -p dual-4k ;;
            *Secondary*) nwg-displays-apply -p secondary ;;
        esac
        ;;
    mango)
        options="󰍹  Main Monitor\n󰍺  Dual Monitor\n󰍹  Secondary Monitor"
        chosen=$(echo -e "$options" | menu "Monitor configuration")
        case "$chosen" in
            *Main*)      sh ~/.config/screenlayout/main.sh ;;
            *Dual*)      sh ~/.config/screenlayout/dual.sh ;;
            *Secondary*) sh ~/.config/screenlayout/secondary.sh ;;
        esac
        ;;
esac
