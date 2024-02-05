{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gwenview # image viewer
    okular # document viewer
  ];
}

