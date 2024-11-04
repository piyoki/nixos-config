{ pkgs, ... }:

{
  imports = [
    ./core.nix
  ];

  # extra packages
  environment.systemPackages = with pkgs; [
    # system essentials
    python3

    # maintenance essentials
    bat
    jq
    zip
    unzip
    neofetch
    curl
    ethtool
    pwgen
    openssl

    # monitoring
    htop
  ];
}
