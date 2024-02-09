{ inputs, pkgs, ... }:

{
  xdg.configFile."path/file".text = builtins.readFile ./file;
  xdg.configFile."path/dir".source = ./dir;
}

