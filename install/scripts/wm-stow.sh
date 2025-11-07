#!/usr/bin/env bash

set -eo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
PROJECT_ROOT=$(dirname "$(dirname "$SCRIPT_DIR")")

ACTION=$1
WM=$2

if [ -z "$ACTION" ] || [ -z "$WM" ]; then
    echo "Usage: $0 <stow|unstow> <wm_name>"
    exit 1
fi

CORE_DIR="$PROJECT_ROOT/core"
WM_DIR="$PROJECT_ROOT/wms/$WM"

if [ ! -d "$WM_DIR" ]; then
    echo "Error: Window manager '$WM' not found in '$PROJECT_ROOT/wms'."
    exit 1
fi

# Handle core packages
cd "$CORE_DIR" || exit
case "$ACTION" in
    stow)
        echo "Stowing core packages..."
        stow -t "$HOME" -v */
        ;;
    unstow)
        echo "Unstowing core packages..."
        stow -D -t "$HOME" -v */
        ;;
    *)
        echo "Error: Invalid action '$ACTION'. Use 'stow' or 'unstow'."
        exit 1
        ;;
esac
echo "Action '$ACTION' for core packages completed."
echo ""

# Handle window manager packages
cd "$WM_DIR" || exit
case "$ACTION" in
    stow)
        echo "Stowing packages for $WM..."
        stow -t "$HOME" -v */
        ;;
    unstow)
        echo "Unstowing packages for $WM..."
        stow -D -t "$HOME" -v */
        ;;
    *)
        echo "Error: Invalid action '$ACTION'. Use 'stow' or 'unstow'."
        exit 1
        ;;
esac

echo "Action '$ACTION' for '$WM' completed."
