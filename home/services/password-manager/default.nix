{ pkgs, ... }:

{
  imports = [
    ./keybase.nix
    ./sops.nix
    ./yubikey.nix
  ];

  home.packages = with pkgs; [
    gopass # The slightly more awesome Standard Unix Password Manager for Teams. Written in Go
    bitwarden-desktop # A secure and free password manager for all of your devices (UI)
  ];
}
