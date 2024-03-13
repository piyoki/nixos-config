{ lib, ... }:

{
  # enable qemu-guest-agent
  services.qemuGuest.enable = lib.mkDefault true;
}
