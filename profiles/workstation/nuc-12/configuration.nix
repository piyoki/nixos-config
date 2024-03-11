{ sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # system modules
    "system"

    # themes modules
    "themes"

    # shared modules
    "shared/modules/secrets"
    "shared/modules/system/tmpfs/persistent"
  ]) ++
  [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
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
