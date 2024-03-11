{ inputs, lib, ... }:

with lib;
{
  imports = [ inputs.home-estate.nixosModules.sdwan ];

  services.sdwan = {
    enable = mkDefault true;
    autostart = mkDefault false;
  };
}
