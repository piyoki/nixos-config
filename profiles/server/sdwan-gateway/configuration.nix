{ sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # host specific modules
    "system/users/server.nix"
    "system/packages/server.nix"
    "system/environment/server.nix"
    "system/services/openssh/server.nix"
    "system/services/zramd.nix"
    "system/networking/sdwan.nix"
    "system/networking/glider.nix"
    "system/internationalisation/locale.nix"
    "system/internationalisation/time.nix"

    # shared modules
    "shared/nixos.nix"
  ]) ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/networking.nix
    ./modules/routing.nix
    ./modules/packages.nix
    ./modules/sysctl.nix
    ./modules/users.nix
    ./modules/services.nix
  ];

  networking.hostName = "nixos-sdwan-gateway";
}
