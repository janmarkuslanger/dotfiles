# ── PATH ─────────────────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:/opt/homebrew/bin:$PATH"

# ── Aliases ───────────────────────────────────────────────────────────────────
alias ls="eza --icons"
alias ll="eza --icons -la"
alias cat="bat --paging=never"

# ── Tools ─────────────────────────────────────────────────────────────────────
eval "$(zoxide init zsh)"          # smart cd
source <(fzf --zsh)                # fuzzy finder keybindings + completion

# ── History ───────────────────────────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
