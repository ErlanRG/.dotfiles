#!/usr/bin/env bash

PRIMARY="DP-1"
SECONDARY="HDMI-A-1"

wlr-randr --output "$PRIMARY" --off \
          --output "$SECONDARY" --on --mode 3840x2160@60.00
