# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 10;

  networking.networkmanager.enable = true;
  networking.hostName = "nixos-mars";

  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";

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
      extraGroups = [ "wheel" "networkmanager" "docker"];
      shell = pkgs.fish;
      packages = with pkgs; [ fish ];
    };

    root = {
      shell = pkgs.bash;
    };
  };
  users.extraGroups.docker.members = [ "kev" ];

  programs.fish.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = true; # disable password login 
    };
  };

  zramSwap.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 ];

  environment.variables.EDITOR = "vim";

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  nix = {
    settings = {
      max-jobs = lib.mkDefault 8;
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];

    };
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 1w";
    };
  };

  system.stateVersion = "24.11";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
