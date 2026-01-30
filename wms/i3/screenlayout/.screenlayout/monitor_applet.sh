#!/usr/bin/env bash

# Options
option_1="󰍹  Main Display"
option_2="󰍺  Dual Display"
option_3="󰍹  Secundary Display"

# Vicinae CMD
vicinae_cmd() {
	vicinae dmenu --placeholder "Select Display Option"
}

# Pass variables to rofi dmenu
run_vicinae() {
	echo -e "$option_1\n$option_2\n$option_3" | vicinae_cmd
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
        sh ~/.screenlayout/layouts/main_display.sh
	elif [[ "$1" == '--opt2' ]]; then
        sh ~/.screenlayout/layouts/dual_display.sh
	elif [[ "$1" == '--opt3' ]]; then
        sh ~/.screenlayout/layouts/secundary_display.sh
	fi
}

# Actions
chosen="$(run_vicinae)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
esac
