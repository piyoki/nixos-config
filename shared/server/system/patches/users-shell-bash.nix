{ pkgs, lib, user, ... }:

{
  # user patch
  users.users.${user}.shell = lib.mkForce pkgs.bash;
}
