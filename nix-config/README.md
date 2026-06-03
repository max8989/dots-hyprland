# nix-config

NixOS + Home Manager port of this dotfiles repo (Arch/Hyprland → NixOS).
Lives on the `nixos` branch. The `flake.nix` is at the **repo root** so the Nix
modules can read the existing config files (`hyprland/`, `waybar/`, …) in place —
Nix flakes can only read files inside the flake root.

## Layout

```
flake.nix                              # root: inputs + nixosConfigurations.x1carbon
nix-config/
├── hosts/x1carbon/
│   ├── configuration.nix              # system: hyprland, pipewire, fonts, fcitx5, greetd, user…
│   └── hardware-configuration.nix     # PLACEHOLDER — regenerate on the machine
└── home/maxime/
    ├── home.nix                       # imports + runtime package set
    ├── hyprland.nix                   # wayland.windowManager.hyprland (settings + keybindings)
    ├── waybar.nix                     # deploys waybar config tree
    ├── kitty.nix                      # programs.kitty
    ├── shell.nix                      # bash + starship (from starship.toml)
    ├── desktop.nix                    # hyprlock/hypridle/hyprpaper/wofi/rofi/wlogout/swayosd/backgrounds
    ├── scripts.nix                    # script tree + systemd user timers
    └── theming.nix                    # cursor / gtk / icons
```

## Build & test (do this where `nix` is available — VM first)

```sh
# 1. evaluate
nix flake check

# 2. build a throwaway VM and run it (NO real-hardware changes yet)
nixos-rebuild build-vm --flake .#x1carbon
./result/bin/run-x1carbon-vm

# 3. on the real machine, after regenerating hardware-configuration.nix:
sudo nixos-rebuild switch --flake .#x1carbon
```

Regenerate hardware config on the target/VM:
```sh
nixos-generate-config --show-hardware-config \
  > nix-config/hosts/x1carbon/hardware-configuration.nix
```

## Verify at build time (assumed, not validated — no nix on the dev box)

These attribute/option names should be confirmed when `nix flake check` first runs;
fix any that have moved in your chosen nixpkgs/home-manager revision:

- `pkgs.zed-editor`, `pkgs.hyprswitch`, `pkgs.swayosd`, `pkgs.swaynotificationcenter`
- `pkgs.figtree` font (may live under `google-fonts`)
- `pkgs.catppuccin-gtk` (recent nixpkgs may expose it as `pkgs.catppuccin.gtkTheme`)
- `pkgs.nerd-fonts.caskaydia-cove` (post nerd-fonts restructure)
- `inputs.zen-browser.packages.<system>.default` (check the flake's actual output name)
- `i18n.inputMethod.type = "fcitx5"` (newer option form; older nixpkgs used `enabled = "fcitx5"`)
- `wayland.windowManager.hyprland.configType` (recent home-manager only)
- **`hyprwat`** (SUPER+F12 audio selector) is AUR-only / not in nixpkgs — bind is currently dead; package it or rebind to `pavucontrol`.

## Design notes

- Desktop daemons (hyprpaper, hypridle, swaync, swayosd, waybar) are launched from
  the Hyprland `exec-once` exactly as on Arch, rather than via Home Manager services,
  to avoid module-vs-file conflicts. Their configs are deployed declaratively.
- The Hyprland `polkit-gnome` autostart was repointed from `/usr/lib/...` to the
  nix-store path `${pkgs.polkit_gnome}/libexec/...`.
- Kanata runs as the user from `exec-once`; the system enables `hardware.uinput`
  and puts the user in the `uinput`/`input` groups.
- `system-update.sh` is Arch-only and self-exits on NixOS (harmless).
- The flake root is the whole dotfiles repo, so every build copies the entire repo
  into the store. Consider trimming large untracked-but-tracked dirs later if slow.
