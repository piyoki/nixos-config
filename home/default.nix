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
    ./themes
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
}
