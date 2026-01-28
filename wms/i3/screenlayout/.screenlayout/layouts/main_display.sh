#!/bin/bash

PRIMARY="DisplayPort-0"

xrandr \
  --output "$PRIMARY" --primary --mode 3440x1440 --auto --rotate normal \
  --output HDMI-A-0 --off

# Start picom if not already running
pgrep -x "picom" > /dev/null || picom &

# Restart i3
i3-msg restart
