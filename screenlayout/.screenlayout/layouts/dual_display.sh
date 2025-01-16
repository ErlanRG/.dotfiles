#!/bin/sh

xrandr_outout=$(xrandr)

if [[ $xrandr_outout == *"HDMI-0 connected"* ]]; then
  xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --rate 100 --pos 0x0 --rotate right --output DP-0 --primary --mode 3440x1440 --pos 1080x0 --rate 165 --rotate normal --output DP-1 --off
else
  xrandr --output DVI-D-0 --off --output HDMI-0 --off --output DP-0 --primary --mode 3440x1440 --rate 165 --pos 0x0 --rotate normal --output DP-1 --off
fi

if ! pgrep -x "picom" > /dev/null
then
  picom &
fi

i3-msg restart
