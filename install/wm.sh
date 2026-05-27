#!/usr/bin/env bash

set -eo pipefail

WM=$1 # Get the WM parameter

banner "Installing window manager packages for $WM"

install_packages() {
    local file=$1
    mapfile -t packages < <(grep -v '^#' "./packages/$file" | grep -v '^$')
    sudo pacman -S --noconfirm --needed "${packages[@]}"
}

if [[ "$WM" == "i3" ]]; then
    install_packages "i3.packages"
elif [[ "$WM" == "hyprland" ]]; then
    install_packages "wayland.packages"
    install_packages "hyprland.packages"
else
    install_packages "wayland.packages"
fi
