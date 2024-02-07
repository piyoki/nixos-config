{ inputs, user, pkgs, ... }:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ./hardware
    ./packages
    ./services
    ./themes
    ./apps.nix
  ];

  # home-manager settings
  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "24.05";

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
}
