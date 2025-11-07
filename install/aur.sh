#!/usr/bin/env bash

set -eo pipefail

WM=$1 # Get the WM parameter

# Function to check if a command exists
command_exists () {
    type "$1" &> /dev/null ;
}

AUR_HELPER=""

if command_exists paru; then
    AUR_HELPER="paru"
elif command_exists yay; then
    AUR_HELPER="yay"
else
    banner "Neither paru nor yay found. Installing paru..."
    sudo pacman -S --noconfirm base-devel git
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    (cd /tmp/paru && makepkg -si --noconfirm)
    AUR_HELPER="paru"
fi

banner "Using AUR helper: $AUR_HELPER"

# Read packages from aur.packages
mapfile -t packages < <(grep -v '^#' "./packages/aur.packages" | grep -v '^$')

if [ "$WM" = "i3" ]; then
    install_packages=("${packages[@]}")
else
    # Filter out autotiling if WM is not i3
    mapfile -t install_packages < <(printf '%s\n' "${packages[@]}" | grep -v "autotiling")
fi

banner "Installing AUR packages: ${install_packages[*]}"
$AUR_HELPER -S --noconfirm --needed "${install_packages[@]}"
