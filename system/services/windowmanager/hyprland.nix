{ inputs, system, ... }:

# Reference:
# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
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

  xdg.portal = {
    # hyprland has its own portal, wlr is not needed
    wlr.enable = false;
    configPackages = [ pkgs-hypr.xdg-desktop-portal-hyprland ];
  };
}
