{ pkgs, ... }:

{
  imports = [ ./sops.nix ];

  home = {
    packages = with pkgs; [
      gopass # The slightly more awesome Standard Unix Password Manager for Teams. Written in Go
      sops # Simple and flexible tool for managing secrets
      age # Modern encryption tool with small explicit keys
      age-plugin-yubikey # YubiKey plugin for age
      yubikey-manager # Command line tool for configuring any YubiKey over all USB transports
      yubioath-flutter # Yubico Authenticator for Desktop
      bitwarden-cli # A secure and free password manager for all of your devices (CLI)
      bitwarden # A secure and free password manager for all of your devices (UI)
    ];
  };
}
