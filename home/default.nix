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
    stateVersion = (import ./vars.nix).stateVersion;
  };

  programs.home-manager.enable = true;
  programs.go.enable = true;
}
