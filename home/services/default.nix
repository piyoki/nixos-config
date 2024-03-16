{ sharedLib, ... }:

{
  imports = sharedLib.scanPaths ./.;

  # disable dunst systemd service, controlled it by windowmanager instead
  services.dunst.enable = false;
}
