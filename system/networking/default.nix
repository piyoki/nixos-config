{ inputs, system, pkgs, ... }:

{
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
    # Configure network proxy if necessary
    # proxy = {
    #   default = "http://user:password@proxy:port/";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # };
  };

  environment.systemPackages = with pkgs; [
    inputs.daeuniverse.packages.${system}.dae
    tailscale
  ];

  services = {
    tailscale.enable = true;
  };
}
