{ inputs, pkgs, ... }:

{
  # enable hyprland
  programs.hyprland = {
    enable = false;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
}
