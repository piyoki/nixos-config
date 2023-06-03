{ config, pkgs, lib, ... }:

{
  imports = [
    ./users.nix
    ./services.nix
    ./hardware-configuration.nix
  ];

  time.timeZone = "Asia/Hong_kong";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
    font = "Lat2-Terminus16";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    curl
    git
    neofetch
    nix-prefetch-scripts
    tmux
    tree
    vim
    wget
  ];
  environment.shells = with pkgs; [ fish ];

  system= {
    stateVersion = "23.05";
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  nix = {
    # enable flake
    extraOptions = "experimental-features = nix-command flakes";
    package = pkgs.nixFlakes;
    settings = {
      # auto cleanup 
      auto-optimise-store = true;
      max-jobs = lib.mkDefault 8;
    };
    # garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete older-than 7d";
    };
  };

}
