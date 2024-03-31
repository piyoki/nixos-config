{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # maintenance essentials
    delta
    lazygit
    neovim
    zoxide
    trash-cli

    # monitoring
    btop
    ncdu # disk utilization
    duf # disk usage analyzer

    # terminal
    fd
    fzf

    # fish plugins
    fishPlugins.fzf-fish
  ];
}
