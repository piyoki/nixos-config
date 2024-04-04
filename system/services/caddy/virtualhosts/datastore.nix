_:

# References:
# https://nixos.wiki/wiki/Caddy
{
  services.caddy = {
    # Datastore
    virtualHosts."s3.homelab.local".extraConfig = ''
      encode zstd gzip
      reverse_proxy http://10.178.0.81:9000
    '';
  };
}
