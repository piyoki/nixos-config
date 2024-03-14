{ sharedLib, lib, ... }:

{
  imports = map sharedLib.relativeToRoot [
    "system/networking/tailscale.nix"
    "system/networking/udp-gro-forwarding.nix"
  ];

  # enable tailscaled service
  systemd.services.tailscaled.wantedBy = lib.mkForce [ "multi-user.target" ];
}
