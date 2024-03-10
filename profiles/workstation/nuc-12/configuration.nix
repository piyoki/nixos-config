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
      # ../../../shared/workstation/persistent.nix
      ../../../shared/modules/system/tmpfs/persistent
    ];

  # Set hostname
  networking.hostName = "nixos-nuc-12";

  # Import secrets
  modules.secrets.workstation.system.enable = true;

  # Load persistent dirs and files
  modules.persistent = {
    enable = true;
    profile = "workstation";
  };
}
