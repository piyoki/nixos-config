_:

# References:
# https://nixos.wiki/wiki/Caddy
{
  services.caddy = {
    # Dashboard
    virtualHosts."minio.homelab.local".extraConfig = ''
      ${(import (../common.nix)).hostCommonConfig}
      reverse_proxy http://10.178.0.81:9090
    '';
  };
}
