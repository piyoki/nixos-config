{ inputs, pkgs, system, ... }:

{
  home.packages = with pkgs; [
    # maintenance essentials
    delta
    lazygit
    zoxide
    trash-cli

    # editor
    inputs.neovim-nightly-overlay.packages.${system}.default

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
