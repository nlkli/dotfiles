# --------------------------------------------------
# Environment
# --------------------------------------------------

typeset -U PATH
export PATH="$HOME/.cargo/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export TERM="xterm-256color"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"
export XDG_CONFIG_HOME="$HOME/.config"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export HOMEBREW_NO_ANALYTICS=1
export LESS="-R -F -X"
export PAGER="less"
export COLORTERM="truecolor"
export MANPAGER="nvim +Man!"

# --------------------------------------------------
# Aliases
# --------------------------------------------------

alias e="$EDITOR"
alias c="clear"
alias q="exit"
alias ls="ls --color=auto"
alias ll="ls -lah"
alias bat="bat --theme=ansi"
if command -v python3.14 >/dev/null 2>&1; then
    alias python="python3.14"
fi

# --------------------------------------------------
# History
# --------------------------------------------------

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# --------------------------------------------------
# Shell behavior
# --------------------------------------------------

setopt NOBEEP
setopt NUMERIC_GLOB_SORT

# --------------------------------------------------
# Completion
# --------------------------------------------------

autoload -Uz compinit

if [[ -n "$HOME/.zcompdump"(#qN.mh+24) ]]; then
    compinit -C
else
    compinit
fi

# --------------------------------------------------
# Prompt and Git status
# --------------------------------------------------

autoload -Uz colors vcs_info add-zsh-hook

colors

setopt PROMPT_SUBST

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' formats ':%F{yellow}%b%c%u%f'


function update_prompt() {
    vcs_info
    local venv=""
    [[ -n "$VIRTUAL_ENV" ]] && \
        venv="%F{green}(${VIRTUAL_ENV:t})%f "
    PROMPT="${venv}%F{green}%n@%m%f:%F{blue}%~%f${vcs_info_msg_0_}
%(#.%F{red}.%F{cyan})>%f "
}

add-zsh-hook precmd update_prompt

# --------------------------------------------------
# Vi mode
# --------------------------------------------------

bindkey -v

KEYTIMEOUT=1

bindkey '^r' history-incremental-search-backward
bindkey '^p' up-line-or-history
bindkey '^n' down-line-or-history
bindkey '^y' copy-prompt-line-to-clipboard

function zle-keymap-select() {
    if [[ "$KEYMAP" == vicmd ]]; then
        RPS1="%F{red}N%f"
    else
        RPS1="%F{green}I%f"
    fi
    zle reset-prompt
}

zle -N zle-keymap-select

bindkey -M viins '^?' backward-delete-char

# --------------------------------------------------
# Clipboard integration
# --------------------------------------------------

if command -v pbcopy >/dev/null 2>&1; then
    alias clipcopy="pbcopy"
    alias clippaste="pbpaste"
elif command -v wl-copy >/dev/null 2>&1; then
    alias clipcopy="wl-copy"
    alias clippaste="wl-paste"
elif command -v xclip >/dev/null 2>&1; then
    alias clipcopy="xclip -selection clipboard"
    alias clippaste="xclip -selection clipboard -o"
elif command -v xsel >/dev/null 2>&1; then
    alias clipcopy="xsel --clipboard --input"
    alias clippaste="xsel --clipboard --output"
elif command -v clip.exe >/dev/null 2>&1; then
    alias clipcopy="clip.exe"
    alias clippaste="powershell.exe -command Get-Clipboard"
fi

if command -v clipcopy >/dev/null 2>&1; then
    function vi-yank-clipboard() {
        zle vi-yank
        print -rn -- "$CUTBUFFER" | clipcopy
    }

    function vi-put-clipboard-after() {
        CUTBUFFER="$(clippaste)"
        zle vi-put-after
    }

    function vi-put-clipboard-before() {
        CUTBUFFER="$(clippaste)"
        zle vi-put-before
    }

    function copy-prompt-line-to-clipboard() {
        local line="${LBUFFER}${RBUFFER}"
        print -rn -- "$line" | clipcopy
    }

    zle -N vi-yank-clipboard
    zle -N vi-put-clipboard-after
    zle -N vi-put-clipboard-before
    zle -N copy-prompt-line-to-clipboard

    bindkey -M vicmd '^y' vi-yank-clipboard
    bindkey -M vicmd '^p' vi-put-clipboard-after
    bindkey -M vicmd '^P' vi-put-clipboard-before
fi

# --------------------------------------------------
# Utilities
# --------------------------------------------------

function imgview() {
    ffplay -loglevel quiet -noborder -infbuf -loop 0 "$@"
}

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    local cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    if [[ "$cwd" != "$PWD" && -d "$cwd" ]]; then
        builtin cd -- "$cwd"
    fi
    command rm -f -- "$tmp"
}

# --------------------------------------------------
# LS_COLORS
# --------------------------------------------------

export LS_COLORS="di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:ex=01;32:*.tar=01;31:*.tgz=01;31:*.gz=01;31:*.bz2=01;31:*.xz=01;31:*.zst=01;31:*.zip=01;31:*.rar=01;31:*.7z=01;31:*.iso=01;31:*.jpg=01;35:*.jpeg=01;35:*.png=01;35:*.gif=01;35:*.webp=01;35:*.svg=01;35:*.ico=01;35:*.mp3=00;36:*.flac=00;36:*.wav=00;36:*.m4a=00;36:*.mp4=00;36:*.mkv=00;36:*.webm=00;36:*.pdf=01;33:*.doc=01;33:*.docx=01;33:*.odt=01;33:*.xls=01;33:*.xlsx=01;33:*.ppt=01;33:*.pptx=01;33:*.md=01;33:*.txt=01;33:*.c=01;32:*.h=01;32:*.cpp=01;32:*.hpp=01;32:*.rs=01;32:*.go=01;32:*.py=01;32:*.js=01;32:*.ts=01;32:*.java=01;32:*.kt=01;32:*.sh=01;32:*.zsh=01;32:*.html=01;32:*.css=01;32:*.conf=00;33:*.cfg=00;33:*.ini=00;33:*.toml=00;33:*.yaml=00;33:*.yml=00;33:*.json=00;33:*.xml=00;33:*.sql=00;36:*.db=00;36:*.sqlite=00;36:*.tmp=00;90:*.temp=00;90:*.bak=00;90:*.old=00;90:*.log=00;90"
