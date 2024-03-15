_:

let
  # default values
  home-manager = false;
in
{
  workstations = [
    { hostname = "thinkpad-x1-carbon"; home-manager = true; }
    { hostname = "nuc-12"; home-manager = true; }
  ];
  servers = [
    { hostname = "mars"; home-manager = true; }
    { hostname = "felix"; inherit home-manager; }
    { hostname = "sdwan-gateway"; inherit home-manager; }
    { hostname = "tailscale-gateway"; inherit home-manager; }
  ];
  microvms = [
    { hostname = "firecracker"; }
  ];
}
