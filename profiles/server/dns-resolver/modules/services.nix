{ inputs, lib, ... }:

with lib;
{
  imports = [
    inputs.home-estate.nixosModules.mosdns
  ];

  services.mosdns = {
    # enable mosdns service
    enable = true;
    autostart = mkForce true;
  };
}
