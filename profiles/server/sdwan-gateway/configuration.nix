{ sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # host specific modules
    "system/users/server.nix"
    "system/packages/server.nix"
    "system/services/openssh/server.nix"
    "system/services/zramd.nix"
    "system/networking/sdwan.nix"
    "system/networking/glider.nix"
    "system/internationalisation/locale.nix"
    "system/internationalisation/time.nix"
    "system/environment"

    # shared modules
    "shared/nixos.nix"
    "shared/server/system/patches/users-shell-bash.nix"
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
