{ config, pkgs, ... }:

let
  user = "kev";
in
{
  imports = [
    ./apps/fish.nix
  ];

  programs.home-manager.enable = true;
  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    btop
    delta
    fd
    fish
    fzf
    htop
    httpie
    lazygit
    neovim
    ripgrep
    vivid
    xdg-user-dirs
    yadm
  ];
}
