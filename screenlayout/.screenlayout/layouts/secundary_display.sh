#!/bin/bash

# Set up only the secondary monitor (HDMI-A-0)
xrandr \
  --output HDMI-A-0 --primary --mode 1920x1080 --rate 100 --pos 0x0 --rotate right \
  --output DisplayPort-1 --off

# Start picom if not already running
pgrep -x "picom" > /dev/null || picom &

# Restart i3
i3-msg restart
