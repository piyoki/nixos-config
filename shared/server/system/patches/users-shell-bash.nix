{ pkgs, lib, user, ... }:

with lib;
{
  # user patch
  users.users.${user} = {
    shell = mkForce pkgs.bash;
    extraGroups = mkForce [ "wheel" ];
  };
}
