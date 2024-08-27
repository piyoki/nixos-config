{ lib, ... }:

{
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.useDHCP = mkDefault true;
  # networking.interfaces.ens18.useDHCP = mkDefault true;
  networking = {
    interfaces.ens18 = {
      useDHCP = lib.mkDefault false;
      ipv4.addresses = [{
        address = "192.168.2.8";
        prefixLength = 24;
      }];
    };
    defaultGateway = "192.168.2.1";
    nameservers = [ "67.69.235.1" "207.164.234.193" ];
  };
}
