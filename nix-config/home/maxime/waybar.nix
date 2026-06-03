{ ... }:
let
  dots = ../../..; # repo root
in
{
  # Waybar is launched from the Hyprland exec-once (see hyprland.nix). We do NOT
  # use the programs.waybar module here because it would generate its own
  # config and collide with the hand-tuned config.jsonc / style.css below.
  # The whole config tree is deployed declaratively (copied into the store):
  # config.jsonc, modules.json, style.css, theme.css, mocha.css, themes/, scripts/.
  xdg.configFile."waybar".source = dots + "/waybar/.config/waybar";
}
