{ sharedLib, lib, ... }:

with lib;
{
  imports = (map sharedLib.relativeToRoot [
    # host specific modules

    # shared modules
    "shared/modules/secrets"
    "shared/server/system/base.nix"
  ]) ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos-sdwan-gateway";
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
        address = "10.0.0.50";
        prefixLength = 24;
      }];
      ipv6.addresses = [{
        address = "fd00::50";
        prefixLength = 64;
      }];
    };
    interfaces.ens19 = {
      useDHCP = mkDefault false;
      ipv4.addresses = [{
        address = "10.20.0.28";
        prefixLength = 24;
      }];
    };
    defaultGateway = "10.0.0.1";
    nameservers = [ "223.5.5.5" ];
  };

  # enable qemu-guest-agent
  services.qemuGuest.enable = mkDefault true;

  # Import secrets
  modules.secrets.server.system.base.enable = true;
}
