# Handoff — Arch/Hyprland → NixOS migration

**Branch:** `nixos` · **Status:** config authored, not yet evaluated (no `nix` on the dev box) · **Next:** build + test in a QEMU VM.

## Goal

Migrate this Arch Linux + Hyprland setup to **NixOS**, reusing the existing dotfiles.
Decisions made up front:
- **Fully declarative** via Nix/Home Manager (not live-symlinking the stow tree).
- **Flakes** — pinned `nixpkgs` + `home-manager` + official `hyprland` + `zen-browser`.
- **VM-test first** before any real-hardware install.
- **Neovim is out of scope** (no longer used — not ported).

Plan file: `~/.claude/plans/i-m-planning-a-migration-ethereal-whale.md`.

## What's done

A complete first-pass NixOS + Home Manager config. `flake.nix` lives at the **repo
root** (so Nix modules can read the existing `hyprland/`, `waybar/`, … files in place —
flakes only read files inside the flake root).

```
flake.nix                              # inputs + nixosConfigurations.x1carbon (HM as NixOS module)
nix-config/
├── README.md                          # build/test instructions + "verify these attrs" list
├── HANDOFF.md                         # this file
├── hosts/x1carbon/
│   ├── configuration.nix              # hyprland, pipewire, xdg portal, fonts, fcitx5, greetd, uinput, fprintd, user
│   └── hardware-configuration.nix     # PLACEHOLDER — must be regenerated on the target
└── home/maxime/
    ├── home.nix                       # imports + runtime package set (from keybindings/scripts)
    ├── hyprland.nix                   # wayland.windowManager.hyprland: hyprland.conf → settings; keybindings sourced verbatim
    ├── waybar.nix                     # deploys waybar config tree (config.jsonc/style.css/scripts/themes)
    ├── kitty.nix                      # programs.kitty (font/settings/keybindings)
    ├── shell.nix                      # bash + starship (lib.importTOML starship.toml)
    ├── desktop.nix                    # hyprlock/hypridle/hyprpaper/wofi/rofi/wlogout/swayosd configs + backgrounds + daemon pkgs
    ├── scripts.nix                    # scripts tree + battery-level/reminders-notify systemd user timers
    └── theming.nix                    # cursor (catppuccin-frappe-dark) / gtk / icons
```

## Key decisions & deviations from the plan

- **Daemons launch via Hyprland `exec-once`** (as on Arch), *not* via HM services —
  avoids HM-module-vs-deployed-file conflicts. Configs are still fully Nix-managed.
- **Scripts deployed as files + PATH** rather than `writeShellApplication` wrappers —
  equivalent guarantee, far less churn. systemd timers get an explicit `PATH=` so they
  work without a login shell.
- **`polkit-gnome` autostart** repointed from `/usr/lib/...` to `${pkgs.polkit_gnome}/libexec/...`.
- **Kanata** runs as the user from `exec-once`; system enables `hardware.uinput` + adds
  user to `uinput`/`input` groups.
- **`system-update.sh`** is Arch-only and self-exits on NixOS (no `/etc/arch-release`) — harmless, left as-is.

## Open items / TODO (in rough order)

1. **`git add` the new files** — flakes ignore untracked files, so nothing builds until staged.
2. **Install build/run tooling on Arch** (see README / chat): `pacman -S nix qemu-desktop`,
   enable `nix-daemon`, enable flakes, join `nix-users` + `kvm` groups.
3. **`nix flake check`** and fix any attr/option names that moved. Flagged unknowns:
   - `pkgs.zed-editor`, `pkgs.hyprswitch`, `pkgs.swayosd`, `pkgs.swaynotificationcenter`
   - `pkgs.figtree` (font may be under `google-fonts`)
   - `pkgs.catppuccin-gtk` (recent nixpkgs may expose `pkgs.catppuccin.gtkTheme`)
   - `pkgs.nerd-fonts.caskaydia-cove` (post nerd-fonts restructure)
   - `inputs.zen-browser.packages.<system>.default` (confirm output name)
   - `i18n.inputMethod.type = "fcitx5"` (newer form; older nixpkgs used `enabled = "fcitx5"`)
   - `wayland.windowManager.hyprland.configType` (recent home-manager only)
   - **`hyprwat`** (SUPER+F12 audio selector) — AUR-only, not in nixpkgs; bind is dead until
     packaged. Package it or rebind to `pavucontrol`.
4. **Build + run the VM:**
   ```sh
   nix build .#nixosConfigurations.x1carbon.config.system.build.vm
   ./result/bin/run-x1carbon-vm
   ```
   Verify in-VM: Hyprland starts, Waybar renders, keybindings work, terminal/launcher/lock/
   notifications/audio/fonts, scripts run with correct PATH.
5. **Real install:** boot NixOS ISO → `nixos-generate-config --show-hardware-config >
   nix-config/hosts/x1carbon/hardware-configuration.nix` → `nixos-rebuild switch --flake .#x1carbon`.
   Then validate hardware the VM can't: backlight keys, wifi, fingerprint, suspend/resume, external displays.
6. Set real values: `time.timeZone`, `system.stateVersion` / `home.stateVersion` (match the installer release).

## Risks / things to watch

- `hardware-configuration.nix` is a non-bootable placeholder — only enough for `nix flake check`.
- The flake root is the entire dotfiles repo, so every build copies the whole repo (incl. `_bmad`,
  `nvim`, `node-compile-cache`, `images`) into the nix store. Trim later if builds feel slow.
- `wpctl` / `fcitx5-remote` come from the system PipeWire / input-method setup; if a keybind that
  uses them fails in-VM, add the providing package to `home.packages`.
- Nothing here has been evaluated by Nix yet — expect a few iterations on `nix flake check`.

## Nothing committed

All files are written to the working tree on `nixos` but **not staged/committed**. Review, then
`git add flake.nix nix-config/` and commit when ready.
