{ lib, ... }:

{
  # mesh network
  services.tailscale.enable = true;

  # disable systemd service
  systemd.services.tailscaled.wantedBy = lib.mkForce [ ];
}
