{ pkgs-stable, ... }:

{
  home.packages = with pkgs-stable; [
    # media
    cava # for visualizing audio
  ];
}
