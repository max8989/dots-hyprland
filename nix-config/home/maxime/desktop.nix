{ pkgs, ... }:
let
  dots = ../../..; # repo root
in
{
  # Daemons/tools launched from the Hyprland exec-once need to be on PATH.
  home.packages = with pkgs; [
    hyprlock
    hypridle
    hyprpaper
    swaynotificationcenter # provides `swaync`
    wlogout
    polkit_gnome
  ];

  # Deploy the remaining hand-tuned configs verbatim (store-copied = declarative).
  xdg.configFile = {
    # Hyprland ecosystem configs (sourced/used by the daemons above).
    "hypr/hypridle.conf".source = dots + "/hyprland/.config/hypr/hypridle.conf";
    "hypr/hyprpaper.conf".source = dots + "/hyprpaper/.config/hypr/hyprpaper.conf";
    "hypr/hyprlock.conf".source = dots + "/hyprlock/.config/hypr/hyprlock.conf";
    "hypr/assets".source = dots + "/hyprlock/.config/hypr/assets";
    "hypr/phrases_zh.txt".source = dots + "/hyprlock/.config/hypr/phrases_zh.txt";

    # Launchers / menus / osd.
    "wofi".source = dots + "/wofi/.config/wofi";
    "rofi".source = dots + "/rofi/.config/rofi";
    "wlogout".source = dots + "/wlogout/.config/wlogout";
    "swayosd".source = dots + "/swayosd/.config/swayosd";

    # Wallpapers (hyprpaper.conf references ~/.config/backgrounds/arch.png).
    "backgrounds".source = dots + "/backgrounds/.config/backgrounds";
  };
}
