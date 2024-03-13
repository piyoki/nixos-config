{ lib, ... }:

with lib;
{
  services = {
    # enable sdwan service
    sdwan = {
      enable = true;
      autostart = mkForce true;
    };
    # # enable glider service
    glider = {
      enable = true;
      autostart = mkForce true;
    };
  };
}
