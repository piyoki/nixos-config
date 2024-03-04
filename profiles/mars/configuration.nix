# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # system modules
      ../../system/services/fish.nix
      ../../system/services/docker.nix
      ../../system/services/openssh.nix
      ../../system/services/zramd.nix
      ../../system/internationalisation/locale.nix
      ../../system/internationalisation/time.nix

      # shared modules
      ../../shared/nixos.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 10;

  networking.networkmanager.enable = true;
  networking.hostName = "nixos-mars";

  environment.systemPackages = with pkgs; [
    git
    vim
    neofetch
    ripgrep
    curl
    wget
    just
  ];

  users.users = {
    kev = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker" ];
      shell = pkgs.fish;
      packages = with pkgs; [ fish ];
    };

    root = {
      shell = pkgs.bash;
    };
  };

  environment.variables.EDITOR = "vim";
}
