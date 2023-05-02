# ALIASES
# omz
alias zshc="nvim ~/.zshrc"
alias sz='source $HOME/.zshrc'
alias ohmyzsh="nvim ~/.oh-my-zsh"

# ls
alias ll='exa -lah'
alias ls='exa -lhF --color=always --icons --sort=size --group-directories-first'
alias l='exa -lahF --color=always --icons --sort=size --group-directories-first -s=Name'

# git
alias ga='git add'
alias gap='git add -p'
alias gc='git commit'
alias gco='git checkout $(git branch | fzf-tmux -p 20%,50%)'
alias gd='git diff'
alias gdb='git branch -D'
alias gfp='git fetch -p origin'
alias gl='git log --graph'
alias gp='git push'
alias lg='lazygit'

# pacman and yay
alias pacsyu='sudo pacman -Syu'                  # update only standard pkgs
alias pacsyyu='sudo pacman -Syyu'                # Refresh pkglist & update standard pkgs
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

# Tmux
alias tls='tmux list-sessions'
alias tk='tmux kill-server'
alias tks='tmux kill-session -a' # kill all sessions but the current
alias tconf='nvim $HOME/.config/tmux/tmux.conf'
