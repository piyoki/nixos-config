{ pkgs, ... }:

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
}
