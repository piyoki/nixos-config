{ user, lib, ... }:

{
  users.users.${user}.extraGroups = lib.mkDefault ([
    "networkmanager"
    "wheel"
  ] ++ (import ./libvirtd.nix));
}
