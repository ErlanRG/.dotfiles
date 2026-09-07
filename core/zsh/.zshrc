# User-specific binary directories to the path
PATH="$HOME/.local/bin/:$PATH"

# TeX Live PATH
export MANPATH="/usr/local/texlive/2026/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2026/texmf-dist/doc/info:$INFOPATH"
export PATH="/usr/local/texlive/2026/bin/x86_64-linux:$PATH"

# .dotfiles path
export DOTFILES=$HOME/.dotfiles

# SSH Agent
# Make sure to have the socket enabled
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# History related configuration
HISTFILE="$HOME/.zsh_history"
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

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Completion
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"

# Load additional configuration files
export EDITOR='nvim'
source $DOTFILES/core/zsh/aliases.zsh
source $DOTFILES/core/zsh/functions.zsh

# Load additional configuration files
eval "$(starship init zsh)"

# Load the zoxide directory jumping tool
eval "$(zoxide init zsh)"

# Plugins and shell integration, all from the repos.
# zsh-syntax-highlighting must be sourced last.
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
