# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# LunarVim PATH
PATH="$HOME/.local/bin/:$PATH"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Define .dotfiles path
export DOTFILES=$HOME/.dotfiles

# Themes
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="arch"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
 # ENABLE_CORRECTION="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  vi-mode
)

# Oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ALIASES
# omz
alias zshconf="nvim ~/.zshrc"
alias sozsh='source $HOME/.zshrc'
alias ohmyzsh="nvim ~/.oh-my-zsh"

# ls
alias ll='lsd -lah'
alias la='lsd -A'
alias lm='lsd -m'
alias lr='lsd -R'
alias ls='lsd'
alias l='lsd -la --group-directories-first'

# git
alias gcl='git clone --depth 1'
alias gin='git init'
alias gad='git add'
alias gcm='git commit'
alias gpu='git push -u origin main'
alias gst='git status'
alias glog='git log --oneline'
alias gch='git checkout'

# pacman and yay
alias pacsyu='sudo pacman -Syu'                  # update only standard pkgs
alias pacsyyu='sudo pacman -Syyu'                # Refresh pkglist & update standard pkgs
alias parsua='paru -Sua --noconfirm'             # update only AUR pkgs (paru)
alias parsyu='paru -Syu --noconfirm'             # update standard pkgs and AUR pkgs (paru)
alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'  # remove orphaned packages

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# other
alias c='clear'
alias startup_nvim='nvim --startuptime startup.log -c exit && tail -100 startup.log'
alias shutdown='shutdown now'
alias rpissh='kitty +kitten ssh pi@192.168.0.137'
alias lg='lazygit'

# Tmux
alias tmuxls='tmux list-sessions'
alias tmuxk='tmux kill-server'
alias tmuxconf='nvim $HOME/.config/tmux/tmux.conf'

# navigation
up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}

# Fzf
# cf - fuzzy cd from anywhere
# ex: cf word1 word2 ... (even part of a file name)
# zsh autoload function
cf() {
  local file

  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf-tmux -p 80%,60% --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- $file
     else
        cd -- ${file:h}
     fi
  fi
}
