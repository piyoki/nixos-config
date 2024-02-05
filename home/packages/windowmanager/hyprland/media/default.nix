{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mpv
    playerctl
    spotify
  ];
}

