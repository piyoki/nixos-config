{ inputs, pkgs, user, ... }:

let
  keyFiles = [
    "${inputs.home-estate}/authorized_keys"
  ];
in
{
  imports = [
    ./usergroups
  ];

  users.users = {
    ${user} = {
      isNormalUser = true;
      home = "/home/${user}";
      # /etc/ssh/authorized_keys.d/${user}
      openssh.authorizedKeys.keyFiles = keyFiles;
    };

    root = {
      shell = pkgs.bash;
    };
  };
}
