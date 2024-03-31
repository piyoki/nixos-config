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

    # monitoring
    htop

    # terminal
    tailspin # A log file highlighter
  ];
}
