{ pkgs, ... }:

{
  imports = [
    ./keybase.nix
    ./sops.nix
  ];

  home.packages = with pkgs; [
    gopass # The slightly more awesome Standard Unix Password Manager for Teams. Written in Go
    age-plugin-yubikey # YubiKey plugin for age
    yubikey-manager # Command line tool for configuring any YubiKey over all USB transports
    yubioath-flutter # Yubico Authenticator for Desktop
    bitwarden-desktop # A secure and free password manager for all of your devices (UI)
  ];
}
