{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # basic but essential
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
