{ config, pkgs, lib, ... }:

let
  user = "kev";
in
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  time.timeZone = "Asia/Hong_kong";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
    font = "Lat2-Terminus16";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = false;
      autorun = false;
      layout = "us";
      # xkbOptions = "eurosign:e,caps:escape";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
    # Add ssh public key
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCwdl7F0NrGj+Z6LW6qg50SSC1cm7brKlujQdNt4+Bw6tnxL8uL9FNSBhgcscArCNRSZXw3RTMoyq2gH5SDClMtAstSicf8ReNXl4p5/aR94yE+baUFucHDFtJI1nKUdIy/2gPus9jtVY2AabtC4lhx+LN8tJ6AGHJNQvoQVcdQzGTuy2fk+HdtSm7HKOhAL0vh8tQXx/tHWz1y0sucqfK/ZNN5ATzwpy3/8hWQSwN1avv0mAcMm4Otx3RobIB4CtYcP9qFUM7d2nsa5vSskuB/eL9prz+zhtYnVxU/AdO5AVsSDIl71wBKHA/hC2lZscBaWCMQz61KvDnt+Gxr3Astpeytz9NQZvb1wvm678KrpvSeE6OXqsAYnuGUbgIZ194SShKYTHmpRZQT5presmpKXQQyORaNldx+yqpYTdRbsMjndSpPYauJJUygdnmTpRZ5MXFitckQ9LcHUW9R+HdWNV2yyQaSIjR7FZAjMwWy4ifeUIzcNUMkMKGEHI1q0Dk= kev@arch-desktop"
    ];
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.fish.enable = true;

  # Install Docker
  virtualisation.docker.enable = true;

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  services = {
    qemuGuest.enable = true;
    openssh = {
      enable = true;
      # Disable SSH password log in
      settings.PasswordAuthentication = false;
    };
  };

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
    extraOptions = "experimental-features = nix-command flakes";
    package = pkgs.nixFlakes;
    settings = {
      auto-optimise-store = true;
      max-jobs = lib.mkDefault 8;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete older-than 7d";
    };
  };

}
