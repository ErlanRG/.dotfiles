#!/usr/bin/env bash

PRIMARY="DP-1"
SECONDARY="HDMI-A-1"

wlr-randr --output "$PRIMARY" --off \
          --output "$SECONDARY" --on --mode 2560x1440@59.951
