#!/usr/bin/env bash

set -eo pipefail

# Function to display a banner message
banner() {
    echo ""
    echo "+----------------------------------------------------------------+"
    printf "| %-62s |\n" "$1"
    echo "+----------------------------------------------------------------+"
    echo ""
}

export -f banner

# Define Window Managers
wms=("i3" "niri")

# Select Window Manager
banner "Select your Window Manager"
select wm_choice in "${wms[@]}"; do
    if [[ -n "$wm_choice" ]]; then
        wm="$wm_choice"
        break
    else
        echo "Invalid selection. Please try again."
    fi
done

# Install packages
banner "Installing Core Packages"
./core.sh

banner "Installing AUR Packages"
./aur.sh "$wm"

banner "Installing Fonts"
./fonts.sh

banner "Installing Window Manager Specific Packages"
./wm.sh "$wm"

# Stow core and wm directories
banner "Stowing Core Dotfiles"
./stow.sh "core"

banner "Stowing Window Manager Dotfiles"
./stow.sh "$wm"

banner "Installation Complete!"
