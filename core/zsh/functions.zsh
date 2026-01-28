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

function ya() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}
