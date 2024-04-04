_:

# References:
# https://nixos.wiki/wiki/Caddy
# https://github.com/ryan4yin/nix-config/pull/112
{
  imports = [
    ./global.nix
    ./virtualhosts
  ];
}
