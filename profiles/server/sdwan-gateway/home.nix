{ sharedLib, pkgs, ... }:

{
  imports = map sharedLib.relativeToRoot [
    # common modules
    "shared/home.nix"
    "shared/options.nix"

    # host specific modules
    "home/apps/tmux"
    "home/apps/bat"
  ];

  home.packages = with pkgs; [
    # maintenance essentials
    bat
    delta
    jq
    vim
    unzip
    zip

    # monitoring
    htop

    # terminal
    neofetch
    tailspin # A log file highlighter
  ];
}
