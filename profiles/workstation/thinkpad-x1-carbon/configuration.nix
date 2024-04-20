{ sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # system modules
    "system/workstation.nix"
    "system/users/init-pass.nix"
    "system/services/greetd.nix"
    "system/services/powermanagement/laptop.nix"
    "system/services/scx.nix"
    # "system/hardware/fingerprint.nix"

    # themes modules
    "themes"

    # shared modules
    "shared/modules/secrets"
    "shared/modules/system/tmpfs/persistent"
  ]) ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Set hostname
  networking.hostName = "nixos-x1-carbon";

  # Import system secrets
  modules.secrets.workstation.system.enable = true;
}
