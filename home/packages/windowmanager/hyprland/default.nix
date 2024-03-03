{ inputs, pkgs, ... }:

{
  imports = [
    ./browser
    ./document
    ./editor
    ./im
    ./media
    ./productivity
    ./screenshot
    ./system
    ./terminal
  ];

  home.packages = [
    inputs.hyprland.packages."${pkgs.system}".hyprland
  ];
}
