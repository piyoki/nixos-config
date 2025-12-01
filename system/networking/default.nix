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
    networkmanager = {
      enable = true;
      wifi.backend = "wpa_supplicant";
    };
    nftables.enable = true;
  };
}
