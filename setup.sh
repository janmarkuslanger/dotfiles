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

echo "$(bold "Step 1 – Homebrew + packages")"
echo "$(dim "  Installs Homebrew (if missing) and the following packages via Brewfile:")"
echo "$(dim "  CLI tools : git, curl, wget, jq, gh, fzf, ripgrep, bat, eza, zoxide")"
echo "$(dim "  Runtimes  : node, python")"
echo "$(dim "  GUI apps  : Ghostty, Visual Studio Code")"
confirm "  Install / update?" "y" && RUN_HOMEBREW=true || true

echo ""
echo "$(bold "Step 2 – Global npm apps")"
echo "$(dim "  Installs the following package globally via npm:")"
echo "$(dim "  @anthropic-ai/claude-code  (claude CLI)")"
confirm "  Install / update?" "y" && RUN_APPS=true || true

echo ""
echo "$(bold "Step 3 – Copy dotfiles to \$HOME")"
echo "$(dim "  Copies config files from the following packages into your home directory:")"
echo "$(dim "  zsh    → ~/.zshrc, ~/.zprofile, etc.")"
echo "$(dim "  claude → ~/.claude/ settings & templates")"
confirm "  Copy files?" "y" && RUN_COPY=true || true

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
