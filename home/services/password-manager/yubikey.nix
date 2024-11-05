{ pkgs, pkgs-small, ... }:

# Reference: https://nixos.wiki/wiki/Yubikey
{
  home.packages = [
    pkgs.age-plugin-yubikey # YubiKey plugin for age
    pkgs-small.yubikey-manager # Command line tool for configuring any YubiKey over all USB transports
  ];
}
