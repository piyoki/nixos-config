{ inputs, pkgs, ... }:

{
  imports = [
    ../../wayland
    ../../xdg
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

  home.packages = with pkgs; [
    inputs.hyprland.packages."${pkgs.system}".hyprland
  ];
}
