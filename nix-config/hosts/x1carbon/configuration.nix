{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  ##########################################################################
  ## Boot / kernel
  ##########################################################################
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ##########################################################################
  ## Nix / flakes
  ##########################################################################
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Hyprland flake is not built by Hydra / cache.nixos.org — pull its prebuilt
  # binaries from the official Cachix instead of compiling locally. Valid only
  # because we do NOT override hyprland's nixpkgs input (see flake.nix).
  nix.settings.substituters = [ "https://hyprland.cachix.org" ];
  nix.settings.trusted-public-keys = [
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  ];
  nixpkgs.config.allowUnfree = true;

  ##########################################################################
  ## Networking / locale / time
  ##########################################################################
  networking.hostName = "x1carbon";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Toronto"; # TODO: confirm timezone
  i18n.defaultLocale = "en_CA.UTF-8";

  # Chinese input — fcitx5. The actual us/ca layout toggle (Ctrl+Space) and the
  # fcitx5 toggle (Ctrl+Alt+Space) live in the Hyprland keybindings.
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons # renamed from top-level fcitx5-chinese-addons
      fcitx5-gtk
    ];
  };

  ##########################################################################
  ## Hyprland (compositor) — packages pinned to the Hyprland flake input so
  ## the compositor and its xdg portal stay in sync.
  ##########################################################################
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Portals + screen sharing.
  xdg.portal = {
    enable = true;
    # hyprland portal comes from programs.hyprland; add gtk for file pickers.
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  ##########################################################################
  ## Login — greetd + tuigreet launching Hyprland.
  ##########################################################################
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      user = "greeter";
    };
  };

  ##########################################################################
  ## Audio — PipeWire (replaces pipewire/pipewire-pulse/pipewire-alsa/wireplumber)
  ##########################################################################
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  ##########################################################################
  ## Kanata (caps-lock vim nav). Run as the user from Hyprland exec-once; it
  ## needs /dev/uinput access, provided here.
  ##########################################################################
  hardware.uinput.enable = true;

  ##########################################################################
  ## Misc system services
  ##########################################################################
  security.polkit.enable = true;
  services.dbus.enable = true;
  # ThinkPad fingerprint reader (7th gen). Enroll with `fprintd-enroll`.
  services.fprintd.enable = true;
  # Power profile switcher — backs waybar's `power-profiles-daemon` module.
  services.power-profiles-daemon.enable = true;
  # Brightness control without root (used by hypridle / swayosd via brightnessctl).
  # Installs brightnessctl's udev rules so the `video` group can write the backlight.
  services.udev.packages = [ pkgs.brightnessctl ];

  ##########################################################################
  ## Fonts
  ##########################################################################
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.caskaydia-cove # kitty (CaskaydiaCove Nerd Font Mono)
      nerd-fonts.jetbrains-mono # waybar style.css (JetBrainsMono Nerd Font)
      figtree
      # CJK — hyprlock phrases_zh.txt + fcitx5 Chinese input candidates.
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
  };

  ##########################################################################
  ## User
  ##########################################################################
  users.users.maxime = {
    isNormalUser = true;
    description = "Maxime Gagne";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "input"
      "uinput"
    ];
    shell = pkgs.bash;
  };

  # System-wide packages kept minimal; user software lives in Home Manager.
  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  # VM-test only settings (vmVariant scope — none of this applies to a real install).
  virtualisation.vmVariant = {
    # Known password so tuigreet login works in the QEMU VM. Login: maxime / test.
    users.users.maxime.initialPassword = "test";

    # Match the host panel (1920x1200). QEMU's default x86 display advertises only
    # 1024x768 as preferred, so Hyprland's `,highres,auto,1` lands there. Switch to
    # virtio-gpu and have it advertise 1920x1200 as preferred; `highres` then
    # auto-selects it — no change to the shared monitor config.
    virtualisation.qemu.options = [
      "-vga none"
      "-device virtio-gpu-pci,xres=1920,yres=1200"
    ];
  };

  # First NixOS generation this config targets. Do not change after install.
  system.stateVersion = "25.11"; # TODO: set to the installer's release
}
