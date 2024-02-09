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
    nix-prefetch-scripts
    update-nix-fetchgit

    # basic but essential
    tmux
    tree
    vim
    wget
    gnutar

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
