# Reference:
# https://github.com/hyprwm/hyprpaper
# https://wiki.hyprland.org/Hypr-Ecosystem/hyprpaper/

{ inputs, system, ... }:

{
  environment.systemPackages = [ inputs.hyprpaper.packages.${system}.hyprpaper ];
}
