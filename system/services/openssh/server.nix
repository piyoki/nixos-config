{ lib, ... }:

{
  imports = [ ./default.nix ];

  services.openssh.settings.PermitRootLogin = lib.mkForce "prohibit-password"; # enable root login for remote deploy
}
