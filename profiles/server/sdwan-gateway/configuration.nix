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
    "system/networking/glider.nix"
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
    extraGroups = mkForce [ "wheel" ];
    hashedPassword = "$7$CU..../....nnOYNef.N4rHN9q8TseVo1$cgf5w2iAkrNXxU1uwGI0HlFFGuwcU3l507b67v0Kp49";
  };

  # extra packages
  environment.systemPackages = with pkgs; [
    # maintenance essentials
    bash-completion
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


  services = {
    # enable qemu-guest-agent
    qemuGuest.enable = mkDefault true;
    # enable sdwan service
    sdwan = {
      enable = true;
      autostart = mkForce true;
    };
    # # enable glider service
    glider = {
      enable = true;
      autostart = mkForce true;
    };
  };
}
