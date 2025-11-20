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
* [Reboot the system](#reboot-the-system)
* [Network configuration](#network-configuration)
* [Flake integration](#flake-integration)
* [Home-manager integration](#home-manager-integration)
* [Binary cache usage](#binary-cache-usage)
* [Personal Usage](#personal-usage)
  * [Prepare private key to decrypt secrets](#prepare-private-key-to-decrypt-secrets)
  * [SSH Key](#ssh-key)
  * [Update hash for the key upstream inputs](#update-hash-for-the-key-upstream-inputs)
  * [Specify profile in the environment](#specify-profile-in-the-environment)
  * [Backup legacy configuration to persistent volume](#backup-legacy-configuration-to-persistent-volume)
  * [Persistence for tmpfs](#persistence-for-tmpfs)
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
cd
umount /mnt
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@ /dev/mapper/root /mnt
mkdir /mnt/{boot,home,nix,snapshots}
# for tmpfs filesystem only
# mkdir /mnt/{boot,home,nix,snapshots,persistent}
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@home /dev/mapper/root /mnt/home/
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@nix /dev/mapper/root /mnt/nix/
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@snapshots /dev/mapper/root /mnt/snapshots/
# for tmpfs filesystem only
# mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@persistent /dev/mapper/root /mnt/persistent/
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
blkid /dev/nvme0n1p2
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
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
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
    packages = with pkgs; [ firefox just ];
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

  # Enable Flakes
  nix.extraOptions = "experimental-features = nix-command flakes";
  # Nix settings
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

## Reboot the system

If all goes well, we’ll be prompted for the passphrase for $DISK entered earlier. Switch to another `tty` with `Ctrl+Alt+F1`, login as `root`, passwd <passwd> to set your password. Once you’re logged in, you can continue to tweak your NixOS configuration as you want. However, I generally recommend keeping enabled services at a minimum, and setting up opt-in state first.

## Network configuration

If you are using a wired connection, you can skip this step. Otherwise, you can use `nmtui` to configure your network.

```bash
sudo nmtui
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
# with just recipe
just b
```

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

## Personal Usage

### Prepare private key to decrypt secrets

Place the master key for decryption of secrets in `/var/lib/age/age-yubikey-master.key`.

### SSH Key

Download the authorized private key to the new machine, and place it in `~/.ssh/id_rsa`. Make sure the permissions are set correctly:

```bash
sudo chown <username> ~/.ssh/id_rsa
sudo chmod 0400 ~/.ssh/id_rsa
```

Add the following line to `~/.ssh/config`:

```ssh
Host *
  StrictHostKeyChecking no
  LogLevel quiet

# Public services
# Using SSH over the HTTPS port
# Ref: https://docs.github.com/en/authentication/troubleshooting-ssh/using-ssh-over-the-https-port
Host github.com
  Hostname ssh.github.com
  Port 443
  User git
  IdentityFile ~/.ssh/id_rsa
```

Clone the repository using SSH:

```bash
# clone the repository recursively with submodules
git clone git@github.com:piyoki/nixos-config.git --recursive ~/flake
# update submodules
git submodule update --remote --recursive
# checkout to the master branch for each submodule
cd ~/flake
cd secrets/
git checkout master
cd ..
cd home-estate/
git checkout master
cd ..
```

### Update hash for the key upstream inputs

Run the justfile recipe to update the hashes for the key upstream inputs:

```bash
# update the hash associated with the submodules
just upp home-estate
just upp secrets
# update the hash for the key upstream inputs
just up
```

### Specify profile in the environment

Add the following line to `~/.env`:

```env
PROFILE=<profile name>
```

### Backup legacy configuration to persistent volume

```bash
sudo mkdir -p /persistent/etc/nixos/
sudo cp -r /etc/nixos /persistent/etc/
```

### Persistence for tmpfs

> [!NOTE]
> Please make sure the system is running as expected before enabling persistence for tmpfs. Otherwise, the system may fail to boot.
> Files and directories to be copied to are under ../shared/modules/system/tmpfs/persistent/

Copy the necessary files and directories to the persistent volume:

```bash
# e.g.
sudo cp -r /home/<username> /persistent/
sudo cp -r /etc /persistent/
```

Make sure to change the ownership of the home directory to the user:

```bash
sudo chown -R <username>:users /home/<username>
```

## References

- [NixOS Installation Guide](https://nixos.wiki/wiki/NixOS_Installation_Guide)
- [NixOS Installation on Virtual Machine Guide - ZH](https://nixos-cn.org/tutorials/installation/VirtualMachine.html)
