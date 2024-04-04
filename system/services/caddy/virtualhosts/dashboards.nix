{ lib, ... }:

# References:
# https://nixos.wiki/wiki/Caddy
let
  genVirtualHost = hosts: (
    # (lib.attrsets.mergeAttrsList): merge attribute sets, expect input as a list
    lib.attrsets.mergeAttrsList (map
      (host: {
        "${host.fqdn}".extraConfig = ''
          ${(import (../common.nix)).hostCommonConfig}
          reverse_proxy ${host.backend}
        '';
      })
      hosts)
  );
in
{
  # Dashboard
  services.caddy.virtualHosts = genVirtualHost [
    { fqdn = "minio.homelab.local"; backend = "http://10.178.0.81:9090"; }
    { fqdn = "emby.homelab.local"; backend = "http://10.118.20.120:8096"; }
    { fqdn = "vaultwarden.homelab.local"; backend = "http://10.178.0.161:8080"; }
    { fqdn = "portainer.homelab.local"; backend = "http://10.178.0.81:9999"; }
    { fqdn = "qbit.homelab.local"; backend = "http://10.178.0.81:6363"; }
    { fqdn = "ros.homelab.local"; backend = "http://10.0.0.1:80"; }
    { fqdn = "rss.homelab.local"; backend = "http://10.118.20.50:5880"; }
    { fqdn = "semaphore.homelab.local"; backend = "http://10.178.0.40:3000"; }
    { fqdn = "qnap.homelab.local"; backend = "https://10.178.0.81:5001"; }
    { fqdn = "tmm.homelab.local"; backend = "http://10.118.20.122:5800"; }
    { fqdn = "unifi.homelab.local"; backend = "https://10.178.0.16:8443"; }
    { fqdn = "uptime.homelab.local"; backend = "http://10.118.20.47:3001"; }
    { fqdn = "notestation.homelab.local"; backend = "http://10.178.0.85:9400"; }
    { fqdn = "qumagie.homelab.local"; backend = "http://10.178.0.81:5000"; }
  ];
}
