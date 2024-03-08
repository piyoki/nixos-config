{ lib, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # host specific modules

    # shared modules
    ../../../shared/nixos.nix
    ../../../shared/server/system/base.nix
    ../../../shared/modules/system/tmpfs/persistent/server.nix
  ];

  networking. hostName = "nixos-felix";

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.ens18.useDHCP = lib.mkDefault true;
  networking = {
    interfaces.ens18 = {
      useDHCP = lib.mkDefault false;
      ipv4.addresses = [{
        address = "10.118.25.30";
        prefixLength = 24;
      }];
    };
    defaultGateway = "10.118.25.4";
    nameservers = [ "10.118.25.4" ];
  };

  # enable qemu-guest-agent
  services.qemuGuest.enable = lib.mkDefault true;
}
