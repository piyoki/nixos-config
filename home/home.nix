{ config, pkgs, ... }:

let
  user = (import ./vars.nix).user;
in
{
  imports = [
    ./apps.nix
    ./hardware
    ./packages
    ./services
  ];

  programs.home-manager.enable = true;
  programs.go.enable = true;

  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.11";

  # fonts
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [];

  # themes
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    font = {
      name = "Cantarell Regular";
      size = 12;
    };
  };
}
