# dotfiles

Personal machine setup – idempotent, safe to re-run at any time.

## Setup

```bash
git clone https://github.com/jan-markuslanger/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

The script prompts interactively which steps to run:

| Step | What it does |
|------|--------------|
| **1. Homebrew** | Installs Homebrew (if missing) + all packages from `Brewfile` |
| **2. Apps** | Installs global npm tools (Claude Code) |
| **3. Copy** | Copies dotfiles into `$HOME`, prompts on conflict |

## Structure

```
dotfiles/
├── setup.sh          # Entry point
├── Brewfile          # All brew/cask packages
├── scripts/
│   ├── 01_homebrew.sh
│   ├── 02_apps.sh
│   └── 03_copy.sh
├── claude/
│   └── .claude/
│       └── CLAUDE.md # Global Claude Code configuration
└── zsh/
    └── .zshrc        # Zsh configuration
```

## Packages

| Package | Target | Contents |
|---------|--------|----------|
| `claude` | `~/.claude/CLAUDE.md` | Global Claude Code behavior |
| `zsh` | `~/.zshrc` | Aliases, PATH, fzf, zoxide, history |

## Conflict handling

When a file already exists at the target location and differs from the source, the script asks:

```
[copy] ~/.zshrc already exists.
       [o] overwrite  [b] backup + overwrite  [s] skip (default) :
```

## Adding a new dotfile package

1. Create a directory mirroring the target path relative to `$HOME`:
   ```
   git/.gitconfig
   ```
2. Add the package name to `PACKAGES` in `scripts/03_copy.sh`
3. Re-run `./setup.sh` (step 3 only)

## Adding a new brew package

Edit `Brewfile`, then:

```bash
brew bundle --file=Brewfile --no-lock
```
