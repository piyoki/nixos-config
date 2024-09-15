_:

{
  # open ports in firewall
  networking.firewall = {
    allowedUDPPorts = [
      5353
      6969
    ];
    allowedUDPPortRanges = [
      { from = 136; to = 139; }
      { from = 1900; to = 1901; }
      { from = 6001; to = 6002; }
      { from = 30000; to = 65535; }
    ];
  };
}
