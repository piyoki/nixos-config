{ user, pkgs, ... }:

{
  imports = [
    ./hardware
    ./packages
    ./services
    ./themes
    ./secrets
    ./apps.nix
  ];

  # home-manager settings
  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  programs.go.enable = true;
}
