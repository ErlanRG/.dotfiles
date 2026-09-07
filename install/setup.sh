#!/usr/bin/env bash
# Install packages and dotfiles for one window manager.
#
# Every package comes from the enabled repos (cachyos / core / extra /
# multilib). Nothing is ever built from the AUR: paru is installed as an
# ordinary package so pacman keeps it updated, but this script never calls it.

set -euo pipefail

_setup_dir=$(builtin cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$_setup_dir/lib/common.sh"

WM=""
SKIP_PACKAGES=0
SKIP_STOW=0

usage() {
    cat <<EOF
Usage: $(basename "$0") [options]

  --wm <name>       window manager to install, skips the menu
  --list            list the known window managers and exit
  --dry-run         print what would happen, change nothing
  --skip-packages   only stow the dotfiles
  --skip-stow       only install packages
  -h, --help        this message

Window managers: $(wm_names | tr '\n' ' ')
EOF
}

while [ "$#" -gt 0 ]; do
    case "$1" in
    --wm)
        [ "$#" -ge 2 ] || die "--wm needs a value"
        WM=$2
        shift 2
        ;;
    --wm=*)
        WM=${1#*=}
        shift
        ;;
    --list)
        wm_names
        exit 0
        ;;
    --dry-run)
        DRY_RUN=1
        shift
        ;;
    --skip-packages)
        SKIP_PACKAGES=1
        shift
        ;;
    --skip-stow)
        SKIP_STOW=1
        shift
        ;;
    -h | --help)
        usage
        exit 0
        ;;
    *) die "unknown option: $1 (try --help)" ;;
    esac
done

# --- pick a window manager ---------------------------------------------
if [ -z "$WM" ]; then
    mapfile -t choices < <(wm_names)
    [ "${#choices[@]}" -gt 0 ] || die "no window managers defined in $WMS_CONF"

    banner "Select your Window Manager"
    select choice in "${choices[@]}"; do
        if [ -n "${choice:-}" ]; then
            WM=$choice
            break
        fi
        echo "Invalid selection. Please try again."
    done
    # select falls through on EOF (^D) without setting a choice.
    [ -n "$WM" ] || die "no window manager selected"
fi

wm_is_known "$WM" || die "unknown window manager: $WM (see --list)"

[ "$DRY_RUN" = 1 ] && info "dry run: nothing will be changed"
info "window manager: $WM"

# --- packages ----------------------------------------------------------
if [ "$SKIP_PACKAGES" = 0 ]; then
    banner "Resolving packages for $WM"

    packages=()
    mapfile -t packages < <(read_pkgs "$PACKAGES_DIR/core.packages")
    for list in $(wm_field "$WM" 2); do
        mapfile -t -O "${#packages[@]}" packages \
            < <(read_pkgs "$PACKAGES_DIR/$list.packages")
    done

    [ "${#packages[@]}" -gt 0 ] || die "no packages resolved; check $PACKAGES_DIR"
    info "${#packages[@]} packages: ${packages[*]}"

    banner "Verifying every package is in an enabled repo"
    verify_pkgs "${packages[@]}"

    banner "Installing packages"
    keep_sudo
    trap drop_sudo EXIT
    pac_install "${packages[@]}"

    banner "Installing user scripts"
    local_bin="$HOME/.local/bin"
    run mkdir -p "$local_bin"
    for script in "$_setup_dir"/scripts/*; do
        [ -f "$script" ] || continue
        run install -m 755 "$script" "$local_bin/$(basename "$script")"
    done

    banner "Installing web apps"
    while IFS='|' read -r name url; do
        [ -n "$name" ] || continue
        run "$local_bin/webapps" "$name" "$url"
    done <<'APPS'
OSRS Wiki|https://oldschool.runescape.wiki/
RS3 Wiki|https://runescape.wiki/
WhatsApp Web|https://web.whatsapp.com/
ChatGPT|https://www.chatgpt.com/
Discord|https://www.discord.com/
YouTube|https://www.youtube.com/
APPS
fi

# --- dotfiles ----------------------------------------------------------
if [ "$SKIP_STOW" = 0 ]; then
    # dot-stow reads DRY_RUN itself, so it reports its own actions.
    DRY_RUN=$DRY_RUN "$_setup_dir/scripts/dot-stow" stow "$WM"
fi

banner "Installation complete"
