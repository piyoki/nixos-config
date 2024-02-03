# Bootstrap System

## Table of Contents

<!-- vim-markdown-toc GFM -->

* [Partition drives](#partition-drives)
* [Create encryption](#create-encryption)
* [Format partitions](#format-partitions)
* [Create sub-volumes](#create-sub-volumes)
* [Generate Nix configurations](#generate-nix-configurations)
* [Build the system](#build-the-system)

<!-- vim-markdown-toc -->

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
cd
umount /mnt
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@ /dev/mapper/root /mnt
mkdir /mnt/{boot,home,nix,snapshots}
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@home /dev/mapper/root /mnt/home/
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@nix /dev/mapper/root /mnt/nix/
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@snapshots /dev/mapper/root /mnt/snapshots/
mount /dev/nvme0n1p1 /mnt/boot
# verify mount points
lsblk
```

## Generate Nix configurations

Reference: https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html

```bash
nixos-generate-config --root /mnt
```

This should result with `/mnt/etc/nixos/hardware-configuration.nix`.

Although it’s possible to customize `/etc/nixos/configuration.nix` at this point to set up all the things you need in one fell swoop, I recommend starting out with a reletively minimal config (bare bone) to make sure everything works fine. I went with something like this:

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
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Enable zramd.
  zramSwap.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.delta = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  system.stateVersion = "21.03";
}
```

## Build the system

Take a deep breath.

```bash
nixos-install
reboot
```

If all goes well, we’ll be prompted for the passphrase for $DISK entered earlier. Switch to another `tty` with `Ctrl+Alt+F1`, login as `root`, passwd <passwd> to set your password. Once you’re logged in, you can continue to tweak your NixOS configuration as you want. However, I generally recommend keeping enabled services at a minimum, and setting up opt-in state first.
