#!/usr/bin/env bash

set -eo pipefail

banner "Installing core packages"
mapfile -t packages < <(grep -v '^#' "./packages/core.packages" | grep -v '^$')
sudo pacman -S --noconfirm --needed "${packages[@]}"

banner "Installing Oh My Zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

banner "Installing zsh-syntax-highlighting plugin"
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
fi

banner "Installing zsh-autosuggestions plugin"
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
fi

banner "Installing fzf"
if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    "$HOME/.fzf/install" --all --no-bash --no-fish
fi

banner "Installing web apps"
local_bin="$HOME/.local/bin"
mkdir -p "$local_bin"
cp ./scripts/* "$local_bin"

sh webapps "OSRS Wiki" https://oldschool.runescape.wiki/
sh webapps "RS3 Wiki" https://runescape.wiki/
sh webapps "WhatsApp Web" https://web.whatsapp.com/
sh webapps ChatGPT https://www.chatgpt.com/
sh webapps Discord https://www.discord.com/
sh webapps YouTube https://www.youtube.com/
