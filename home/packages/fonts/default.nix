{ pkgs, ... }:

{
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
  ];
}
