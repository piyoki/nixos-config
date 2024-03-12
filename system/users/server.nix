{ inputs, user, lib, ... }:

with lib;
{
  imports = [ ./default.nix ];

  users.users = {
    ${user}.extraGroups = mkForce [ "wheel" "docker" ];
    root.openssh.authorizedKeys.keyFiles = [ "${inputs.home-estate}/authorized_keys" ];
  };
}
