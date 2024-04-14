{ inputs, lib, ... }:

with lib;
{
  imports = [
    inputs.home-estate.nixosModules.reverse-proxy
  ];

  services = {
    # enable reverse-proxy service
    reverse-proxy = {
      enable = true;
      autostart = mkForce true;
    };
  };
}
