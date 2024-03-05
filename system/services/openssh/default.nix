{ lib, ... }:

{
  # enable openssh daemon
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = lib.mkDefault "prohibit-password"; # disable root login
      PasswordAuthentication = lib.mkDefault false; # disable password login
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 5598 ];
}
