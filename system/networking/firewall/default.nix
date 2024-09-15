_:

let
  commonPorts = [
    22 # ssh
    53317 # localsend
  ];
  specialUDPPorts = [
    41641 # tailscale for peer-to-peer connection
  ];
in
{
  networking.firewall = {
    enable = true;
    # open ports in firewall
    allowedTCPPorts = commonPorts;
    allowedUDPPorts = commonPorts ++ specialUDPPorts;
  };
}
