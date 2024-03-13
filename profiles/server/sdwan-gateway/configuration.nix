{ sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # host specific modules
    "system/networking/sdwan.nix"
    "system/networking/glider.nix"

    # shared modules
    "shared/server/system/base.nix"
  ]) ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/networking.nix
    ./modules/routing.nix
    ./modules/sysctl.nix
    ./modules/services.nix
  ];

  networking.hostName = "nixos-sdwan-gateway";
}
