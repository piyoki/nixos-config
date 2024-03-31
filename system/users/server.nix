{ inputs, user, lib, ... }:

with lib;
let
  keyFiles = [
    "${inputs.home-estate}/authorized_keys"
  ];
in
{
  imports = [
    ./init-pass.nix
    ./basic.nix
  ];

  users.users = {
    ${user} = {
      extraGroups = mkForce [ "wheel" ];
    };

    root = {
      openssh.authorizedKeys.keyFiles = keyFiles;
    };
  };
}
