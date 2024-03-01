_:

{
  imports = [
    ./hardware-configuration.nix
    ../../system
    ../../themes
  ];

  # Set hostname
  networking.hostName = "nixos-x1-carbon";
}
