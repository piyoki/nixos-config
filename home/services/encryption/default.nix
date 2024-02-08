{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gopass # The slightly more awesome Standard Unix Password Manager for Teams. Written in Go
    sops # Simple and flexible tool for managing secrets
    age # Modern encryption tool with small explicit keys
    age-plugin-yubikey # YubiKey plugin for age
    yubikey-manager # Command line tool for configuring any YubiKey over all USB transports
    yubioath-flutter # Yubico Authenticator for Desktop
  ];

  # gnupg
  home.file.".gnupg/scdaemon.conf".text = builtins.readFile ./scdaemon.conf;
  home.file.".gnupg/gpg.conf".text = builtins.readFile ./gpg.conf;

  # sops
  home.file.".sops/.sops.yaml".text = builtins.readFile ../../../.sops.yaml;

  # sops-nix
  sops = {
    # configs
    age.keyFile = "/var/lib/age/age-yubikey-master.key";
    defaultSopsFormat = "yaml";

    # secrets
    secrets = {
      # git
      "gitconfig/general" = {
        sopsFile = ../../../secrets/gitconfig.enc.yaml;
        mode = "0600";
        path = "${config.home.homeDirectory}/.gitconfig";
      };
      "gitconfig/profile/personal" = {
        sopsFile = ../../../secrets/gitconfig.enc.yaml;
        mode = "0600";
        path = "${config.home.homeDirectory}/.gitconfigs/.gitconfig.personal";
      };
      "gitconfig/profile/work" = {
        sopsFile = ../../../secrets/gitconfig.enc.yaml;
        mode = "0600";
        path = "${config.home.homeDirectory}/.gitconfigs/.gitconfig.work";
      };
      "gitconfig/profile/extras" = {
        sopsFile = ../../../secrets/gitconfig.enc.yaml;
        mode = "0600";
        path = "${config.home.homeDirectory}/.gitconfigs/.gitconfig.extras";
      };

      # minio
      "minio/config" = {
        sopsFile = ../../../secrets/minio.enc.yaml;
        mode = "0600";
        path = "${config.home.homeDirectory}/.mc/config";
      };
    };
  };
}
