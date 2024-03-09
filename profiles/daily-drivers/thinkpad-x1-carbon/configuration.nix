_:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # system modules
    ../../../system
    ../../../system/services/greetd.nix
    ../../../system/services/powermanagement/laptop.nix

    # themes modules
    ../../../themes

    # shared modules
    ../../../shared/modules/secrets
  ];

  # Set hostname
  networking.hostName = "nixos-x1-carbon";

  # Import secrets
  modules.secrets.daily-driver.system.enable = true;
}
