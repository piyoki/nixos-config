# Reference:
# https://github.com/hyprwm/hyprlock
# https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/

{ inputs, system, ... }:

{
  # enable hyprlock
  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${system}.hyprlock;
  };
}
