{ sharedLib, lib, ... }:

with lib;
{
  imports = (map sharedLib.relativeToRoot [
    # host specific modules
    "system/services/docker.nix"
    "system/services/gnupg/server.nix"

    # shared modules
    "shared/modules/secrets"
    "shared/modules/system/tmpfs/persistent"
    "shared/server/system/base.nix"
  ]) ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking. hostName = "nixos-mars";

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.useDHCP = mkDefault true;
  # networking.interfaces.ens18.useDHCP = mkDefault true;
  networking = {
    interfaces.ens18 = {
      useDHCP = mkDefault false;
      ipv4.addresses = [{
        address = "10.118.25.30";
        prefixLength = 24;
      }];
    };
    defaultGateway = "10.118.25.4";
    nameservers = [ "10.118.25.4" ];
  };

  # enable qemu-guest-agent
  services.qemuGuest.enable = mkDefault true;

  # Import secrets
  modules = {
    secrets.server.system.base.enable = true;
    # Load persistent dirs and files
    persistent = {
      enable = true;
      hostType = "server";
    };
  };
}
