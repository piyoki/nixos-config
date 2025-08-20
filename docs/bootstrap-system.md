# Bootstrap System

## Table of Contents

<!-- vim-markdown-toc GFM -->

* [Wipe drives](#wipe-drives)
* [Partition drives](#partition-drives)
* [Create encryption](#create-encryption)
* [Format partitions](#format-partitions)
* [Create sub-volumes](#create-sub-volumes)
* [Generate Nix configurations](#generate-nix-configurations)
* [Build the system](#build-the-system)
* [Flake integration](#flake-integration)
* [Home-manager integration](#home-manager-integration)
* [References](#references)

<!-- vim-markdown-toc -->

## Wipe drives

With `wipefs`

```bash
wipefs --all /dev/sda
```

## Partition drives

With `cfdisk`

```bash
cfdisk /dev/nvme0n1
```

## Create encryption

```bash
# create encryption
cryptsetup --cipher aes-xts-plain64 --hash sha512 --use-random --verify-passphrase luksFormat /dev/nvme0n1p2
# YES
# enter passphrase
# verify passphrase

# open partition
cryptsetup luksOpen /dev/nvme0n1p2 root
# enter passphrase

# view mapper status
cryptsetup -v status root

# format LUKS partition
wipefs --all /dev/mapper/root
# OR
dd if=/dev/zero of=/dev/mapper/root
```

## Format partitions

```bash
mkfs.btrfs /dev/mapper/root
mkfs.fat -F32 /dev/nvme0n1p1
# verify new partitions
lsblk
```

## Create sub-volumes

```bash
mount /dev/mapper/root /mnt
cd /mnt
btrfs subvolume create @
btrfs subvolume create @home
btrfs subvolume create @nix
btrfs subvolume create @snapshots
# for tmpfs filesystem only
# btrfs subvolume create @persistent
# btrfs subvolume create @tmp
cd
umount /mnt
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@ /dev/mapper/root /mnt
mkdir /mnt/{boot,home,nix,snapshots}
# for tmpfs filesystem only
# mkdir /mnt/{boot,home,nix,snapshots,persistent,tmp}
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@home /dev/mapper/root /mnt/home/
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@nix /dev/mapper/root /mnt/nix/
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@snapshots /dev/mapper/root /mnt/snapshots/
# for tmpfs filesystem only
# mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@persistent /dev/mapper/root /mnt/persistent/
# mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@tmp /dev/mapper/root /mnt/tmp/
mount /dev/nvme0n1p1 /mnt/boot
# verify mount points
lsblk -o PATH,FSTYPE,MOUNTPOINT /dev/nvme0n1
```

## Generate Nix configurations

Reference: https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html

```bash
nixos-generate-config --root /mnt
```

This should result with `/mnt/etc/nixos/hardware-configuration.nix`.

```nix
{
  ...

  # Add the followings
  # Power Management
  powerManagement.cpuFreqGoverner = lib.mkDefault "powersaver";
  # High-DPI console
  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
}
```

Make sure you have the right `UUID` mappings for your partitions

```bash
# check uuid for a specific partition
blkid /dev/nvme0n1p1
blkid /dev/mapper/root
```

> [!NOTE]
> Although it’s possible to customize `/etc/nixos/configuration.nix` at this point to set up all the things you need in one fell swoop, I recommend starting out with a reletively minimal config (bare bone) to make sure everything works fine. I went with something like this:

```nix
{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "btrfs" ];
  hardware.enableAllFirmware = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set timezone.
  time.timeZone = "Asia/Hong_Kong";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kev = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ firefox ];
  };

  # Enable openssh daemon.
  services.openssh.enable = true;

  # Enable zramd daemon.
  zramSwap.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search <pkg>
  environment.systemPackages = with pkgs; [ vim git wget ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];

  nix.settings.max-jobs = lib.mkDefault 8;
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "21.11";
}
```

## Build the system

Take a deep breath.

```bash
nixos-install
reboot
```

If all goes well, we’ll be prompted for the passphrase for $DISK entered earlier. Switch to another `tty` with `Ctrl+Alt+F1`, login as `root`, passwd <passwd> to set your password. Once you’re logged in, you can continue to tweak your NixOS configuration as you want. However, I generally recommend keeping enabled services at a minimum, and setting up opt-in state first.

## Binary cache usage

> [!NOTE]
> A binary cache builds Nix packages and caches the result for other machines. Any machine with Nix installed can be a binary cache for another one, no matter the operating system.
> If you are facing problems with derivations not being in a cache, try switching to a release version. Most caches will have many derivations for a specific release.

Reference: https://nixos.wiki/wiki/Binary_Cache

```nix
# /etc/nixos/configuration.nix
{
  nix = {
    settings = {
      substituters = [
        "http://binarycache.example.com"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "binarycache.example.com-1:dsafdafDFW123fdasfa123124FADSAD"
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
```

## Flake integration

Start with the following barebone configuraton

```nix
# flake.nix
{
  outputs = { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      # use a system-specific version of nixpkgs
      pkgs = (import nixpkgs) {
        inherit system;
        config.allowUnfree = lib.mkDefault true;
      };
      inherit (nixpkgs) lib;
      inherit (import ./vars.nix) user;
      specialArgs = { inherit inputs pkgs system user; };
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ./configuration.nix
          ];
        };
    };
  }

  inputs = {
    # public source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  }
}
```

Rebuild system with flake

```bash
sudo nixos-rebuild switch --upgrade --flake .#nixos
```

## Home-manager integration

Start with the following barebone configuraton

```nix
# vars.nix
{
  user = "kev";
  defaultLocale = "en_US.UTF-8";
  defaultTimeZone = "Asia/Hong_Kong";
  stateVersion = "24.11";
}
```

```nix
# flake.nix
{
  # NixOS configuration (with HomeManager)
  # build system
  outputs = { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      # use a system-specific version of nixpkgs
      pkgs = (import nixpkgs) {
        inherit system;
        config.allowUnfree = lib.mkDefault true;
      };
      inherit (nixpkgs) lib;
      inherit (import ./vars.nix) user;
      specialArgs = { inherit inputs pkgs system user; };
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit specialArgs;
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = specialArgs;
                users.${user} = import ./home;
                sharedModules = [ ];
              };
            }
            ./configuration.nix
          ];
        };
    }
  }

  inputs = {
    # public source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  }
}
```

Rebuild system with flake

```bash
sudo nixos-rebuild switch --upgrade --flake .#nixos
```

## References

- [NixOS Installation Guide](https://nixos.wiki/wiki/NixOS_Installation_Guide)
- [NixOS Installation on Virtual Machine Guide - ZH](https://nixos-cn.org/tutorials/installation/VirtualMachine.html)
