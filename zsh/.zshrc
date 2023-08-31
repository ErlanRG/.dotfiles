# User-specific binary directories to the path
PATH="$HOME/.local/bin/:$PATH"

# Add JavaFX to the path
export PATH_TO_FX="/usr/lib/jvm/java-20-openjdk/lib/javafx_modules/"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# .dotfiles path
export DOTFILES=$HOME/.dotfiles

# History related configuration
HIST_FILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

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
