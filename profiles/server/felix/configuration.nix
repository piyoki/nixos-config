{ lib, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # host specific modules

    # shared modules
    ../../../shared/nixos.nix
    ../../../shared/server/system/base.nix
    # ../../../shared/modules/system/tmpfs/persistent/server.nix
  ];

  networking = {
    hostName = "nixos-felix";
    interfaces.ens18 = {
      useDHCP = false;
      ipv4.addresses = [{
        address = "10.118.25.31";
        prefixLength = 24;
      }];
    };
    defaultGateway = "10.118.25.4";
    nameservers = [ "10.118.25.4" ];
  };

  # enable qemu-guest-agent
  services.qemuGuest.enable = lib.mkDefault true;
}
