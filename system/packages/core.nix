{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # basic but essential
    bash-completion
    git
    gnutar
    killall
    neofetch
    screen
    tmux
    tree
    vim
    wget
    ripgrep
    just
    pwgen
    openssl
    dnsutils
  ];
}
