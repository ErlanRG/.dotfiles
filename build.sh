#!/usr/bin/env bash

set -eo pipefail

BACKUP_DIR="$HOME/.bckps"
CONFIG_PATH="$HOME/.config/"
DOTFILES_DIR="$HOME/.dotfiles"
STOW_FOLDERS=("dunst" "i3" "git" "kitty" "nvim" "picom" "polybar" "rofi" "screenlayout" "starship" "tmux" "wezterm" "yazi" "zsh")

banner() {
    local text="$1"
    local border=$(printf "=%.0s" $(seq 1 $((${#text} + 4))))
    echo "$border"
    echo "| $text |"
    echo "$border"
    echo
}

create_dir_if_not_exists() {
    local dir="$1"
    [ ! -d "$dir" ] && mkdir -p "$dir"
}

unstow_dirs() {
    cd "$DOTFILES_DIR"
    banner "Uninstalling stow packages..."
    for folder in "${STOW_FOLDERS[@]}"; do
        stow -D "$folder" || echo "Error: Failed to unstow $folder"
    done
    cd "$HOME"
}

stow_dirs() {
    cd "$DOTFILES_DIR"
    banner "Installing stow packages..."
    for folder in "${STOW_FOLDERS[@]}"; do
        stow "$folder" || echo "Error: Failed to stow $folder"
    done
    cd "$HOME"
}

full_backup() {
    banner "Backing up config"
    create_dir_if_not_exists "$BACKUP_DIR"

    for folder in "${STOW_FOLDERS[@]}"; do
        local source_folder="$CONFIG_PATH$folder"
        local target_folder="$BACKUP_DIR/"

        if [ "$folder" = "zsh" ]; then
            source_folder="$HOME/.zshrc"
            target_folder="$BACKUP_DIR/zshrc"
        fi

        if [ -e "$source_folder" ]; then
            echo "Backing up configuration from $source_folder"
            mv "$source_folder" "$target_folder" && echo "$folder moved to $target_folder"
        fi
    done
}

install_oh_my_zsh() {
    banner "Configuring Oh-My-Zsh"
    git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
    chsh -s "$(which zsh)" && echo "Shell changed to Zsh"

    banner "Installing Syntax highlighting and Autosuggestions"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
}

install_fzf() {
    banner "Installing FZF"
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    "$HOME/.fzf/install"
}

install_dependencies() {
    banner "Installing dependencies from Arch Repos"
    sudo pacman -S --needed dunst eza fd git kdeconnect keepassxc kitty lazygit neovim nextcloud-client nitrogen npm polybar picom rofi starship stow thunar tmux veracrypt wezterm yazi zoxide zsh --noconfirm

    banner "Installing dependencies from AUR"
    yay -S --needed autotiling librewolf-bin zen-browser-bin --noconfirm

    install_fonts

    [ ! -d "$HOME/.oh-my-zsh" ] && install_oh_my_zsh
    [ ! -d "$HOME/.fzf" ] && install_fzf

    banner "Tmux Plugin Manager"
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
}

install_fonts() {
    banner "Installing fonts"
    local iosevka_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Iosevka.zip"
    local dest_dir="$HOME/.local/share/fonts"
    create_dir_if_not_exists "$dest_dir"

    local file_name="Iosevka.zip"
    local file_path="$dest_dir/$file_name"

    wget -P "$dest_dir" "$iosevka_url" && echo "Font downloaded"
    unzip -o "$file_path" -d "$dest_dir" && echo "Fonts extracted"
    rm "$file_path" && echo "Downloaded zip removed"
}

usage() {
    echo "Usage: $0 {install|clean|setup}"
    exit 1
}

main() {
    if [ $# -eq 0 ]; then
        usage
    fi

    case "$1" in
    install)
        git clone --depth 1 https://github.com/ErlanRG/.dotfiles "$DOTFILES_DIR"
        install_dependencies
        full_backup
        stow_dirs
        ;;
    clean)
        unstow_dirs
        ;;
    setup)
        stow_dirs
        ;;
    *)
        usage
        ;;
    esac
}

main "$@"
