{ inputs, system, ... }:

{
  networking = {
    networkmanager.enable = true;
    firewall = {
      # Open ports in the firewall
      allowedTCPPorts = [ 22 ];
      # allowedUDPPorts = [ ... ];
      # enable = false; # disable the firewall
    };
    # Configure network proxy if necessary
    # proxy = {
    #   default = "http://user:password@proxy:port/";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # };
  };

  # sd-wan gateway
  environment.systemPackages =
    with inputs.daeuniverse.packages.${system}; [ dae ];
}
