{ inputs, pkgs, user, lib, ... }:

with lib;
let
  keyFiles = [
    "${inputs.home-estate}/authorized_keys"
  ];
in
{
  users.users = {
    ${user} = {
      isNormalUser = true;
      extraGroups = mkDefault [ "networkmanager" "wheel" ];
      home = "/home/${user}";
      # /etc/ssh/authorized_keys.d/${user}
      openssh.authorizedKeys.keyFiles = keyFiles;
    };

    root = {
      shell = pkgs.bash;
    };
  };
}
