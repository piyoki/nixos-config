{ pkgs, ... }:

{
  xdg.configFile."waybar/config".text = builtins.readFile ./config;
  xdg.configFile."waybar/style.css".text = builtins.readFile ./style.css;
  xdg.configFile."waybar/launch.sh".text = builtins.readFile ./launch.sh;
}
