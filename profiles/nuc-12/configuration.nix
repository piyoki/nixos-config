_:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # system modules
      ../../system

      # themes modules
      ../../themes

      # shared modules
      ../../shared/nixos.nix
    ];

  # Set hostname
  networking.hostName = "nixos-nuc-12";
}
