{ sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # host specific modules

    # shared modules
    "shared/server/system/base.nix"
    "shared/server/system/patches/sysctl-networking-tweaks.nix"
  ]) ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/networking.nix
    ./modules/routing.nix
    ./modules/services.nix
  ];

  networking.hostName = "nixos-sdwan-gateway";
}
