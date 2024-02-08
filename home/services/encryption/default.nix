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

  # sops-nix configs
  sops = {
    # sops-nix configs
    age.keyFile = "/var/lib/age/age-yubikey-master.key";
    defaultSopsFormat = "yaml";

    # secrets
    secrets = {
      # "minio/host" = {
      #   sopsFile = ../secrets/config.enc.yaml;
      # };
      # "minio/accessKey" = {
      #   sopsFile = ../secrets/config.enc.yaml;
      # };
      "minio/secretKey" = {
        sopsFile = ../../../secrets/config.enc.yaml;
        mode = "0600";
        path = "${config.home.homeDirectory}/.mc/config.json";
      };
    };
  };
}
