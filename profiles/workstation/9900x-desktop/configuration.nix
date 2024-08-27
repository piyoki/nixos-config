{ inputs, sharedLib, lib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # system modules
    "system/workstation.nix"
    "system/users/init-pass.nix"
    "system/services/greetd.nix"
    "system/services/scx.nix"
    "system/networking/udp-gro-forwarding.nix"

    # themes modules
    "themes"

    # shared modules
    "shared/modules/secrets"
    "shared/modules/system/tmpfs/persistent"
  ]) ++ [
    # host specific modules
    inputs.home-estate.nixosModules.host
  ] ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # external modules
    inputs.home-estate.nixosModules.sdwan
  ];

  # Set hostname
  networking.hostName = "nixos-9900x-desktop";

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
      profile = "workstation";
    };
  };
}
