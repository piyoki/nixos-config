{ lib, ... }:

with lib;
{
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
        address = "10.189.18.10";
        prefixLength = 24;
      }];
    };
    interfaces.ens19 = {
      useDHCP = mkDefault false;
      ipv6.addresses = [{
        address = "fd00::88";
        prefixLength = 64;
      }];
    };
    defaultGateway = "10.189.18.4";
    defaultGateway6 = { address = "fd00::1"; interface = "ens19"; };
    nameservers = [ "10.189.18.4" ];
  };
}
