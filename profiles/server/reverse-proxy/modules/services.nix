{ inputs, lib, ... }:

with lib;
{
  imports = [
    inputs.home-estate.nixosModules.caddy
  ];

  services = {
    # enable reverse-proxy service
    caddy = {
      enable = true;
      autostart = mkForce true;
    };
  };
}
