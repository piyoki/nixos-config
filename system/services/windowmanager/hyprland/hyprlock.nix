# Reference:
# https://github.com/hyprwm/hyprlock
# https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/

{ pkgs, ... }:

{
  # enable hyprlock
  programs.hyprlock = {
    enable = true;
    package = pkgs.hyprlock;
  };
}
