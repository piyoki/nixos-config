{ pkgs, ... }:

{
  imports = [
    ./hardware
    ./networking
    ./security
    ./services
    ./users
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # nix usage
    nixpkgs-fmt # Nix code formatter for nixpkgs
    nix-prefetch-scripts # Collection of all the nix-prefetch-* scripts which may be used to obtain source hashes
    update-nix-fetchgit # A program to update fetchgit values in Nix expressions

    # basic but essential
    gnutar
    killall
    neofetch
    tmux
    tree
    vim
    wget

    # system call monitoring
    strace # system call monitoring
    bpftrace # powerful tracing tool
    tcpdump # network sniffer
    lsof # list open files

    # fish-related
    fishPlugins.fzf-fish

    # misc
    libnotify
  ];
}
