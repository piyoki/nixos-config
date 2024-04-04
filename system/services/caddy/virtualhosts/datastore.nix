{ lib, ... }:

# References:
# https://nixos.wiki/wiki/Caddy
let
  genVirtualHost = hosts: (
    # (lib.attrsets.mergeAttrsList): merge attribute sets, expect input as a list
    lib.attrsets.mergeAttrsList (map
      (host: {
        "${host.fqdn}".extraConfig = ''
          encode zstd gzip
          reverse_proxy ${host.backend}
        '';
      })
      hosts)
  );
in
{
  # Datastore
  services.caddy.virtualHosts = genVirtualHost [
    { fqdn = "s3.homelab.local"; backend = "http://10.178.0.81:9000"; }
  ];
}
