_:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # system modules
      ../../../system

      # themes modules
      ../../../themes

      # shared modules
      ../../../shared/modules/secrets
      ../../../shared/modules/system/tmpfs/persistent
    ];

  # Set hostname
  networking.hostName = "nixos-nuc-12";

  modules = {
    # Import secrets
    secrets.workstation.system.enable = true;
    # Load persistent dirs and files
    persistent = {
      enable = true;
      hostType = "workstation";
    };
  };
}
