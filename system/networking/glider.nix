{ inputs, lib, ... }:

{
  imports = [ inputs.home-estate.nixosModules.glider ];

  services.glider = {
    enable = lib.mkDefault true;
    autostart = lib.mkDefault false;
  };
}
