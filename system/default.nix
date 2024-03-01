{ pkgs, lib, system, ... }:

{
  imports = [
    ./hardware
    ./networking
    ./security
    ./services
    ./secrets
    ./users
    ./environment
    ./packages
    ./internationalisation
  ];

  system = {
    stateVersion = "24.05";
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault system;

  nix = {
    # enable flake
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings = {
      # enable auto-cleanup
      auto-optimise-store = true;
      # set max-jobs
      max-jobs = lib.mkDefault 8;
    };

    # garbage collection
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete older-than 3d";
    };
  };
}
