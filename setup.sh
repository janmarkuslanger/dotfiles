#!/usr/bin/env bash
# Main setup script – idempotent, safe to re-run at any time
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$DOTFILES_DIR/scripts"

# ── Helpers ──────────────────────────────────────────────────────────────────

bold()  { printf "\033[1m%s\033[0m" "$*"; }
green() { printf "\033[32m%s\033[0m" "$*"; }
dim()   { printf "\033[2m%s\033[0m" "$*"; }

step() { echo ""; echo "$(bold "==>") $*"; }

confirm() {
  local prompt="$1"
  local default="${2:-y}"   # y or n
  local yn_hint

  if [[ "$default" == "y" ]]; then
    yn_hint="$(bold Y)/n"
  else
    yn_hint="y/$(bold N)"
  fi

  printf "%s [%s] " "$prompt" "$yn_hint"
  read -r reply </dev/tty
  reply="${reply:-$default}"
  [[ "$reply" =~ ^[Yy]$ ]]
}

# ── Interactive step selection ────────────────────────────────────────────────

echo ""
echo "$(bold "dotfiles setup")"
echo "$(dim "Each step is idempotent – safe to re-run.")"
echo ""

RUN_HOMEBREW=false
RUN_APPS=false
RUN_COPY=false

confirm "$(green "1.") Homebrew + brew bundle (packages & casks)?" "y" && RUN_HOMEBREW=true || true
confirm "$(green "2.") Global apps via npm (Claude Code, etc.)?"   "y" && RUN_APPS=true    || true
confirm "$(green "3.") Copy dotfiles to \$HOME?"                   "y" && RUN_COPY=true    || true

# ── Execute selected steps ────────────────────────────────────────────────────

if ! $RUN_HOMEBREW && ! $RUN_APPS && ! $RUN_COPY; then
  echo ""
  echo "Nothing selected. Exiting."
  exit 0
fi

$RUN_HOMEBREW && { step "Homebrew + packages";        bash "$SCRIPTS_DIR/01_homebrew.sh"; }
$RUN_APPS     && { step "Global apps (Claude Code…)"; bash "$SCRIPTS_DIR/02_apps.sh"; }
$RUN_COPY     && { step "Copying dotfiles";            bash "$SCRIPTS_DIR/03_copy.sh"; }

echo ""
echo "$(green "Setup complete.")"
