{ lib, ... }:

{
  imports = [ ./default.nix ];

  services.openssh.settings.PermitRootLogin = lib.mkForce "yes"; # enable root login for remote deploy
}
