{ sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # host specific modules
    "system/services/scx.nix"
    "system/services/docker.nix"
    "system/services/atticd"

    # shared modules
    "shared/server/system/base.nix"
    "shared/modules/system/tmpfs/persistent"
    "shared/modules/secrets"
  ]) ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/networking.nix
  ];

  networking.hostName = "nixos-mars";

  modules = {
    # Load persistent dirs and files
    persistent = {
      enable = true;
      hostType = "server";
    };
  };
}
