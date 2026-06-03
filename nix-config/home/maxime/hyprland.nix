{
  inputs,
  pkgs,
  config,
  ...
}:
let
  dots = ../../..; # repo root (flake root)
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    # Use the same Hyprland package the system enables (from the flake input).
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # Keep the existing hyprlang-syntax config/keybindings working.
    configType = "hyprlang";

    settings = {
      # --- monitors (from hyprland.conf) ---
      monitor = [
        ",highres,auto,1"
        "DP-2,2560x1440@60,auto-right,1"
        "DP-1,1920x1080@60,auto-left,1"
        "SUNSHINE,1280x720@30,auto,1"
      ];

      # --- environment ---
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      # --- autostart ---
      # NixOS-adapted: polkit agent uses the nix store path. All daemons are
      # launched here (same as the Arch setup) rather than via HM services, to
      # avoid module/file conflicts. Configs for these daemons are deployed by
      # desktop.nix / scripts.nix.
      exec-once = [
        "hyprctl setcursor catppuccin-frappe-dark-cursors 28"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "hyprpaper & waybar & swaync & hypridle & swayosd-server"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "hyprswitch init --show-title &"
        "kanata --cfg ~/.config/kanata/config.kbd"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 6;
        rounding_power = 1;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 2;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = false;
          size = 2;
          passes = 2;
          brightness = 0.60;
          contrast = 0.75;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint, 0.23, 1, 0.32, 1"
          "easeInOutCubic, 0.65, 0, 0.35, 1"
          "linear, 0, 0, 1, 1"
          "almostLinear, 0.5, 0.5, 0.75, 1.0"
          "quick, 0.15, 0, 0.1, 1"
        ];
        animation = [
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "windowsMove, 1, 2.5, easeInOutCubic"
          "fade, 1, 3.03, quick"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fadeSwitch, 0, 1, easeInOutCubic"
          "fadeShadow, 1, 10, almostLinear"
          "fadeDim, 1, 4.03, almostLinear"
          "border, 1, 0.81, easeOutQuint"
          "borderangle, 1, 0.81, easeOutQuint"
          "workspaces, 1, 0.8, easeOutQuint, slidefade"
          "layers, 1, 3.81, easeOutQuint, fade"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
        ];
      };

      dwindle = {
        preserve_split = true;
        force_split = 2;
      };

      master.new_status = "master";

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      input = {
        kb_layout = "us,ca";
        kb_options = "grp:ctrl_space_toggle";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad.natural_scroll = true;
      };

      gesture = "3, horizontal, workspace";

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };
    };

    # Keybindings are portable hyprlang — reused verbatim from the repo.
    extraConfig = ''
      source = ~/.config/hypr/mocha.conf
      source = ~/.config/hypr/keybindings.conf
    '';
  };

  # Deploy the files the Hyprland config sources / references.
  xdg.configFile = {
    "hypr/keybindings.conf".source = dots + "/hyprland/.config/hypr/keybindings.conf";
    "hypr/mocha.conf".source = dots + "/hyprmocha/.config/hypr/mocha.conf";
    "kanata/config.kbd".source = dots + "/kanata/.config/kanata/config.kbd";
  };
}
