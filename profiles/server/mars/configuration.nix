{ sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # host specific modules
    "system/services/scx.nix"
    "system/services/fish.nix"
    "system/services/docker.nix"
    "system/services/gnupg/server.nix"
    "system/users/init-pass.nix"

    # shared modules
    "shared/server/system/base.nix"
    "shared/server/system/services/sops.nix"
    "shared/modules/system/tmpfs/persistent"
    "shared/modules/secrets"
  ]) ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/networking.nix
  ];

  networking.hostName = "nixos-mars";

  modules = {
    # Import secrets
    secrets.server.system.base.enable = true;
    # Load persistent dirs and files
    persistent = {
      enable = true;
      hostType = "server";
    };
  };
}
