{ lib, ... }:

{
  imports = [ ./sops.nix ];

  sops.age.keyFile = lib.mkForce "/run/secrets/age-yubikey-master-key";
}
