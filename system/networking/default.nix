{ pkgs, ... }:

{
  imports = [
    ./sdwan.nix
    ./tailscale.nix
  ];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet # network manager (gtk GUI)
    dnsutils
  ];

  networking = {
    nftables.enable = true;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      # Open ports in the firewall
      allowedTCPPorts = [
        22 # ssh
        53317 # localsend
      ];
      allowedUDPPorts = [
        53317 # localsend
      ];
    };
  };
}
