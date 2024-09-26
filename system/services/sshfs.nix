{ pkgs, ... }:

# Reference:
# https://wiki.nixos.org/wiki/SSHFS
# https://unix.stackexchange.com/questions/94720/connection-reset-by-peer-using-sshfs

# Quick connection command:
# sshfs -o debug,sshfs_debug,loglevel=debug,allow_other,default_permissions <user>@<host>:<remote_mount_path> -p <port> <local_mount_path>

{
  environment.systemPackages = with pkgs; [ sshfs ];
  programs.fuse.userAllowOther = true;
}
