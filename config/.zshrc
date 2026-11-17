[ -n "$ZSH_VERSION" ] && typeset -U PATH path
addpath() {
    local pos=pre
    [ "$1" = "-a" ] && { pos=app; shift; }
    [ -d "$1" ] || return 0
    case ":$PATH:" in
        *":$1:"*) return 0 ;;
    esac
    if [ "$pos" = pre ]; then PATH="$1:$PATH"; else PATH="$PATH:$1"; fi
}
# mark/lable/block !path
export GOPATH="${GOPATH:-$HOME/go}"
export CARGO_HOME="${CARGO_HOME:-$HOME/.cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-$HOME/.rustup}"
addpath /usr/local/go/bin
addpath /home/linuxbrew/.linuxbrew/bin
addpath /opt/homebrew/bin
addpath /usr/local/bin
addpath "$GOPATH/bin"
addpath "$CARGO_HOME/bin"
addpath "$HOME/bin"
addpath "$HOME/.local/bin"
export PATH
if   command -v nvim >/dev/null 2>&1; then EDITOR=nvim
elif command -v vim  >/dev/null 2>&1; then EDITOR=vim
elif command -v vi  >/dev/null 2>&1; then EDITOR=vi
else EDITOR=nano; fi
export EDITOR
export VISUAL="$EDITOR"
# export LANG="${LANG:-en_US.UTF-8}"
export PAGER="less"
export LESS="-R -F -X -i -M"
export MANPAGER="less"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
if [ -t 0 ]; then
    export GPG_TTY="$(tty)"
fi
export BAT_THEME="ansi" 
export HOMEBREW_NO_ANALYTICS=1
export PI_TELEMETRY=0
export PENV="$HOME/.penv"
if [ -f "$PENV" ]; then
    set -a
    source "$PENV"
    set +a
fi
# mark/lable/block !llama
export LLAMA_MODELS_DIR=$HOME/.local/llama.cpp.models
export LLAMA_SERVER_PORT=8888
export LLAMA_BASE_URL=http://127.0.0.1:$LLAMA_SERVER_PORT
export LLAMA_API_KEY=
export LLAMA_CTX_SIZE=99999 #25000
run-llama-server() {
    llama-server \
        --port $LLAMA_SERVER_PORT \
        --models-dir $LLAMA_MODELS_DIR \
        --no-models-autoload \
        --jinja \
        -ngl 999 \
        --ctx-size $LLAMA_CTX_SIZE \
        --sleep-idle-seconds 4200
}
# mark/lable/block !alias
alias e="${EDITOR:-vim}"
alias c="clear"
alias q="exit"
alias R='exec "$SHELL" -l'
alias E='$EDITOR "$HOME/.$(basename "$SHELL")rc"'
alias h="fc -l -20"
alias ll="ls -lah"
alias la="ls -A"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"    
if ls --color=auto >/dev/null 2>&1; then
    alias ls="ls --color=auto"
else
    alias ls="ls -G"
fi
if grep --color=auto -e '' /dev/null >/dev/null 2>&1; then
    alias grep='grep --color=auto'
fi
if diff --color=auto /dev/null /dev/null >/dev/null 2>&1; then
    alias diff='diff --color=auto'
