#!/bin/sh

xrandr_outout=$(xrandr)

if [[ $xrandr_outout == *"HDMI-0 connected"* ]]; then
  # Change DP-0 resolution to 1920x1080 & kill picom
  pkill -9 picom
  xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 -r 75 --pos 0x0 --rotate normal --output DP-0 --primary --mode 1920x1080 --pos 1920x0 -r 120 --rotate normal --output DP-1 --off
else
  xrandr --output DVI-D-0 --off --output HDMI-0 --off --output DP-0 --primary --mode 1920x1080 -r 120 --pos 0x0 --rotate normal --output DP-1 --off
fi

# Restart pipewire to avoid audio issues.
systemctl --user stop pipewire && systemctl --user enable pipewire && i3-msg restart
