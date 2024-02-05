{ pkgs, ... }:

{
  imports = [
    ./packages/packages.nix
    ./services/services.nix
    ./networking/networking.nix
    ./hardware/hardware.nix
  ];
}
