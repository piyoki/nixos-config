{ inputs, pkgs, ... }:

{
  # enable hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    # xwayland = {
    #   enable = true;
    # };
  };
}
