#!/usr/bin/env bash
# Non-interactive, idempotent machine setup. Safe to re-run at any time.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() { echo "==> $*"; }

# ── Homebrew + packages ───────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  log "Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

log "Installing Brewfile packages"
brew bundle --file="$DOTFILES_DIR/Brewfile"

# ── Global npm tools ──────────────────────────────────────────────────────────
log "Installing/updating global npm tools"
npm install -g @anthropic-ai/claude-code

# ── Copy dotfiles into $HOME ──────────────────────────────────────────────────
# Every top-level directory is a package mirroring paths relative to $HOME.
# Differing target files are backed up (*.bak.<timestamp>) before overwriting.
for pkg_dir in "$DOTFILES_DIR"/*/; do
  pkg="$(basename "$pkg_dir")"
  log "Copying package: $pkg"

  while IFS= read -r -d '' src; do
    rel="${src#"$pkg_dir"}"
    target="$HOME/$rel"

    if [[ -f "$target" ]] && cmp -s "$src" "$target"; then
      continue
    fi

    if [[ -f "$target" ]]; then
      backup="${target}.bak.$(date +%Y%m%d%H%M%S)"
      mv "$target" "$backup"
      log "Backed up: $target -> $backup"
    fi

    mkdir -p "$(dirname "$target")"
    cp "$src" "$target"
    log "Copied: $rel"
  done < <(find "$pkg_dir" -type f -print0)
done

log "Setup complete."
