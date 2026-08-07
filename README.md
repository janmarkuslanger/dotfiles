# dotfiles

Personal machine setup – non-interactive, idempotent, safe to re-run at any time.

## Setup

```bash
git clone https://github.com/janmarkuslanger/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

`setup.sh` does everything in one pass:

1. Installs Homebrew (if missing) and all packages from `Brewfile`
2. Installs/updates global npm tools (Claude Code)
3. Copies dotfile packages into `$HOME`

If a target file already exists and differs, it is backed up as
`<file>.bak.<timestamp>` before being overwritten.

## Structure

Every top-level directory is a package mirroring paths relative to `$HOME`:

| Package | Target | Contents |
|---------|--------|----------|
| `claude` | `~/.claude/CLAUDE.md` | Global Claude Code behavior |
| `zsh` | `~/.zshrc` | Aliases, PATH, fzf, zoxide, history |

## Adding a new dotfile package

Create a directory mirroring the target path relative to `$HOME`, e.g.
`git/.gitconfig`, then re-run `./setup.sh`. Packages are discovered
automatically – no registration needed.

## Adding a new brew package

Edit `Brewfile`, then re-run `./setup.sh` (or `brew bundle --file=Brewfile`).
