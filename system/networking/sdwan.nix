{ inputs, ... }:

{
  imports = [ inputs.home-estate.nixosModules.sdwan ];

  services.sdwan = {
    enable = true;
    autostart = false;
  };
}
