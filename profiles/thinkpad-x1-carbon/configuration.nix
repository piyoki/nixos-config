_:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # system modules
    ../../system
    ../../system/services/greetd.nix

    # themes modules
    ../../themes

    # shared modules
    ../../shared/modules/system/powermanagement.nix
  ];

  # Set hostname
  networking.hostName = "nixos-x1-carbon";
}
