#!/bin/bash

PRIMARY="DisplayPort-0"
SECONDARY="HDMI-A-0"

xrandr \
  --output "$SECONDARY" --primary --mode 2560x1440 --rate 60 --pos 0x0 \
  --output "$PRIMARY" --off

# Start picom if not already running
pgrep -x "picom" > /dev/null || picom &

# Restart i3
i3-msg restart
