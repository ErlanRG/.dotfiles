#!/usr/bin/env bash

PRIMARY="DP-1"
SECONDARY="HDMI-A-1"

wlr-randr --output "$PRIMARY" --on --mode 3440x1440@164.890 \
          --output "$SECONDARY" --off
