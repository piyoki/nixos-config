_:

let
  commonPorts = [
    22 # ssh
    53317 # localsend
  ];
in
{
  networking.firewall = {
    enable = true;
    # open ports in firewall
    allowedTCPPorts = commonPorts;
    allowedUDPPorts = commonPorts;
  };
}
