# Reference:
# https://github.com/hyprwm/hyprpaper
# https://wiki.hyprland.org/Hypr-Ecosystem/hyprpaper/

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ hyprpaper ];
}
