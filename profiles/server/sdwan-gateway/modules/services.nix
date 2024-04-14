{ inputs, sharedLib, lib, ... }:

with lib;
{
  imports = [
    inputs.home-estate.nixosModules.sdwan
    inputs.home-estate.nixosModules.glider
  ] ++ (map sharedLib.relativeToRoot [
    "system/networking/udp-gro-forwarding.nix"
  ]);

  services = {
    # enable sdwan service
    sdwan = {
      enable = true;
      autostart = mkForce true;
    };
    # enable glider service
    glider = {
      enable = true;
      autostart = mkForce true;
    };
  };
}
