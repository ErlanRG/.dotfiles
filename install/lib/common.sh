#!/usr/bin/env bash
# Shared helpers for the dotfiles installer.
# Sourced by install/setup.sh and install/scripts/dot-stow -- never executed.

# Repo paths are resolved from this file's own location, so the caller's
# working directory never matters.
_common_dir=$(builtin cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
INSTALL_DIR=$(dirname "$_common_dir")
DOTFILES_ROOT=$(dirname "$INSTALL_DIR")
PACKAGES_DIR="$INSTALL_DIR/packages"
WMS_CONF="$INSTALL_DIR/wms.conf"
unset _common_dir

DRY_RUN=${DRY_RUN:-0}

banner() {
    echo ""
    echo "+----------------------------------------------------------------+"
    printf "| %-62s |\n" "$1"
    echo "+----------------------------------------------------------------+"
    echo ""
}

info() { printf '  %s\n' "$*"; }
warn() { printf '  warning: %s\n' "$*" >&2; }
die() {
    printf '  error: %s\n' "$*" >&2
    exit 1
}

# run <cmd...> -- execute the command, or print it under --dry-run.
run() {
    if [ "$DRY_RUN" = 1 ]; then
        printf '  [dry-run] %s\n' "$*"
    else
        "$@"
    fi
}

# read_pkgs <file> -- one package name per line, comments and blanks stripped.
# Call as: mapfile -t arr < <(read_pkgs "$file")
read_pkgs() {
    local file=$1
    [ -f "$file" ] || die "package list not found: $file"
    sed -e 's/#.*//' -e 's/[[:space:]]//g' "$file" | grep -v '^$' || true
}

# pac_install <pkgs...> -- install via pacman, or do nothing when given no
# packages. The empty-argument guard is deliberate: passing an empty list to
# pacman is what used to abort the whole installer.
pac_install() {
    if [ "$#" -eq 0 ]; then
        warn "no packages to install; skipping pacman"
        return 0
    fi
    run sudo pacman -S --noconfirm --needed "$@"
}

# verify_pkgs <pkgs...> -- fail up front if anything is missing from the
# enabled repos, listing every offender rather than dying on the first.
verify_pkgs() {
    local missing=() p
    for p in "$@"; do
        pacman -Si -- "$p" &>/dev/null || missing+=("$p")
    done
    if [ "${#missing[@]}" -gt 0 ]; then
        warn "not available in any enabled repo:"
        printf '    - %s\n' "${missing[@]}" >&2
        die "refusing to continue; this installer never builds from the AUR"
    fi
    info "all $# packages resolve in the enabled repos"
}

# keep_sudo -- authenticate once and refresh in the background, so the run
# does not stop for a password halfway through.
keep_sudo() {
    [ "$DRY_RUN" = 1 ] && return 0
    sudo -v || die "sudo authentication failed"
    while true; do
        sudo -n true 2>/dev/null || true
        sleep 60
        kill -0 "$$" 2>/dev/null || exit 0
    done &
    SUDO_KEEPALIVE_PID=$!
}

drop_sudo() {
    [ -n "${SUDO_KEEPALIVE_PID:-}" ] && kill "$SUDO_KEEPALIVE_PID" 2>/dev/null
    return 0
}

# --- wms.conf accessors -------------------------------------------------
# Format, one WM per line:  name | extra package lists | stow packages

_wms_body() { sed -e 's/#.*//' "$WMS_CONF"; }

wm_names() {
    _wms_body | awk -F'|' '{ gsub(/[[:space:]]/,"",$1); if (NF>=3 && $1!="") print $1 }'
}

# wm_field <name> <field-number>
wm_field() {
    _wms_body | awk -F'|' -v w="$1" -v f="$2" '
        { key=$1; gsub(/[[:space:]]/,"",key) }
        key==w { gsub(/^[[:space:]]+|[[:space:]]+$/,"",$f); print $f; exit }'
}

wm_is_known() {
    local n
    while read -r n; do [ "$n" = "$1" ] && return 0; done < <(wm_names)
    return 1
}
