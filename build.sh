#!/usr/bin/env bash
set -eo pipefail

# ========================
# Variables
# ========================
BACKUP_DIR="$HOME/.bckps"
CONFIG_PATH="$HOME/.config/"
DOTFILES_DIR="$HOME/.dotfiles"
LOG_DIR="$HOME/.install_logs"
LOG_FILE="$LOG_DIR/install_$(date +%F_%H-%M-%S).log"
STOW_FOLDERS=("dunst" "i3" "git" "kitty" "nvim" "picom" "polybar" "rofi" "screenlayout" "starship" "tmux" "ghostty" "xinitrc" "yazi" "zsh")

# Create log directory
mkdir -p "$LOG_DIR"

# Redirect stdout and stderr to both terminal and log file
exec > >(tee -a "$LOG_FILE") 2>&1

# ========================
# Colors
# ========================
RESET="\033[0m"
BOLD="\033[1m"
BLUE="\033[34m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"

# ========================
# Error handling
# ========================
fatal() {
    echo -e "${BOLD}${RED}FATAL:${RESET} $1" >&2
    echo -e "${BOLD}${RED}See log for details: $LOG_FILE${RESET}" >&2
    exit 1
}

# ========================
# Functions
# ========================
banner() {
    local text="$1"
    local border
    border=$(printf "=%.0s" $(seq 1 $((${#text} + 4))))
    echo -e "${BOLD}${BLUE}${border}${RESET}"
    echo -e "${BOLD}${GREEN}| ${text} |${RESET}"
    echo -e "${BOLD}${BLUE}${border}${RESET}\n"
}

create_dir_if_not_exists() {
    local dir="$1"
    [ ! -d "$dir" ] && mkdir -p "$dir"
}

clone_repo() {
    local url="$1"
    local dest="$2"
    local branch="$3"

    if [ -d "$dest/.git" ]; then
        echo -e "${YELLOW}Repo already exists at $dest, skipping clone.${RESET}"
    else
        if [ -n "$branch" ]; then
            git clone --depth 1 --branch "$branch" "$url" "$dest" || fatal "Failed to clone $url"
        else
            git clone --depth 1 "$url" "$dest" || fatal "Failed to clone $url"
        fi
        echo -e "${GREEN}Cloned: $url → $dest${RESET}"
    fi
}

unstow_dirs() {
    cd "$DOTFILES_DIR" || fatal "Dotfiles directory not found: $DOTFILES_DIR"
    banner "Uninstalling stow packages..."
    for folder in "${STOW_FOLDERS[@]}"; do
        stow -D "$folder" || echo -e "${YELLOW}Failed to unstow $folder${RESET}"
    done
    cd "$HOME" || fatal "Failed to return to home directory"
}

stow_dirs() {
    cd "$DOTFILES_DIR" || fatal "Dotfiles directory not found: $DOTFILES_DIR"
    banner "Installing stow packages..."
    for folder in "${STOW_FOLDERS[@]}"; do
        stow "$folder" || fatal "Failed to stow $folder"
    done
    cd "$HOME" || fatal "Failed to return to home directory"
}

full_backup() {
    banner "Backing up config"
    create_dir_if_not_exists "$BACKUP_DIR"

    local timestamp
    timestamp=$(date +%F_%H-%M-%S)

    for folder in "${STOW_FOLDERS[@]}"; do
        local source_folder="$CONFIG_PATH$folder"
        local target_folder="$BACKUP_DIR/${folder}_$timestamp"

        if [ "$folder" = "zsh" ]; then
            source_folder="$HOME/.zshrc"
            target_folder="$BACKUP_DIR/zshrc_$timestamp"
        fi

        if [ -e "$source_folder" ]; then
            echo -e "${YELLOW}Backing up from $source_folder${RESET}"
            mv "$source_folder" "$target_folder" || fatal "Failed to move $source_folder to $target_folder"
            echo -e "${GREEN}$folder moved to $target_folder${RESET}"
        fi
    done
}

install_oh_my_zsh() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        banner "Configuring Oh-My-Zsh"
        clone_repo "https://github.com/ohmyzsh/ohmyzsh.git" "$HOME/.oh-my-zsh"
        chsh -s "$(which zsh)" || fatal "Failed to change shell to Zsh"

        banner "Installing Syntax highlighting and Autosuggestions"
        clone_repo "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
        clone_repo "https://github.com/zsh-users/zsh-autosuggestions" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    fi
}

install_fzf() {
    if [[ ! -d "$HOME/.fzf" ]]; then
        banner "Installing FZF"
        clone_repo "https://github.com/junegunn/fzf.git" "$HOME/.fzf"
        "$HOME/.fzf/install" || fatal "FZF installation failed"
    fi
}

check_yay() {
    if ! command -v yay >/dev/null 2>&1; then
        banner "Installing yay (AUR helper)"
        sudo pacman -S --needed base-devel git --noconfirm || fatal "Failed to install base-devel and git"
        local tmp_dir
        tmp_dir=$(mktemp -d) || fatal "Failed to create temp directory"
        local oldpwd="$PWD"
        git clone https://aur.archlinux.org/yay.git "$tmp_dir" || fatal "Failed to clone yay repository"
        cd "$tmp_dir" || fatal "Failed to enter yay build directory"
        makepkg -si --noconfirm || fatal "Failed to build/install yay"
        cd "$oldpwd" || fatal "Failed to return to previous directory"
        rm -rf "$tmp_dir"
        echo -e "${GREEN}yay installed successfully${RESET}"
    fi
}

install_arch_deps() {
    banner "Installing dependencies from Arch Repos"
    sudo pacman -S --needed unzip dunst eza fd git ghostty gnome-keyring kdeconnect keepassxc \
        kitty lazygit libsecret neovim nextcloud-client nitrogen npm polybar picom \
        rofi starship stow thunar tmux veracrypt wezterm yazi zoxide zsh --noconfirm \
        || fatal "Pacman dependency installation failed"
}

install_yay_deps() {
    banner "Installing dependencies from AUR"
    yay -S --needed autotiling librewolf-bin zen-browser-bin --noconfirm \
        || fatal "AUR package installation failed"
}

install_fonts() {
    banner "Installing fonts"
    local iosevka_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Iosevka.zip"
    local dest_dir="$HOME/.local/share/fonts"
    create_dir_if_not_exists "$dest_dir"

    local file_name="Iosevka.zip"
    local file_path="$dest_dir/$file_name"

    wget -P "$dest_dir" "$iosevka_url" || fatal "Failed to download font"
    echo -e "${GREEN}Font downloaded${RESET}"

    unzip -o "$file_path" -d "$dest_dir" || fatal "Failed to unzip font"
    echo -e "${GREEN}Fonts extracted${RESET}"

    rm "$file_path" || fatal "Failed to remove downloaded zip"
    echo -e "${YELLOW}Removed downloaded zip${RESET}"
}

install_dependencies() {
    install_arch_deps
    check_yay
    install_yay_deps
    install_fonts
    install_oh_my_zsh
    install_fzf
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
        clone_repo "https://github.com/ErlanRG/.dotfiles" "$DOTFILES_DIR"
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

    banner "INSTALLATION COMPLETE"
    echo -e "${GREEN}Installation log saved at:${RESET} $LOG_FILE"
}

main "$@"
