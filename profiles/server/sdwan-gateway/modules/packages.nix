{ pkgs, ... }:

{
  # extra packages
  environment.systemPackages = with pkgs; [
    # maintenance essentials
    bash-completion
    bat
    jq
    unzip
    zip

    # monitoring
    htop

    # terminal
    tailspin # A log file highlighter
  ];
}
