{ sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # system modules
    "system"
    "system/services/greetd.nix"
    "system/services/powermanagement/laptop.nix"
    # "system/hardware/fingerprint.nix"

    # themes modules
    "themes"

    # shared modules
    "shared/modules/secrets"
  ]) ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Set hostname
  networking.hostName = "nixos-x1-carbon";

  # Import system secrets
  modules.secrets.workstation.system.enable = true;
}
