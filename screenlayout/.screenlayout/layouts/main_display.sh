#!/bin/sh

xrandr --output DVI-D-0 --off --output HDMI-0 --off --output DP-0 --primary --mode 3440x1440 --rate 165 --pos 0x0 --rotate normal --output DP-1 --off

if ! pgrep -x "picom" > /dev/null
then
  picom &
fi

i3-msg restart
