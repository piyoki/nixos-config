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
      ../../shared/modules/secrets
    ];

  # Set hostname
  networking.hostName = "nixos-nuc-12";

  # Import secrets
  modules.secrets.system.daily-driver.enable = true;
}
