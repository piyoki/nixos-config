{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # maintenance essentials
    bat
    delta
    jq
    lazygit
    neovim
    vivid
    zoxide
    trash-cli
    unzip
    zip

    # monitoring
    btop
    htop
    ncdu # disk utilization
    duf # disk usage analyzer

    # terminal
    fd
    fzf
    tailspin # A log file highlighter
  ];
}
