# Reference:
# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/

{ inputs, system, ... }:

{
  imports = [
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./pyprland.nix
    ./xdg-portal.nix
    ./xwayland.nix
  ];

  programs = {
    # enable hyprland
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${system}.hyprland;
      portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
    };
  };

  # session-specfic variables
  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };
}