fi
command -v batcat >/dev/null 2>&1 && ! command -v bat >/dev/null 2>&1 && alias bat="batcat"
alias g="git"
# mark/lable/block !options !hist
HISTSIZE=100000
HISTFILESIZE=100000   # bash
SAVEHIST=100000       # zsh
if [ -n "$ZSH_VERSION" ]; then
    HISTFILE="$HOME/.zsh_history"
    setopt SHARE_HISTORY
    setopt EXTENDED_HISTORY
    setopt INC_APPEND_HISTORY
    setopt HIST_IGNORE_ALL_DUPS
    setopt HIST_IGNORE_SPACE
    setopt HIST_REDUCE_BLANKS
    setopt HIST_SAVE_NO_DUPS
    setopt HIST_FCNTL_LOCK
    setopt HIST_VERIFY
    setopt INTERACTIVE_COMMENTS
    unsetopt FLOW_CONTROL

    autoload -Uz compinit
    if [[ -n "$HOME/.zcompdump"(#qN.mh+24) ]]; then
        compinit -C
    else
        compinit
    fi

    unsetopt BEEP

    bindkey -v
    KEYTIMEOUT=1

    bindkey -M viins "^R" history-incremental-search-backward
    bindkey -M viins "^P" history-beginning-search-backward
    bindkey -M viins "^N" history-beginning-search-forward
    bindkey -M viins "^L" clear-screen
    bindkey -M viins "^?" backward-delete-char

    autoload -Uz edit-command-line
    zle -N edit-command-line
    bindkey -M vicmd "z" edit-command-line

    setopt PROMPT_SUBST
    autoload -Uz add-zsh-hook vcs_info
    autoload -Uz colors
    colors
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr '+'
    zstyle ':vcs_info:git:*' unstagedstr '*'
    zstyle ':vcs_info:git:*' formats ':%F{yellow}%b%c%u%f'
    zstyle ':vcs_info:git:*' actionformats ':%F{yellow}%b|%a%c%u%f'
    update_prompt() {
        vcs_info
        local venv=""
        if [[ -n "$VIRTUAL_ENV" ]]; then
            venv="%F{magenta}(${VIRTUAL_ENV:t})%f "
        fi
        local user_host="%F{green}%n@%m%f"
        local cwd="%F{blue}%~%f"
        local git="${vcs_info_msg_0_}"
        local symbol="%(#.%F{red}.%F{cyan})>%f"
        PROMPT="${venv}${user_host}:${cwd}${git}"$'\n'"${symbol} "
    }
    add-zsh-hook precmd update_prompt
elif [ -n "$BASH_VERSION" ]; then
    HISTFILE="$HOME/.bash_history"
    HISTCONTROL=ignoreboth:erasedups
    HISTTIMEFORMAT='%F %T  '
    HISTIGNORE='ls:ll:la:pwd:exit:clear:c'
    shopt -s cmdhist
    shopt -s lithist
    shopt -s checkwinsize
    shopt -s histappend
    case ";$PROMPT_COMMAND;" in
        *"history -a"*) ;;
        *) PROMPT_COMMAND="history -a${PROMPT_COMMAND:+; $PROMPT_COMMAND}" ;;
    esac
    [ -t 0 ] && stty -ixon

    if ! shopt -oq posix && [ -z "${BASH_COMPLETION_VERSINFO-}" ]; then
        if   [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        elif [ "${BASH_VERSINFO[0]}" -ge 4 ] && [ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
            . /opt/homebrew/etc/profile.d/bash_completion.sh
        elif [ "${BASH_VERSINFO[0]}" -ge 4 ] && [ -f /usr/local/etc/profile.d/bash_completion.sh ]; then
            . /usr/local/etc/profile.d/bash_completion.sh
        fi
    fi

    bind "set bell-style none"
    bind "set completion-ignore-case on"
    bind "set show-all-if-ambiguous on"

    set -o vi
    bind -m vi-insert '"\C-r": reverse-search-history'
    bind -m vi-insert '"\C-p": history-search-backward'
    bind -m vi-insert '"\C-n": history-search-forward'
    bind -m vi-insert '"\C-l": clear-screen'
fi
export HISTFILE HISTSIZE
# mark/lable/block !functions
mkcd() {
    mkdir -p -- "$1" && cd -- "$1"
}
duh() {
    du -sh ./* ./.??* 2>/dev/null | sort -h
}
extract() {
    [ "$#" -eq 1 ] && [ -f "$1" ] || {
        echo "Usage: extract <archive>" >&2
        return 1
    }
    case "$1" in
        *.tar.bz2|*.tbz2) tar xjf "$1" ;;
        *.tar.gz|*.tgz)   tar xzf "$1" ;;
        *.tar.xz|*.txz)   tar xJf "$1" ;;
        *.tar.zst|*.tzst) tar --zstd -xf "$1" ;;
        *.tar)            tar xf "$1" ;;
        *.zip)            unzip "$1" ;;
        *.7z)             7z x "$1" ;;
        *.rar)            unrar x "$1" ;;
        *.gz)             gunzip "$1" ;;
        *.bz2)            bunzip2 "$1" ;;
        *.xz)             unxz "$1" ;;
        *.zst)            zstd -d "$1" ;;
        *.lz4)            lz4 -d "$1" ;;
        *) echo "Unknown archive format: $1" >&2; return 1 ;;
    esac
}
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
    if [[ "$1" == "main" ]]; then
        tmux new -A -s main
        return 0
    fi
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
update() {
    local failed=0
    if command -v brew >/dev/null 2>&1; then
        brew upgrade && brew cleanup || failed=1
    fi
    if [ -f /etc/debian_version ] && command -v apt-get >/dev/null 2>&1; then
        if [ "$(id -u)" -eq 0 ]; then
            apt-get update && apt-get upgrade -y || failed=1
        elif command -v sudo >/dev/null 2>&1; then
            sudo apt-get update && sudo apt-get upgrade -y || failed=1
        else
            echo "update: sudo not found" >&2
            failed=1
        fi
    fi
    if command -v rustup >/dev/null 2>&1; then
        rustup update || failed=1
    fi
    if command -v pi >/dev/null 2>&1; then
        pi update && pi update --extensions || failed=1
    fi
    return "$failed"
}
clang-format-init() {
  local target="${1:-.clang-format}"

  [ -e "$target" ] && return 0

  cat > "$target" <<'EOF'
Language: Cpp
BasedOnStyle: Google

IndentWidth: 4
TabWidth: 4
UseTab: Never
ColumnLimit: 120
ContinuationIndentWidth: 4

BreakBeforeBraces: Attach
AllowShortFunctionsOnASingleLine: Inline
AllowShortIfStatementsOnASingleLine: WithoutElse
AllowShortLoopsOnASingleLine: false
AllowShortBlocksOnASingleLine: Empty
IndentCaseLabels: true

PointerAlignment: Left
ReferenceAlignment: Left
DerivePointerAlignment: false

SortIncludes: CaseSensitive
IncludeBlocks: Regroup
IncludeCategories:
  - Regex: '^".*\.h"$'
    Priority: 1
  - Regex: '^"'
    Priority: 2
  - Regex: '^<.*>'
    Priority: 3

AlwaysBreakTemplateDeclarations: Yes
BreakConstructorInitializers: BeforeColon

ReflowComments: true
FixNamespaceComments: true
SpacesBeforeTrailingComments: 2
MaxEmptyLinesToKeep: 1

AlignConsecutiveAssignments: false
AlignConsecutiveDeclarations: false
AlignTrailingComments: false
EOF
}
# mark/lable/block !lscolor
LS_COLORS="rs=0:no=00:fi=00"
LS_COLORS+=":di=01;34"
LS_COLORS+=":ln=01;36"
LS_COLORS+=":or=01;31;40"
LS_COLORS+=":mi=01;31;40"
LS_COLORS+=":ex=01;32"
LS_COLORS+=":pi=33:so=01;35:do=01;35"
LS_COLORS+=":bd=33;01:cd=33;01"
LS_COLORS+=":su=01;37;41:sg=01;30;43:ca=00"
LS_COLORS+=":tw=30;42:ow=01;34;04:st=37;44"
for e in tar tgz tbz tbz2 txz gz bz2 xz zst lz4 lzma zip rar 7z iso img dmg \
         deb rpm pkg apk jar war whl cab; do
    LS_COLORS+=":*.$e=01;31"
done
for e in jpg jpeg png gif webp svg ico bmp tif tiff avif heic psd ai; do
    LS_COLORS+=":*.$e=01;35"
done
for e in mp3 flac wav m4a ogg opus aac mp4 mkv webm mov avi flv wmv; do
    LS_COLORS+=":*.$e=00;36"
done
for e in pdf doc docx odt rtf epub xls xlsx ods ppt pptx odp md rst adoc tex txt; do
    LS_COLORS+=":*.$e=01;33"
done
LS_COLORS+=":*README=01;33:*LICENSE=01;33:*CHANGELOG=01;33"
for e in c h cpp hpp cc cs java kt scala swift go rs py rb php lua ex exs \
         js jsx ts tsx vue svelte html css scss less \
         sh bash zsh fish ps1 bat vim nix; do
    LS_COLORS+=":*.$e=01;32"
done
LS_COLORS+=":*Makefile=01;32:*Dockerfile=01;32:*Justfile=01;32"
for e in conf cfg ini toml yaml yml json jsonc xml env properties; do
    LS_COLORS+=":*.$e=00;33"
done
for e in csv tsv jsonl sql db sqlite sqlite3 ipynb parquet; do
    LS_COLORS+=":*.$e=00;36"
done
for e in pem key crt cer gpg asc pub; do
    LS_COLORS+=":*.$e=00;31"
done
for e in tmp temp bak old orig swp swo log lock map o a so class pyc pyo; do
    LS_COLORS+=":*.$e=90"
done
LS_COLORS+=":*~=90:*.min.js=90:*.min.css=90:*.gitignore=90:*.DS_Store=90"
unset e
export LS_COLORS
if [ -n "$ZSH_VERSION" ]; then
    zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
elif [ -n "$BASH_VERSION" ]; then
    bind "set colored-stats on"
    bind "set colored-completion-prefix on"
fi
