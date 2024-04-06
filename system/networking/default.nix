{ pkgs, ... }:

let
  commonPorts = [
    22 # ssh
    53317 # localsend
  ];
in
{
  imports = [
    ./sdwan.nix
    ./tailscale.nix
    ./networkmanager.nix
    ./udp-gro-forwarding.nix
  ];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet # network manager (gtk GUI)
    dnsutils
  ];

  networking = {
    nftables.enable = true;
    firewall = {
      enable = true;
      # open ports in firewall
      allowedTCPPorts = commonPorts;
      allowedUDPPorts = commonPorts;
    };
  };
}
