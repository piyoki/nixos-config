{ lib, ... }:

{
  # enable openssh daemon
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = lib.mkDefault "no"; # disable root login
      PasswordAuthentication = lib.mkDefault true; # disable password login
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 5598 ];
}
