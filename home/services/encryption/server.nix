{ lib, restart, ... }:

{
  imports = [
    ./sops.nix
  ]
  ++ (lib.optionals (restart) [ ./systemd-restart ]);

  sops.age.keyFile = lib.mkForce "/run/secrets/age-yubikey-master-key";
}
