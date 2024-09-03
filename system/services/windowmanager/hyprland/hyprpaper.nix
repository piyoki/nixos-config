# Reference:
# https://hyprland-community.github.io/pyprland/

{ pkgs, ... }:

{
  # enable pyprland, the plugin manager for hyprland
  environment.systemPackages = with pkgs; [ hyprpaper ];
}
