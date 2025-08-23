{ inputs, sharedLib, lib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # system modules
    "system/workstation.nix"
    "system/users/init-pass.nix"
    "system/services/greetd.nix"
    "system/services/scx.nix"
    "system/hardware/keyd.nix"
    "system/services/virtualization/virtmanager.nix"
    "system/services/sshfs.nix"

    # misc modules
    "system/environment/intel-specific.nix"
    "system/services/powermanagement/laptop.nix"
    # "system/hardware/fingerprint.nix"
    # "system/networking/udp-gro-forwarding.nix"

    # themes modules
    "themes"
    # shared modules
    "shared/modules/secrets"
    "shared/modules/system/tmpfs/persistent"
  ]) ++ [
    # host specific modules
    inputs.home-estate.nixosModules.host.extrahosts
  ] ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # external modules
    inputs.home-estate.nixosModules.sdwan
  ];
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
