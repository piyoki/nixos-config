{ pkgs, ... }:

{
  imports = [
    ./sops.nix
    ./systemd-restart.nix
  ];

  home = {
    packages = with pkgs; [
      gopass # The slightly more awesome Standard Unix Password Manager for Teams. Written in Go
      age-plugin-yubikey # YubiKey plugin for age
      yubikey-manager # Command line tool for configuring any YubiKey over all USB transports
      yubioath-flutter # Yubico Authenticator for Desktop
      bitwarden # A secure and free password manager for all of your devices (UI)
    ];
  };

  # Keybase
  # https://mynixos.com/nixpkgs/options/services.kbfs
  # https://gist.github.com/taktoa/3133a4d9b1614fad1f4841f145441406
  services.kbfs = {
    enable = true;
  };
}
