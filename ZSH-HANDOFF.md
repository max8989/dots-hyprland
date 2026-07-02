# Zsh Handoff

Switched the default shell from **bash → zsh** with a lean, framework-free setup
(no Oh My Zsh). Everything reuses tools that were already installed
(`fzf`, `zoxide`, `starship`, `ripgrep`).

Date: 2026-07-02 · Machine: Arch Linux

---

## What was installed

```bash
sudo pacman -S --needed zsh zsh-autosuggestions zsh-syntax-highlighting eza bat
```

| Package | Role |
|---|---|
| `zsh` | The shell |
| `zsh-autosuggestions` | Fish-style grey ghost-text suggestions from history |
| `zsh-syntax-highlighting` | Commands turn red if invalid before you hit enter |
| `eza` | Color `ls` replacement (icons, tree, git-aware) |
| `bat` | Color `cat` replacement |

Already present, reused (not reinstalled): `fzf`, `zoxide`, `starship`, `ripgrep`.

---

## Files changed

| File | Change |
|---|---|
| `dots-hyprland/zsh/.zshrc` | **New** stow package — the whole config lives here |
| `~/.zshrc` | Symlink → `dots-hyprland/zsh/.zshrc` (created by `stow zsh`) |
| `~/.zshrc.bak` | Backup of the old zshrc (its PATH lines were migrated into the new one) |
| `repos/arch-linux-setup/install_packages.sh` | Added the 7 packages + a `chsh -s zsh` block for reproducible installs |

The login shell was changed with `chsh -s /usr/bin/zsh`
(verified: `getent passwd maxime` ends in `/usr/bin/zsh`).

---

## How it's wired (`zsh/.zshrc`)

Load order matters — `zsh-syntax-highlighting` **must** be sourced last.

1. PATH / env (migrated: `~/.local/bin/env`, `~/.npm-global/bin`)
2. History (50k lines, dedup, shared across sessions)
3. Completion (case-insensitive, menu select, `AUTO_CD`)
4. `zsh-autosuggestions`
5. Tool init: `starship`, `zoxide`, `fzf` key-bindings + completion
6. Aliases
7. `zsh-syntax-highlighting` (last)

---

## Daily-use cheat sheet

| Command | Does |
|---|---|
| `z <part-of-dir>` | Jump to a frecent directory (zoxide) |
| `zi` | **Interactive** fzf directory picker |
| `cd foo` *or just* `foo` | `AUTO_CD` — bare dir name changes into it |
| `ll` / `la` | Long / long+hidden listing (eza) |
| `lt` | Tree view (eza) |
| `ls` | eza with icons + dirs-first |
| `cat <file>` | bat (syntax-highlighted, no pager) |
| **→** (right arrow) | Accept the grey autosuggestion |
| `Ctrl-R` | Fuzzy history search (fzf) |
| `Ctrl-T` | Fuzzy file picker into the command line (fzf) |
| `Alt-C` | Fuzzy cd into a subdirectory (fzf) |
| `<cmd> **<Tab>` | fzf-powered completion |

Invalid commands show in **red**; valid ones in green/other colors as you type.

---

## Verified working

- starship prompt ✅
- zoxide (`z` / `zi`) ✅
- autosuggestions loaded ✅
- syntax-highlighting loaded ✅
- `ls`→eza, `cat`→bat aliases ✅
- `zsh -n ~/.zshrc` — no syntax errors ✅

---

## Rollback

```bash
chsh -s /usr/bin/bash          # back to bash as login shell
mv ~/.zshrc.bak ~/.zshrc       # restore old zshrc (optional)
```

Bash config (`~/.bashrc`) was never touched, so bash still works untouched as a
fallback at any time.

---

## Optional next steps

- **`atuin`** — SQLite-backed, fuzzy, syncable shell history (replaces `Ctrl-R`).
  `pacman -S atuin` then add `eval "$(atuin init zsh)"` to `zsh/.zshrc`.
- **`grep`→`rg` alias** — deliberately *not* added (rg isn't flag-compatible with
  grep). Add to `zsh/.zshrc` if you want it.
- **Commit** the new `zsh/` stow package to the dots repo.
