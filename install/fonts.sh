#!/usr/bin/env bash

set -eo pipefail

FONT_VERSION="v3.4.0"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/$FONT_VERSION/Iosevka.zip"
FONT_DIR="$HOME/.local/share/fonts"
TEMP_ZIP="/tmp/Iosevka.zip"

banner "Downloading Iosevka Nerd Font..."
mkdir -p "$FONT_DIR"
curl -L "$FONT_URL" -o "$TEMP_ZIP"

banner "Extracting font files to $FONT_DIR..."
unzip -o "$TEMP_ZIP" -d "$FONT_DIR"

banner "Cleaning up temporary files..."
rm "$TEMP_ZIP"

banner "Updating font cache..."
fc-cache -fv

banner "Iosevka Nerd Font installed successfully!"
