#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
DRY_RUN=false

if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "=== DRY RUN (no changes will be made) ==="
    echo
fi

link_file() {
    local src="$1" dest="$2"

    if [[ "$DRY_RUN" == true ]]; then
        echo "[dry-run] $src -> $dest"
        return
    fi

    mkdir -p "$(dirname "$dest")"

    if [[ -e "$dest" && ! -L "$dest" ]]; then
        echo "Backing up $dest -> ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi

    ln -sf "$src" "$dest"
    echo "Linked $src -> $dest"
}

# config/* -> ~/.config/*
for item in "$DOTFILES"/config/*/; do
    app="$(basename "$item")"
    for file in "$item"*; do
        [[ -f "$file" ]] || continue
        link_file "$file" "$HOME/.config/$app/$(basename "$file")"
    done
done

# home/* -> ~/*
for file in "$DOTFILES"/home/.*; do
    [[ -f "$file" ]] || continue
    link_file "$file" "$HOME/$(basename "$file")"
done

# etc/ — warn only
echo
echo "NOTE: etc/ssh/sshd_config requires root to install."
echo "  sudo cp $DOTFILES/etc/ssh/sshd_config /etc/ssh/sshd_config"
echo

# Skipped directories
echo "Skipped (manual):"
echo "  kde-profiles/ — import via KDE System Settings"
echo "  wallpaper/    — place manually"
echo "  system/       — package lists for reference only"
