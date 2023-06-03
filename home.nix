{ config, pkgs, ... }:

let
  user = "kev";
in
{
  imports = [
    ./apps/fish.nix
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    btop
    fish
    htop
    httpie
    ripgrep
    xdg-user-dirs
    yadm
  ];
}
