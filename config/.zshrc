export PATH="$HOME/.cargo/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
typeset -U PATH
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
export MANPAGER="$EDITOR +Man!"
export PRIVATE_GLOG_ENV_FILE="$HOME/.private_glob.env"
if [ -f "$PRIVATE_GLOG_ENV_FILE" ]; then
    set -a
    source "$PRIVATE_GLOG_ENV_FILE"
    set +a
fi

alias e="$EDITOR"
alias c="clear"
alias q="exit"
alias R="exec $SHELL"
alias E="$EDITOR $HOME/.zshrc"
alias ls="ls --color=auto"
alias ll="ls -lah"
alias bat="bat --theme=ansi -p"
if command -v python3.14 >/dev/null 2>&1; then
    alias python="python3.14"
fi

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
setopt NOBEEP
setopt NUMERIC_GLOB_SORT

autoload -Uz compinit

if [[ -n "$HOME/.zcompdump"(#qN.mh+24) ]]; then
    compinit -C
else
    compinit
fi

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

bindkey -v

KEYTIMEOUT=1

bindkey '^r' history-incremental-search-backward
bindkey '^y' copy-prompt-line-to-clipboard

bindkey -M viins '^?' backward-delete-char

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

imgview() {
    ffplay -loglevel quiet -noborder -infbuf -loop 0 "$@"
}

y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    local cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    if [[ "$cwd" != "$PWD" && -d "$cwd" ]]; then
        builtin cd -- "$cwd"
    fi
    command rm -f -- "$tmp"
}

myip() {
    local out

    local curl_args=(
        curl
        -fsSL
        --max-time 3
        --retry 1
    )

    out=$(
        "${curl_args[@]}" https://api.myip.com 2>/dev/null |
        jq -er '"\(.ip)\n\(.country), \(.cc)"'
    ) && {
        printf '%s\n' "$out"
        return 0
    }

    out=$(
        "${curl_args[@]}" https://ipwho.is/ 2>/dev/null |
        jq -er 'select(.success == true) |
                "\(.ip)\n\(.country), \(.country_code)"'
    ) && {
        printf '%s\n' "$out"
        return 0
    }

    out=$(
        "${curl_args[@]}" https://ipapi.co/json/ 2>/dev/null |
        jq -er '"\(.ip)\n\(.country_name), \(.country_code)"'
    ) && {
        printf '%s\n' "$out"
        return 0
    }

    echo "Error: failed to retrieve IP information from all sources." >&2
    return 1
}

sysinfo() {
    local json
    json=$(fastfetch -j)

    local info
    info=$(echo "$json" | jq -r '
    [
        (.[] | select(.type=="OS") | .result.prettyName),
        (.[] | select(.type=="Host") | .result.name),
        (.[] | select(.type=="Kernel") | "\(.result.name) \(.result.release) (\(.result.architecture))")
    ] | join("; ")
    ')

    printf "%s\n%s\n" "$info" "$(uptime)"
    # myip | awk '{printf "%s%s", sep, $0; sep="; "} END {printf "\n"}'
}

rpass() {
    local num="${1:-1}"
    local len="${2:-32}"

    local curl_args=(
        curl
        -fsSL
        --max-time 5
        --retry 2
    )

    "${curl_args[@]}" \
        "https://www.random.org/passwords/?num=${num}&len=${len}&format=plain&rnd=new"
}

ts() {
    local project_dir="${1:-$PWD}"
    local session_name pane_left

    project_dir=$(realpath "$project_dir" 2>/dev/null)
    if [[ -z "$project_dir" || ! -d "$project_dir" ]]; then
        echo "devts: not a directory '$1'" >&2
        return 1
    fi

    session_name=$(basename "$project_dir" | tr '.: ' '_')

    if tmux has-session -t "$session_name" 2>/dev/null; then
        if [[ -n "$TMUX" ]]; then
            tmux switch-client -t "$session_name"
        else
            tmux attach -t "$session_name"
        fi
        return
    fi

    tmux new-session -d -s "$session_name" -n editor -c "$project_dir"

    # capture original pane id before split (this is the left pane)
    pane_left=$(tmux display-message -p -t "${session_name}:editor" '#{pane_id}')

    tmux send-keys -t "$pane_left" "$EDITOR ." C-m
    tmux split-window -h -t "${session_name}:editor" -p 37 -c "$project_dir"
    tmux send-keys -t "${session_name}:editor" "ls -lah" C-m

    tmux new-window -t "$session_name" -n shell -c "$project_dir"

    tmux select-window -t "${session_name}:editor"
    tmux select-pane -t "$pane_left"

    if [[ -n "$TMUX" ]]; then
        tmux switch-client -t "$session_name"
    else
        tmux attach -t "$session_name"
    fi
}

export LS_COLORS="di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:ex=01;32:*.tar=01;31:*.tgz=01;31:*.gz=01;31:*.bz2=01;31:*.xz=01;31:*.zst=01;31:*.zip=01;31:*.rar=01;31:*.7z=01;31:*.iso=01;31:*.jpg=01;35:*.jpeg=01;35:*.png=01;35:*.gif=01;35:*.webp=01;35:*.svg=01;35:*.ico=01;35:*.mp3=00;36:*.flac=00;36:*.wav=00;36:*.m4a=00;36:*.mp4=00;36:*.mkv=00;36:*.webm=00;36:*.pdf=01;33:*.doc=01;33:*.docx=01;33:*.odt=01;33:*.xls=01;33:*.xlsx=01;33:*.ppt=01;33:*.pptx=01;33:*.md=01;33:*.txt=01;33:*.c=01;32:*.h=01;32:*.cpp=01;32:*.hpp=01;32:*.rs=01;32:*.go=01;32:*.py=01;32:*.js=01;32:*.ts=01;32:*.java=01;32:*.kt=01;32:*.sh=01;32:*.zsh=01;32:*.html=01;32:*.css=01;32:*.conf=00;33:*.cfg=00;33:*.ini=00;33:*.toml=00;33:*.yaml=00;33:*.yml=00;33:*.json=00;33:*.xml=00;33:*.sql=00;36:*.db=00;36:*.sqlite=00;36:*.tmp=00;90:*.temp=00;90:*.bak=00;90:*.old=00;90:*.log=00;90"

sysinfo
