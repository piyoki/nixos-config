{ pkgs, ... }:

# Reference: https://nixos.wiki/wiki/Yubikey
{
  home.packages = with pkgs; [
    age-plugin-yubikey # YubiKey plugin for age
    yubikey-manager # Command line tool for configuring any YubiKey over all USB transports
    yubioath-flutter # Yubico Authenticator for Desktop
  ];
}
