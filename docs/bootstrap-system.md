# Bootstrap System

## Table of Contents

<!-- vim-markdown-toc GFM -->

* [Partition drives](#partition-drives)
* [Create encryption](#create-encryption)
* [Format partitions](#format-partitions)
* [Create sub-volumes](#create-sub-volumes)
* [Generate Nix configurations](#generate-nix-configurations)

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
