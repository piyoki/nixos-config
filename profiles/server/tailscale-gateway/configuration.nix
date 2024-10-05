{ inputs, sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # host specific modules
    "system/services/scx.nix"

    # shared modules
    "shared/server/system/base.nix"
    "shared/server/system/patches/sysctl-networking-tweaks.nix"
  ]) ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # host specific modules
    inputs.home-estate.nixosModules.host.networking.tailscale-gateway
    ./modules/services.nix
  ];

  networking.hostName = "nixos-tailscale-gateway";
}
