# Reference:
# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
# https://hyprland-community.github.io/pyprland/

{ inputs, system, ... }:

let
  # nixpkgs-hypr = inputs.hyprland.inputs.nixpkgs.legacyPackages.${system};
  pkgs-hypr = inputs.hyprland.packages.${system};
in
{
  # enable hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${system}.hyprland;
  };

  # enable pyprland, the plugin manager for hyprland
  environment.systemPackages = [ inputs.pyprland.packages.${system}.pyprland ];

  # enable hyprland's xdg-desktop-portal
  xdg.portal = {
    # hyprland has its own portal, wlr is not needed
    wlr.enable = false;
    configPackages = [ pkgs-hypr.xdg-desktop-portal-hyprland ];
  };
}
