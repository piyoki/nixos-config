_:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # host specific modules

    # shared modules
    ../../shared/nixos.nix
    ../../shared/server/system/base.nix
    ../../shared/modules/system/tmpfs/persistent/server.nix
  ];

  networking.hostName = "nixos-mars";
}
