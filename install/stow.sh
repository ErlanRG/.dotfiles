#!/usr/bin/env bash

set -eo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
PROJECT_ROOT=$(dirname "$SCRIPT_DIR")

TARGET=$1
BACKUP_DIR=~/config_backup_$(date +%Y%m%d%H%M%S)

banner "Stowing dotfiles for $TARGET..."
banner "Creating backup directory at $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

if [ "$TARGET" == "core" ]; then
    TARGET_DIR="$PROJECT_ROOT/core"
else
    TARGET_DIR="$PROJECT_ROOT/wms/$TARGET"
fi

if [ ! -d "$TARGET_DIR" ]; then
    banner "Error: Target directory not found for $TARGET"
    exit 1
fi

cd "$TARGET_DIR" || exit

for package_dir in */; do
    package_name=${package_dir%/}

    cd "$package_name" || continue

    # Handle ~/.config conflicts
    if [ -d ".config" ]; then
        for app_config in ".config"/*; do
            if [ -e "$app_config" ]; then
                app_config_name=$(basename "$app_config")
                target_path="$HOME/.config/$app_config_name"
                if [ -e "$target_path" ]; then
                    banner "Backing up existing config: $target_path"
                    mv "$target_path" "$BACKUP_DIR/"
                fi
            fi
        done
    fi

    # Handle ~ dotfile conflicts
    for item in .[^.]*; do
        if [ -f "$item" ]; then # Only consider files
            target_path="$HOME/$item"
            if [ -e "$target_path" ]; then
                banner "Backing up existing config: $target_path"
                mv "$target_path" "$BACKUP_DIR/"
            fi
        fi
    done

    cd ..
done

# Stow only the directories
stow -t "$HOME" */

banner "Stowing complete for $TARGET."