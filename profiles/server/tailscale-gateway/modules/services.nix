{ sharedLib, lib, ... }:

{
  imports = map sharedLib.relativeToRoot [
    "system/networking/tailscale.nix"
  ];

  # enable systemd service
  systemd.services.tailscaled.wantedBy = lib.mkForce [ "multi-user.target" ];
}
