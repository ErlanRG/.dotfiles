# ALIASES
# omz
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias sz='source $HOME/.zshrc'
alias zshc="nvim ~/.zshrc"

# ls
alias l='eza -lahF --color=always --icons --sort=size --group-directories-first -s=Name'
alias ll='eza -lah'
alias ls='eza -lhF --color=always --icons --sort=size --group-directories-first'

# git
alias ga='git add'
alias gap='git add -p'
alias gc='git commit'
alias gcb='git checkout -b'
alias gch='git checkout'
alias gcl='git clone --depth=1'
alias gco='git checkout $(git branch | fzf-tmux -p 20%,50%)'
alias gd='git diff'
alias gdb='git branch -D'
alias gfp='git fetch -p origin'
alias gl='git log --oneline --decorate --graph'
alias gp='git push'
alias gs='git status'
alias gundo='git reset --soft HEAD~1'
alias lg='lazygit'

# pacman and yay
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'  # remove orphaned packages
alias pacsyu='sudo pacman -Syu'                  # update only standard pkgs
alias pacsyyu='sudo pacman -Syyu'                # Refresh pkglist & update standard pkgs
alias pacrns='sudo pacman -Rns'                 # Remove a package with its dependencies
alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
alias yaysua='yay -Sua --noconfirm'              # update only AUR pkgs (yay)
alias yaysyu='yay -Syu --noconfirm'              # update standard pkgs and AUR pkgs (yay)

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# other
alias c='clear'
alias rmdir='rm -rf'
alias shutdown='shutdown now'
alias startup_nvim='nvim --startuptime startup.log -c exit && tail -100 startup.log'

# Tmux
alias tconf='nvim $HOME/.config/tmux/tmux.conf'
alias tk='tmux kill-server'
alias tks='tmux kill-session -a' # kill all sessions but the current
alias tls='tmux list-sessions'
