#!/usr/bin/env bash

set -e
source ./.env

sync_dir() {
    local name="$1"
    local src="$2"
    local dst="$3"
    
    if ! diff -rq "$src" "$dst" >/dev/null; then
        cp -rf "$src/." "$dst"
        echo "$name updated"
    fi
}

sync_file() {
    local name="$1"
    local src="$2"
    local dst="$3"
    
    if ! diff -q "$src" "$dst" >/dev/null; then
        cp -f "$src" "$dst"
        echo "$name updated"
    fi
}

sync_dir "nvim config" "$OUT_NVIM_CONFIG_DIR" "$IN_NVIM_CONFIG_DIR"
sync_dir "alacritty config" "$OUT_ALACRITTY_CONFIG_DIR" "$IN_ALACRITTY_CONFIG_DIR"
sync_dir "yazi config" "$OUT_YAZI_CONFIG_DIR" "$IN_YAZI_CONFIG_DIR"
sync_file ".vimrc" "$OUT_VIMRC_CONFIG_FILE" "$IN_VIMRC_CONFIG_FILE"
sync_file ".gitconfig" "$OUT_GITCONFIG_CONFIG_FILE" "$IN_GITCONFIG_CONFIG_FILE"
sync_file ".zshrc" "$OUT_ZSHRC_CONFIG_FILE" "$IN_ZSHRC_CONFIG_FILE"
sync_file ".tmux.conf" "$OUT_TMUX_CONFIG_FILE" "$IN_TMUX_CONFIG_FILE"
