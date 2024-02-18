{ lib, pkgs, system, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../system
    ../../themes
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "btrfs" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  hardware.enableAllFirmware = true;

  # Set hostname
  networking.hostName = "nixos-x1-carbon";

  # Select internationalisation properties
  time.timeZone = (import ../../vars.nix).defaultTimeZone;
  i18n.defaultLocale = (import ../../vars.nix).defaultLocale;
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-chinese-addons
      fcitx5-material-color
    ];
  };

  # NixOS configuration (with HomeManager)
  system = {
    stateVersion = "24.05";
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = lib.mkDefault system;
  };

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
      dates = "weekly";
      options = "--delete older-than 3d";
    };
  };
}
