{ inputs, lib, ... }:

with lib;
{
  imports = [
    inputs.home-estate.nixosModules.caddy
  ];

  services.reverse-proxy.caddy = {
    # enable reverse-proxy service
    enable = true;
    autostart = mkForce true;
  };
}
