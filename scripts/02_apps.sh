#!/usr/bin/env bash
# Installs Node-based global tools (Claude Code, etc.)
set -euo pipefail

log() { echo "[apps] $*"; }

install_npm_global() {
  local pkg="$1"
  local bin="${2:-$1}"

  if command -v "$bin" &>/dev/null; then
    log "$pkg already installed, skipping."
  else
    log "Installing $pkg..."
    npm install -g "$pkg"
  fi
}

# Ensure npm is available
if ! command -v npm &>/dev/null; then
  echo "ERROR: npm not found. Run 01_homebrew.sh first." >&2
  exit 1
fi

install_npm_global "@anthropic-ai/claude-code" "claude"

log "Done."
