{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # basic but essential
    git
    gnutar
    killall
    neofetch
    tmux
    tree
    vim
    wget
    ripgrep
    just
  ];
}
