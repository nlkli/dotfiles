# dotfiles

Personal configuration files managed with a simple sync script.

## Usage

```bash
# Apply configs from repo to system
./sync in

# Save system configs to repo
./sync out
```

## Structure

```text
.
├── config
│   ├── alacritty
│   │   └── alacritty.toml
│   ├── ghostty
│   │   ├── config.ghostty
│   │   └── shaders
│   │       ├── cursor_sweep.glsl
│   │       ├── cursor_tail.glsl
│   │       ├── cursor_warp.glsl
│   │       ├── rectangle_boom_cursor.glsl
│   │       ├── ripple_cursor.glsl
│   │       ├── ripple_rectangle_cursor.glsl
│   │       └── sonic_boom_cursor.glsl
│   ├── nvim
│   │   ├── init.lua
│   │   └── nvim-pack-lock.json
│   └── yazi
│       ├── keymap.toml
│       └── yazi.toml
├── README.md
└── sync
```
