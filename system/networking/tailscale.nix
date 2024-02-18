{ pkgs, lib, ... }:

{
  # mesh network
  environment.systemPackages = with pkgs; [
    tailscale
  ];

  services = {
    tailscale.enable = true;
  };

  systemd.services.tailscaled.wantedBy = lib.mkForce [ ];
}
