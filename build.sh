#!/usr/bin/env bash

set -eo pipefail

STOW_FOLDERS=("dunst" "i3" "git" "kitty" "nvim" "picom" "polybar" "rofi" "starship" "tmux" "wezterm" "zsh")
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
        target_folder="$HOME/.bckps/$folder"

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
    banner "Setting up zsh"

    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
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
    banner "FZF"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

install_dependencies() {
    banner "Installing dependencies from Arch Repos"
    sudo pacman -S --needed dunst git kitty nitrogen picom polybar rofi starship stow thunar tmux yay zoxide zsh --noconfirm || {
        echo "Error: Failed to install packages."
        exit 1
    }

    banner "Installing dependencies from the AUR"
    yay -S --needed betterlockscreen librewolf-bin autotiling --noconfirm || {
        echo "Error: Failed to install packages"
        exit 1
    }

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        install_oh_my_zsh
    fi

    if [ ! -d "$HOME/.fzf" ]; then
        install_fzf
    fi
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

        # Make sure there are no symlinks in the config path.
        unstow_dirs

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
