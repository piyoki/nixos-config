{ pkgs, ... }:

{
  xdg.configFile."dunst/dunstrc".text = builtins.readFile ./dunstrc;
}
