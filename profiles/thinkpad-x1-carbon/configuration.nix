_:

{
  imports = [
    ./hardware-configuration.nix
    ./modules
    ../../system
    ../../themes
  ];

  # Set hostname
  networking.hostName = "nixos-x1-carbon";
}
