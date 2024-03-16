{ lib, pkgs-small, system, ... }:

{
  networking.hostName = "firecracker-microvm";
  users.users.root.password = "passwd";
  system = {
    inherit (import ../../vars) stateVersion;
  };
  nixpkgs.hostPlatform = lib.mkDefault system;
  boot.kernelPackages = pkgs-small.linuxPackages_latest;
  microvm = {
    hypervisor = "firecracker";
    socket = "control.socket";
    volumes = [{
      mountPoint = "/var";
      image = "var.img";
      size = 256;
    }];
  };
}
