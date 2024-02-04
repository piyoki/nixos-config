{ pkgs, ... }:

{
  home.packages = [ pkgs.kitty ];
  xdg.configFile."kitty/kitty.conf".text = builtins.readFile ./kitty.conf;
}
