# User-specific binary directories to the path
PATH="$HOME/.local/bin/:$PATH"

# Add JavaFX to the path
export PATH_TO_FX="/usr/lib/jvm/java-20-openjdk/lib/javafx_modules/"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# .dotfiles path
export DOTFILES=$HOME/.dotfiles

# Automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  git
  vi-mode
)

# Oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Load additional configuration files
export EDITOR='nvim'
source $HOME/.dotfiles/zsh/aliases.zsh
source $HOME/.dotfiles/zsh/functions.zsh

# Load additional configuration files
eval "$(starship init zsh)"

# Load the zoxide directory jumping tool
eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
