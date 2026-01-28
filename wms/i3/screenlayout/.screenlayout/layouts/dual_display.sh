#!/bin/bash

# Monitor identifiers
PRIMARY="DisplayPort-0"
SECONDARY="HDMI-A-0"

# Get connected monitors
CONNECTED=$(xrandr | grep " connected" | cut -d" " -f1)

# Check if both monitors are connected
if echo "$CONNECTED" | grep -q "$PRIMARY" && echo "$CONNECTED" | grep -q "$SECONDARY"; then
    # Both connected: set up dual monitors
    xrandr \
        --output "$PRIMARY" --primary --mode 3440x1440 --auto --rotate normal \
        --output "$SECONDARY" --mode 1920x1080 --auto --right-of "$PRIMARY" --rotate normal
elif echo "$CONNECTED" | grep -q "$PRIMARY"; then
    # Only primary monitor is connected
    xrandr \
        --output "$PRIMARY" --primary --mode 3440x1440 --auto --rotate normal \
        --output "$SECONDARY" --off
elif echo "$CONNECTED" | grep -q "$SECONDARY"; then
    # Only secondary monitor is connected
    xrandr \
        --output "$SECONDARY" --primary --mode 1920x1080 --auto --rotate normal \
        --output "$PRIMARY" --off
else
    echo "No known monitors are connected."
fi

# Start picom if not already running
pgrep -x "picom" > /dev/null || picom &

# Restart i3
i3-msg restart
