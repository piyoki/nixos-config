{ pkgs, ... }:

{
  imports = [
    ./core.nix
  ];

  # extra packages
  environment.systemPackages = with pkgs; [
    # maintenance essentials
    bat
    jq
    zip
    unzip
    neofetch
    curl

    # monitoring
    htop

    # terminal
    tailspin # A log file highlighter
  ];
}
