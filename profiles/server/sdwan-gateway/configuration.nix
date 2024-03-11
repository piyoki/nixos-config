{ sharedLib, pkgs, lib, user, ... }:

with lib;
{
  imports = (map sharedLib.relativeToRoot [
    # host specific modules
    "system/users/server.nix"
    "system/packages/server.nix"
    "system/environment/server.nix"
    "system/services/openssh/server.nix"
    "system/services/zramd.nix"
    "system/networking/sdwan.nix"
    "system/internationalisation/locale.nix"
    "system/internationalisation/time.nix"

    # shared modules
    "shared/nixos.nix"
  ]) ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # user patch
  users.users.${user} = {
    shell = mkForce pkgs.bash;
    packages = mkForce [ ];
  };

  # extra packages

  environment.systemPackages = with pkgs; [
    # maintenance essentials
    bat
    jq
    unzip
    zip

    # monitoring
    htop

    # terminal
    tailspin # A log file highlighter
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

  # enable sdwan service
  services.sdwan = {
    enable = true;
    autostart = mkForce true;
  };
}
