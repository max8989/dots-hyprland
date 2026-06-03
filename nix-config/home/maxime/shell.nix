{ lib, ... }:
let
  dots = ../../..; # repo root
in
{
  programs.bash.enable = true;

  # Reuse the existing starship.toml verbatim (parsed into HM settings).
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = lib.importTOML (dots + "/starship/.config/starship.toml");
  };
}
