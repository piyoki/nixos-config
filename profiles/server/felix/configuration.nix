{ lib, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # host specific modules
    # ../../../system/services/docker.nix
    ../../../system/services/gnupg/server.nix

    # shared modules
    ../../../shared/modules/secrets
    # ../../../shared/modules/system/tmpfs/persistent/server.nix
    ../../../shared/server/system/base.nix
  ];

  networking.hostName = "nixos-felix";
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
        address = "10.118.25.31";
        prefixLength = 24;
      }];
    };
    defaultGateway = "10.118.25.4";
    nameservers = [ "10.118.25.4" ];
  };

  # enable qemu-guest-agent
  services.qemuGuest.enable = lib.mkDefault true;

  # Import secrets
  modules.secrets.server.system.base.enable = true;
}
