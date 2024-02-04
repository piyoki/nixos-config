{ pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nix-prefetch-scripts
    tmux
    tree
    vim
    wget

    # bluetooth
    blueberry

    # audio
    pavucontrol
    pamixer

    # display
    ddcutil

    # xdg-related
    xdg-utils
    xdg-user-dirs # run: xdg-user-dirs-update

    # fish-related
    fishPlugins.fzf-fish
  ];
}
