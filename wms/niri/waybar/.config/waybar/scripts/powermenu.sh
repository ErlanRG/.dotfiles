#!/bin/bash
options="  Shutdown\n  Reboot\n  Logout\n  Suspend\n  Hibernate\n  Lock\n  Exit"
chosen=$(echo -e "$options" | wofi --dmenu --prompt "Power Menu" --width 300 --height 250)

case "$chosen" in
    *Shutdown*)   systemctl poweroff ;;
    *Reboot*)     systemctl reboot ;;
    *Logout*)     niri msg action quit --skip-confirmation ;;
    *Suspend*)    systemctl suspend ;;
    *Hibernate*)  systemctl hibernate ;;
    *Lock*)       swaylock ;;
    *Exit*)       exit 0 ;;
    *)            exit 1 ;;
esac
