{ inputs, sharedLib, lib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # system modules
    "system/workstation.nix"
    "system/users/init-pass.nix"
    "system/services/greetd.nix"
    "system/services/powermanagement/laptop.nix"
    "system/services/scx.nix"
    "system/hardware/keyd.nix"
    # "system/hardware/fingerprint.nix"

    # themes modules
    "themes"

    # shared modules
    "shared/modules/secrets"
    "shared/modules/system/tmpfs/persistent"
  ]) ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-estate.nixosModules.sdwan
  ] ++ (map sharedLib.relativeToRoot [
    "system/networking/udp-gro-forwarding.nix"
  ]);

  # Set hostname
  networking.hostName = "nixos-x1-carbon";

  modules = {
    # Import system secrets
    secrets.workstation.system.enable = true;
    # Load persistent dirs and files
    persistent = {
      enable = true;
      hostType = "workstation";
    };
  };

  services = {
    # enable sdwan service
    sdwan = {
      enable = true;
      autostart = lib.mkForce false;
      profile = "laptop";
    };
  };
}
