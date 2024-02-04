{ pkgs, ... }:

{
  home.packages = [ pkgs.lazygit ];
  xdg.configFile."hypr/hyprland.conf".text = builtins.readFile ./hyprland.conf;
}
