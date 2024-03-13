{ lib, ... }:

{
  sops.age.keyFile = lib.mkForce "/run/keys/age-yubikey-master.key";
}
