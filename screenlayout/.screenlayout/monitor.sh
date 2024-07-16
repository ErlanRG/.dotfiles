#!/bin/sh

xrandr_outout=$(xrandr)

if [[ $xrandr_outout == *"HDMI-0 connected"* ]]; then
  xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 -r 75 --pos 0x0 --rotate normal --output DP-0 --primary --mode 3440x1440 --pos 1920x0 -r 165 --rotate normal --output DP-1 --off
else
  xrandr --output DVI-D-0 --off --output HDMI-0 --off --output DP-0 --primary --mode 3440x1440 -r 165 --pos 0x0 --rotate normal --output DP-1 --off
fi

if ! pgrep -x "picom" > /dev/null
then
  picom &
fi
