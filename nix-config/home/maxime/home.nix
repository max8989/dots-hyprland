{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./kitty.nix
    ./shell.nix
    ./desktop.nix
    ./scripts.nix
    ./theming.nix
  ];

  home.username = "maxime";
  home.homeDirectory = "/home/maxime";
  home.stateVersion = "25.11"; # TODO: match system.stateVersion

  # Let Home Manager manage itself.
  programs.home-manager.enable = true;

  ##########################################################################
  ## Runtime packages — every binary the configs/keybindings/scripts invoke.
  ## On NixOS scripts can't assume a global PATH, so anything referenced must
  ## be here (or wrapped via writeShellApplication in scripts.nix).
  ##########################################################################
  home.packages =
    with pkgs;
    [
      # --- core desktop apps (from keybindings.conf) ---
      kitty
      nautilus
      zed-editor # verify attr name
      btop

      # --- bar ---
      waybar # launched from hyprland exec-once; config deployed in waybar.nix

      # --- launchers / menus ---
      rofi # rofi-wayland was merged into rofi
      wofi

      # --- clipboard ---
      cliphist
      wl-clipboard # provides wl-copy / wl-paste

      # --- window switching / wayland utils ---
      # hyprswitch — NOT in nixpkgs (ships its own flake github:h3rmt/hyprswitch).
      # Dropped for now; keybind (keybindings.conf:157-158) + exec-once are dead until
      # packaged as a flake input. TODO: add input or rebind.
      playerctl
      brightnessctl # used by hypridle.conf
      swayosd # provides swayosd-server / swayosd-client
      kanata # caps-lock vim nav, launched from exec-once (hyprland.nix:46)

      # --- screenshots / recording (used by scripts/screenshot.sh, screen_record.sh) ---
      hyprshot # scripts/screenshot.sh calls `hyprshot` directly
      grim
      slurp
      wf-recorder
      swappy

      # --- script dependencies (waybar + scripts/*.sh) ---
      jq
      yad
      libnotify # notify-send
      bluez # bluetoothctl (bluetooth-menu.sh)
      pavucontrol
      (python3.withPackages (ps: with ps; [ requests ])) # rss-summarize.py
      curl
    ]
    ++ [
      # Zen Browser from its flake (no nixpkgs package). Verify output attr.
      inputs.zen-browser.packages.${system}.default
    ];

  # hyprwat (audio device selector, bound to SUPER+F12) is AUR-only and not in
  # nixpkgs. Until packaged, that bind is dead; pavucontrol / `wpctl` cover it.
  # TODO: package hyprwat or rebind SUPER+F12 to pavucontrol.
}
