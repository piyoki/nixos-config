_:

# References:
# https://nixos.wiki/wiki/Caddy
{
  imports = [
    ./global.nix
    ./virtualhosts
  ];

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
