# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

_:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # system modules
      ../../system/users/server.nix
      ../../system/environment/server.nix
      ../../system/networking/server.nix
      ../../system/services/fish.nix
      ../../system/services/docker.nix
      ../../system/services/openssh.nix
      ../../system/services/zramd.nix
      ../../system/internationalisation/locale.nix
      ../../system/internationalisation/time.nix

      # shared modules
      ../../shared/nixos.nix
    ];

  networking.hostName = "nixos-mars";
}
