{ sharedLib, lib, ... }:

with lib;
{
  imports = (map sharedLib.relativeToRoot [
    # host specific modules
    "system/services/docker.nix"

    # shared modules
    # "shared/modules/system/tmpfs/persistent/server.nix"
    "shared/server/system/base.nix"
    "shared/server/system/patches/users-shell-bash.nix"
  ]) ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos-felix";
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
        address = "10.118.25.31";
        prefixLength = 24;
      }];
    };
    defaultGateway = "10.118.25.4";
    nameservers = [ "10.118.25.4" ];
  };
}
