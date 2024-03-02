{ user, ... }:

{
  imports = [
    ./common
    ./packages
    ./services
    ./themes
    ./secrets
    ./maintenance
    ./apps.nix
  ];

  # home-manager settings
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
  programs.go.enable = true;
}
