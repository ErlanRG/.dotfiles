#!/bin/sh

xrandr_outout=$(xrandr)

if [[ $xrandr_outout == *"HDMI-0 connected"* ]]; then
  # Change DP-0 resolution to 1920x1080 & kill picom
  xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --rate 100 --pos 0x0 --rotate right --output DP-0 --primary --mode 1920x1080 --pos 1920x0 --rate 120 --rotate normal --output DP-1 --off
else
  xrandr --output DVI-D-0 --off --output HDMI-0 --off --output DP-0 --primary --mode 1920x1080 --rate 120 --pos 0x0 --rotate normal --output DP-1 --off
fi

if ! pgrep -x "picom" > /dev/null
then
  picom &
fi

# Restart pipewire to avoid audio issues.
systemctl --user stop pipewire && systemctl --user enable pipewire && i3-msg restart
