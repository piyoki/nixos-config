# Reference:
# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/

{ inputs, system, ... }:

{
  imports = [
    ./hyprpaper.nix
    ./pyprland.nix
    ./xdg-portal.nix
  ];

  # enable hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${system}.hyprland;
    portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
  };
}
