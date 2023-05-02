# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# LunarVim PATH
PATH="$HOME/.local/bin/:$PATH"

# NeoAI variable
export OPENAI_API_KEY=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

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Define .dotfiles path
export DOTFILES=$HOME/.dotfiles

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

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
alias ll='exa -lah'
alias ls='exa -lhF --color=always --icons --sort=size --group-directories-first'
alias l='exa -lahF --color=always --icons --sort=size --group-directories-first -s=Name'

# git
alias gcl='git clone --depth 1'
alias gin='git init'
alias gad='git add'
alias gcm='git commit'
alias gpu='git push -u origin main'
alias gst='git status'
alias glog='git log --oneline'
alias gch='git checkout'
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
alias tmuxls='tmux list-sessions'
alias tmuxk='tmux kill-server'
alias tmuxks='tmux kill-session -a' # kill all sessions but the current
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

# Just use extract
function extract ()
{
  __pkgtools__at_function_enter extract
  local remove_archive
  local success
  local file_name
  local extract_dir

  if [[ "$1" == "" ]]; then
    echo "Usage: extract [-option] [file ...]"
    echo
    echo "Options:"
    echo "    -r, --remove : Remove archive."
    echo
  fi

  remove_archive=1
  if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
    remove_archive=0
    shift
  fi

  while [ -n "$1" ]; do
    if [[ ! -f "$1" ]]; then
      pkgtools__msg_warning "'$1' is not a valid file"
      shift
      continue
    fi

    success=0
    file_name="$( basename "$1" )"
    extract_dir="$( echo "$file_name" | sed "s/\.${1##*.}//g" )"
    case "$1" in
        (*.tar.gz|*.tgz) tar xvzf "$1" ;;
        (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
        (*.tar.xz|*.txz) tar --xz --help &> /dev/null \
          && tar --xz -xvf "$1" \
          || xzcat "$1" | tar xvf - ;;
        (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null \
          && tar --lzma -xvf "$1" \
          || lzcat "$1" | tar xvf - ;;
        (*.tar) tar xvf "$1" ;;
        (*.gz) gunzip "$1" ;;
        (*.bz2) bunzip2 "$1" ;;
        (*.xz) unxz "$1" ;;
        (*.lzma) unlzma "$1" ;;
        (*.Z) uncompress "$1" ;;
        (*.zip) unzip "$1" -d $extract_dir ;;
        (*.rar) unrar e -ad "$1" ;;
        (*.7z) 7za x "$1" ;;
        (*.deb)
        mkdir -p "$extract_dir/control"
        mkdir -p "$extract_dir/data"
        cd "$extract_dir"; ar vx "../${1}" > /dev/null
        cd control; tar xzvf ../control.tar.gz
        cd ../data; tar xzvf ../data.tar.gz
        cd ..; rm *.tar.gz debian-binary
        cd ..
        ;;
        (*)
        pkgtools__msg_error "'$1' cannot be extracted" 1>&2
        success=1
        ;;
    esac

    (( success = $success > 0 ? $success : $? ))
    (( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
    shift
  done
  __pkgtools__at_function_exit
  return 0
}

# Nvim switcher
alias nvimv="NVIM_APPNAME=defNvim nvim"

function nvims() {
  items=("RangER" "Vanilla")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "RangER" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

eval "$(starship init zsh)"
