#!/usr/bin/env bash

set -eo pipefail

WM=$1 # Get the WM parameter

if [[ "$WM" != "i3" ]] then
    WM="wayland"
fi

banner "Installing window manager packages for $WM"
mapfile -t packages < <(grep -v '^#' "./packages/""$WM"".packages" | grep -v '^$')
sudo pacman -S --noconfirm --needed "${packages[@]}"
