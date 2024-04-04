_:

# References:
# https://nixos.wiki/wiki/Caddy
{
  services.caddy = {
    # https://caddyserver.com/docs/caddyfile/directives/file_server
    virtualHosts."file.homelab.local".extraConfig = ''
      root * /var/lib/caddy/fileserver/
      ${(import (../common.nix)).hostCommonConfig}
      file_server browse {
        hide .git
        precompressed zstd br gzip
      }
    '';
  };
}
