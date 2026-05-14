#!/usr/bin/env bash
# Copies dotfile packages into $HOME
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

log()  { echo "[copy] $*"; }
warn() { echo "[copy] WARNING: $*"; }

PACKAGES=(claude zsh)

copy_package() {
  local pkg="$1"
  local pkg_dir="$DOTFILES_DIR/$pkg"

  while IFS= read -r -d '' src; do
    local rel="${src#$pkg_dir/}"
    local target="$HOME/$rel"
    local target_dir
    target_dir="$(dirname "$target")"

    # Identical file – skip silently
    if [[ -f "$target" ]] && cmp -s "$src" "$target"; then
      continue
    fi

    # Existing file differs – ask what to do, default skip
    if [[ -f "$target" ]]; then
      printf "[copy] %s already exists.\n" "$target"
      printf "       [o] overwrite  [b] backup + overwrite  [s] skip (default) : "
      read -r reply </dev/tty
      case "${reply:-s}" in
        o|O)
          ;;
        b|B)
          local backup="${target}.bak.$(date +%Y%m%d%H%M%S)"
          mv "$target" "$backup"
          log "Backed up: $target → $backup"
          ;;
        *)
          log "Skipping: $rel"
          continue
          ;;
      esac
    fi

    mkdir -p "$target_dir"
    cp "$src" "$target"
    log "Copied: $rel"
  done < <(find "$pkg_dir" -type f -print0)
}

for pkg in "${PACKAGES[@]}"; do
  if [[ ! -d "$DOTFILES_DIR/$pkg" ]]; then
    warn "'$pkg' directory not found, skipping."
    continue
  fi
  log "Copying $pkg..."
  copy_package "$pkg"
done

log "Done."
