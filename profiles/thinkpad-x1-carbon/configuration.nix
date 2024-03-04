_:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # system modules
    ../../system
    ../../system/services/greetd.nix
    ../../system/services/powermanagement/laptop.nix

    # themes modules
    ../../themes

    # shared modules
    ../../shared/nixos.nix
  ];

  # Set hostname
  networking.hostName = "nixos-x1-carbon";
}
