# Reference:
# https://hyprland-community.github.io/pyprland/

{ inputs, system, ... }:

{
  # enable pyprland, the plugin manager for hyprland
  environment.systemPackages = [ inputs.pyprland.packages.${system}.pyprland ];
}
