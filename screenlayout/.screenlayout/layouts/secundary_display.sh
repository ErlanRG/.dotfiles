#!/bin/sh

xrandr --output DVI-D-0 --off --output HDMI-0 --primary --mode 1920x1080 --rate 100 --pos 0x0 --rotate right --output DP-0 --off --output DP-1 --off

if ! pgrep -x "picom" > /dev/null
then
  picom &
fi

i3-msg restart
