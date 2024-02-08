{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mpv
    playerctl
    spotify
    cava # for visualizing audio
  ];

  services = {
    playerctld.enable = true;
  };
}

