# PATH
export NVIM_BOB_BIN="$HOME/.local/share/bob/nvim-bin"
export PATH="$NVIM_BOB_BIN:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin"
export PATH="$PATH:/usr/local/go/bin:$HOME/.cargo/bin"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="darkblood"
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 7
COMPLETION_WAITING_DOTS="true"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Secrets and machine-specific config (not in version control)
[ -f ~/.secrets ] && source ~/.secrets
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# SSH agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 8h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# GPG
export GPG_TTY=$(tty)

# Aliases
alias zshconfig="vim ~/.zshrc"
alias restartzsh="source ~/.zshrc"
alias vim=nvim
alias sudo="sudo "
alias fpr="git stash && git switch main && git pull && git stash pop"
alias cd="z"
alias cdi="zi"
alias lg="lazygit"
alias tree="tree -a -I .git --gitignore"
alias c="clear"
alias shotbot='python -m shot_bot --shoot-key north --live --policy timed --delay-ms 635'

# Modern CLI replacements (fall back silently until installed)
command -v eza >/dev/null && alias ls="eza --group-directories-first" && alias ll="eza -l --group-directories-first --git" && alias la="eza -la --group-directories-first --git"
command -v bat >/dev/null && alias cat="bat --paging=never"
export BAT_THEME="ansi"

# Noir colours for fzf and autosuggestions
export FZF_DEFAULT_OPTS="--color=bg+:#161618,bg:-1,spinner:#6b6b73,hl:#6e94b2,fg:#c9c9c9,header:#6b6b73,info:#6b6b73,pointer:#ececec,marker:#e8b589,fg+:#ececec,prompt:#6b6b73,hl+:#8ba9c1,border:#28282c --border=sharp --no-scrollbar"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6b6b73"

beersnap() {
  emulate -L zsh
  setopt pipe_fail

  local snapshot_dir="$HOME/code/10000-beers-analysis/snapshots"
  if [[ ! -d "$snapshot_dir" ]]; then
    print -u2 "Snapshot directory does not exist: $snapshot_dir"
    return 1
  fi

  local count timestamp output temporary
  count=$(ssh ninkasi 'docker exec beers-postgres psql -U beers -d beers -Atc "SELECT COUNT(*) FROM beers"') || return 1
  if [[ "$count" != <-> ]]; then
    print -u2 "Could not determine the current beer count"
    return 1
  fi

  timestamp=$(date +%Y-%m-%d_%H%M%S)
  output="$snapshot_dir/${timestamp}__${count}-beers.sql.gz"
  temporary="${output}.tmp"

  if ssh ninkasi 'docker exec beers-postgres pg_dump -U beers -d beers --clean --if-exists' | gzip > "$temporary"; then
    command mv "$temporary" "$output"
    print -r -- "$output"
  else
    command rm -f "$temporary"
    print -u2 "Snapshot failed"
    return 1
  fi
}

# NVM
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# uv
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Docker - New build system
export DOCKER_BUILDKIT=1

# Prompt
eval "$(oh-my-posh init zsh --config ~/theme/gabriel.omp.json)"

# Fastfetch greeting — top-level interactive shells only (not every tmux pane)
if [[ -o interactive && $SHLVL -eq 1 ]] && command -v fastfetch >/dev/null; then
    fastfetch
fi

# Zoxide (must be last)
eval "$(zoxide init zsh)"
