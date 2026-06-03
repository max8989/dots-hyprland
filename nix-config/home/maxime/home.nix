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

      # --- launchers / menus ---
      rofi-wayland
      wofi

      # --- clipboard ---
      cliphist
      wl-clipboard # provides wl-copy / wl-paste

      # --- window switching / wayland utils ---
      hyprswitch # verify it is in nixpkgs
      playerctl
      brightnessctl # used by hypridle.conf
      swayosd # provides swayosd-server / swayosd-client

      # --- screenshots / recording (used by scripts/screenshot.sh, screen_record.sh) ---
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
