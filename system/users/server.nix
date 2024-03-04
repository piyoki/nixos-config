{ inputs, ... }:

{
  imports = [ ./default.nix ];

  users.users.root.openssh.authorizedKeys.keyFiles = [ "${inputs.home-estate}/authorized_keys" ];
}
