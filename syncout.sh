#!/usr/bin/env bash

set -e
source ./targets.env

log() {
    printf "%-20s %s\n" "$1" "$2"
}

sync_dir() {
    local name="$1"
    local src="$2"
    local dst="$3"

    if [[ ! -d "$src" ]]; then
        log "$name" "[missing source]"
        return
    fi

    mkdir -p "$dst"

    if diff -rq "$src" "$dst" >/dev/null 2>&1; then
        log "$name" "[up-to-date]"
    else
        cp -rf "$src/." "$dst"
        log "$name" "[updated]"
    fi
}

sync_file() {
    local name="$1"
    local src="$2"
    local dst="$3"

    if [[ ! -f "$src" ]]; then
        log "$name" "[missing source]"
        return
    fi

    mkdir -p "$(dirname "$dst")"

    if [[ ! -f "$dst" ]]; then
        touch "$dst"
    fi

    if diff -q "$src" "$dst" >/dev/null 2>&1; then
        log "$name" "[up-to-date]"
    else
        cp -f "$src" "$dst"
        log "$name" "[updated]"
    fi
}

sync_dir  "nvim"       "$IN_NVIM_CONFIG_DIR"       "$OUT_NVIM_CONFIG_DIR"
sync_dir  "alacritty"  "$IN_ALACRITTY_CONFIG_DIR"  "$OUT_ALACRITTY_CONFIG_DIR"
sync_dir  "ghostty"    "$IN_GHOSTTY_CONFIG_DIR"    "$OUT_GHOSTTY_CONFIG_DIR"
sync_dir  "yazi"       "$IN_YAZI_CONFIG_DIR"       "$OUT_YAZI_CONFIG_DIR"

sync_file ".vimrc"     "$IN_VIMRC_CONFIG_FILE"     "$OUT_VIMRC_CONFIG_FILE"
sync_file ".gitconfig" "$IN_GITCONFIG_CONFIG_FILE" "$OUT_GITCONFIG_CONFIG_FILE"
sync_file ".zshrc"     "$IN_ZSHRC_CONFIG_FILE"     "$OUT_ZSHRC_CONFIG_FILE"
sync_file ".tmux.conf" "$IN_TMUX_CONFIG_FILE"      "$OUT_TMUX_CONFIG_FILE"
