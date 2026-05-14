#!/usr/bin/env bash
# Installs Homebrew if missing, then runs brew bundle
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

log() { echo "[homebrew] $*"; }

if ! command -v brew &>/dev/null; then
  log "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH for the rest of this script (Apple Silicon / Intel)
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  log "Homebrew already installed, skipping."
fi

log "Running brew bundle..."
brew bundle --file="$DOTFILES_DIR/Brewfile" --no-lock

log "Done."
