{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # basic but essential
    bash-completion
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
