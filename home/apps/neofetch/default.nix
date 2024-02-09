{ pkgs, ... }:

{
  xdg.configFile."neofetch/config.conf".text = builtins.readFile ./config.conf;
}
