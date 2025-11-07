#!/bin/bash

# Monitor identifiers
PRIMARY="DisplayPort-1"
SECONDARY="HDMI-A-0"

# Get connected monitors
CONNECTED=$(xrandr | grep " connected" | cut -d" " -f1)

# Check if both monitors are connected
if echo "$CONNECTED" | grep -q "$PRIMARY" && echo "$CONNECTED" | grep -q "$SECONDARY"; then
    # Both connected: set up dual monitors
    xrandr \
        --output "$PRIMARY" --primary --mode 3440x1440 --rate 165 --pos 1080x240 --rotate normal \
        --output "$SECONDARY" --mode 1920x1080 --rate 100 --pos 0x0 --rotate right
elif echo "$CONNECTED" | grep -q "$PRIMARY"; then
    # Only primary monitor is connected
    xrandr \
        --output "$PRIMARY" --primary --mode 3440x1440 --rate 165 --pos 0x0 --rotate normal \
        --output "$SECONDARY" --off
elif echo "$CONNECTED" | grep -q "$SECONDARY"; then
    # Only secondary monitor is connected
    xrandr \
        --output "$SECONDARY" --primary --mode 1920x1080 --rate 100 --pos 0x0 --rotate right \
        --output "$PRIMARY" --off
else
    echo "No known monitors are connected."
fi

# Start picom if not already running
pgrep -x "picom" > /dev/null || picom &

# Restart i3
i3-msg restart
