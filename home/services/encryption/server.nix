{ lib, ... }:

{
  imports = [
    ./sops.nix
    # TODO:
    # ./systemd-restart.nix
  ];

  sops.age.keyFile = lib.mkForce "/run/secrets/age-yubikey-master-key";
}
