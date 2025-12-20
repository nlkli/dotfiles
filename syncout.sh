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

sync_dir "nvim config" "$IN_NVIM_CONFIG_DIR" "$OUT_NVIM_CONFIG_DIR"
sync_dir "alacritty config" "$IN_ALACRITTY_CONFIG_DIR" "$OUT_ALACRITTY_CONFIG_DIR"
sync_dir "yazi config" "$IN_YAZI_CONFIG_DIR" "$OUT_YAZI_CONFIG_DIR"
sync_file ".vimrc" "$IN_VIMRC_CONFIG_FILE" "$OUT_VIMRC_CONFIG_FILE"
sync_file ".gitconfig" "$IN_GITCONFIG_CONFIG_FILE" "$OUT_GITCONFIG_CONFIG_FILE"
sync_file ".zshrc" "$IN_ZSHRC_CONFIG_FILE" "$OUT_ZSHRC_CONFIG_FILE"
sync_file ".tmux.conf" "$IN_TMUX_CONFIG_FILE" "$OUT_TMUX_CONFIG_FILE"
