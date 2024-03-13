{ lib, ... }:

with lib;
{
  services = {
    # enable qemu-guest-agent
    qemuGuest.enable = mkDefault true;
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
