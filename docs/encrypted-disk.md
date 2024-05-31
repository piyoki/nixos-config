# Encrypted Disk

## Table of Contents

<!-- vim-markdown-toc GFM -->

* [Wipe drives](#wipe-drives)
* [Partition drives](#partition-drives)
* [Create encryption](#create-encryption)
* [Format partitions](#format-partitions)
* [Create sub-volumes](#create-sub-volumes)
* [Open partition](#open-partition)
* [Mount disk](#mount-disk)
* [Change ownership](#change-ownership)
* [Unmount disk](#unmount-disk)

<!-- vim-markdown-toc -->

## Wipe drives

With `wipefs`

```bash
wipefs --all /dev/sda
```

## Partition drives

With `cfdisk`

```bash
cfdisk /dev/sda
```

## Create encryption

```bash
# create encryption
cryptsetup --cipher aes-xts-plain64 --hash sha512 --use-random --verify-passphrase luksFormat /dev/sda
# YES
# enter passphrase
# verify passphrase

# open partition
cryptsetup luksOpen /dev/sda ext
# enter passphrase
```

## Format partitions

```bash
mkfs.btrfs /dev/mapper/ext
# verify new partitions
lsblk
```

## Create sub-volumes

```bash
mount /dev/mapper/ext /mnt
cd /mnt
btrfs subvolume create @
cd
umount /mnt
```

---

## Open partition

```bash
cryptsetup luksOpen /dev/sda ext
```

## Mount disk

```bash
mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@ /dev/mapper/ext /mnt/
# enter passphrase
```

## Change ownership

```bash
chown -R kev:users /mnt
```

## Unmount disk

```bash
umount /mnt
cryptsetup luksClose ext
```
