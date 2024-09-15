{ pkgs, ... }:

{
  imports = [
    ./firewall
    ./tailscale.nix
  ];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet # network manager (gtk GUI)
    dnsutils
  ];

  networking = {
    networkmanager.enable = true;
    nftables.enable = true;
  };
}
