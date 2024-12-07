#!/usr/bin/env bash

set -eo pipefail

STOW_FOLDERS=("dunst" "i3" "git" "kitty" "nvim" "picom" "polybar" "rofi" "screenlayout" "starship" "tmux" "wezterm" "zsh")
CONFIG_PATH="$HOME/.config/"

banner() {
    local text="$1"
    local length=${#text}
    local border=""

    for ((i = 0; i < length + 4; i++)); do
        border="$border="
    done

    echo "$border"
    echo "| $text |"
    echo "$border"
    echo
}

unstow_dirs() {
    banner "Uninstalling stow packages..."
    for folder in "${STOW_FOLDERS[@]}"; do
        stow -D "$folder"
    done
}

stow_dirs() {
    banner "Installing stow packages..."
    for folder in "${STOW_FOLDERS[@]}"; do
        stow "$folder"
    done
}

full_backup() {
    banner "Backing up config"
    for folder in "${STOW_FOLDERS[@]}"; do
        source_folder="$CONFIG_PATH$folder"
        target_folder="$HOME/.bckps/"

        if [ "$folder" = "zsh" ]; then
            source_folder="$HOME/.zshrc"
            target_folder="$HOME/.bckps/zshrc"
        fi

        if [ -e "$source_folder" ]; then
            echo "Backing up configuration files in $source_folder"
            mkdir -p "$target_folder"
            mv "$source_folder" "$target_folder/"
            echo "$folder moved to $target_folder"
        fi
    done
}

install_oh_my_zsh() {
    banner "Configuring Oh-My-Zsh"

    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
    chsh -s "$(which zsh)" || {
        echo "Error: Failed to change shell to ZSH"
        exit 1
    }

    banner "Syntax highlighting && Autosuggestions"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
}

install_fzf() {
    banner "Installing FZF"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

install_dependencies() {
    banner "Installing dependencies from Arch Repos"
    sudo pacman -S --needed dunst eza fd git kitty lazygit neovim nitrogen npm polybar picom rofi starship stow thunar tmux wezterm yay zoxide zsh --noconfirm || {
        echo "Error: Failed to install packages."
        exit 1
    }

    banner "Installing dependencies from the AUR"
    yay -S --needed autotiling librewolf-bin zen-browser-bin --noconfirm || {
        echo "Error: Failed to install packages"
        exit 1
    }

    install_fonts

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        install_oh_my_zsh
    fi

    if [ ! -d "$HOME/.fzf" ]; then
        install_fzf
    fi
}

install_fonts() {
    banner "Installing fonts"

    IOSEVKA_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Iosevka.zip"
    DEST_DIR="$HOME/.local/share/fonts"
    FILE_NAME="Iosevka.zip"
    FILE_PATH="$DEST_DIR/$FILE_NAME"

    # Create the fonts directory if it doesn't exist
    if [ ! -d "$DEST_DIR" ]; then
        mkdir -p "$DEST_DIR"
    fi

    # Download the font
    wget -P "$DEST_DIR" "$IOSEVKA_URL" || {
        echo "Error: Download failed. File not found."
            exit 1
    }

    # Check if the file was downloaded successfully
    if [ ! -f "$FILE_PATH" ]; then
        echo "Download failed. File does not exist."
        exit 1
    fi

    echo "Download successful. Extracting file..."

    # Extract the downloaded file
    unzip -o "$FILE_PATH" -d "$DEST_DIR" || {
        echo "Error: Extraction failed."
            exit 1
    }

    # Optionally, remove the downloaded zip file after extraction
    rm "$FILE_PATH" || {
        echo "Error: Failed to remove the downloaded zip file."
    }

    echo "Fonts installed successfully."
}

usage() {
    echo "Usage: $0 {install|clean|setup}"
    exit 1
}

main() {
    if [ $# -eq 0 ]; then
        usage
    fi

    if [ "$1" = "install" ]; then
        # Dependencies
        install_dependencies

        full_backup

        stow_dirs
    elif [ "$1" = "clean" ]; then
        # Only unstow the configurations
        unstow_dirs
    elif [ "$1" = "setup" ]; then
        # Only stow the configurations
        stow_dirs
    else
        usage
    fi
}

main "$@"
