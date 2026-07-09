# ── Homebrew (Apple Silicon or Intel) ────────────────────────────────────────
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# ── PATH ─────────────────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$PATH"

# ── Aliases (only if the replacement tool exists) ─────────────────────────────
if command -v eza &>/dev/null; then
  alias ls="eza --icons"
  alias ll="eza --icons -la"
fi
if command -v bat &>/dev/null; then
  alias cat="bat --paging=never"
fi

# ── Tools ─────────────────────────────────────────────────────────────────────
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
command -v fzf    &>/dev/null && source <(fzf --zsh)

# ── History ───────────────────────────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
