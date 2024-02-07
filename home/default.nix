{ inputs, pkgs, ... }:

let
  user = (import ./vars.nix).user;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ./apps.nix
    ./hardware
    ./packages
    ./services
  ];

  # home-manager settings
  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
  programs.go.enable = true;

  # sops-nix
  sops.secrets.foo = {
    sopsFile = ./foo.enc.yml;
    format = "yaml";
  };
  sops.gnupg.home = "/var/lib/sops";
  # disable importing host ssh keys
  sops.gnupg.sshKeyPaths = [];

  # fonts
  fonts.fontconfig.enable = true;

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
