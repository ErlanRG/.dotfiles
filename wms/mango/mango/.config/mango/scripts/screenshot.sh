#!/usr/bin/env bash

set -o pipefail

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILE="$DIR/$(date +%Y-%m-%d_%H-%M-%S).png"
TMP="$(mktemp --suffix=.png)"

case "$1" in
    area)
        if slurp | grim -g - - | tee "$TMP" | wl-copy; then
            mv "$TMP" "$FILE"
            notify-send "Screenshot saved" "$FILE"
        else
            rm -f "$TMP"
            notify-send "Screenshot canceled"
        fi
        ;;
    full)
        if grim - | tee "$TMP" | wl-copy; then
            mv "$TMP" "$FILE"
            notify-send "Screenshot saved" "$FILE"
        else
            rm -f "$TMP"
            notify-send "Screenshot failed"
        fi
        ;;
    clip)
        if slurp | grim -g - - | wl-copy; then
            notify-send "Screenshot copied to clipboard"
        else
            notify-send "Screenshot canceled"
        fi
        ;;
    *)
        echo "Usage: $0 {area|full|clip}"
        exit 1
        ;;
esac
