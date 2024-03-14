{ sharedLib, lib, ... }:

with lib;
{
  imports = map sharedLib.relativeToRoot [
    "system/networking/sdwan.nix"
    "system/networking/glider.nix"
  ];

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
