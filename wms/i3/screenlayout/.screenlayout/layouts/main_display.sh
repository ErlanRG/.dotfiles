#!/bin/bash

# Set up only the main monitor (DisplayPort-1)
xrandr \
  --output DisplayPort-1 --primary --mode 3440x1440 --rate 165 --pos 0x0 --rotate normal \
  --output HDMI-A-0 --off

# Start picom if not already running
pgrep -x "picom" > /dev/null || picom &

# Restart i3
i3-msg restart
