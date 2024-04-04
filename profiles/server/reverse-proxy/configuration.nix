{ sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # host specific modules
    "system/services/scx.nix"
    "system/services/caddy"

    # shared modules
    "shared/server/system/base.nix"
  ]) ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/networking.nix
  ];

  networking.hostName = "nixos-reverse-proxy";
}
