{ lib, ... }:

with lib;
{
  services = {
    # enable reverse-proxy service
    reverse-proxy = {
      enable = true;
      autostart = mkForce true;
    };
  };
}
