export PATH="$HOME/.cargo/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export PATH="$(echo "$PATH" | awk -v RS=':' '!a[$1]++ {printf "%s%s", sep, $1; sep=":"}')"

export TERM="xterm-256color"
export EDITOR="vim"
export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"
export XDG_CONFIG_HOME="$HOME/.config"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESS="-R -F -X"
export PAGER="less"
export COLORTERM="truecolor"
export MANPAGER="$EDITOR +Man!"

alias e="$EDITOR"
alias c="clear"
alias q="exit"
alias ls="ls --color=auto"
alias ll="ls -lah"
alias bat="bat --theme=ansi"

HISTFILE="$HOME/.bash_history"
HISTSIZE=10000
HISTFILESIZE=10000

HISTCONTROL="ignoreboth"

shopt -s histappend

bind 'set bell-style none'

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

set -o vi

bind -m vi-insert '"\C-r"': reverse-search-history
bind -m vi-insert '"\C-p"': history-search-backward
bind -m vi-insert '"\C-n"': history-search-forward

function imgview() {
    ffplay -loglevel quiet -noborder -infbuf -loop 0 "$@"
}

function y() {
    local tmp
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
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
