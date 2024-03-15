{ sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # host specific modules
    "system/services/docker.nix"

    # shared modules
    "shared/server/system/base.nix"
    # "shared/modules/system/tmpfs/persistent/server.nix"
  ]) ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/networking.nix
  ];

  networking.hostName = "nixos-felix";
}
