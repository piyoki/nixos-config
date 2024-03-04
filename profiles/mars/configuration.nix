_:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # system modules
      ../../system/server.nix

      # shared modules
      ../../shared/nixos.nix
    ];

  networking.hostName = "nixos-mars";
}
