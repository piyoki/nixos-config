{ inputs, pkgs, user, ... }:

let
  keyFiles = [
    "${inputs.home-estate}/authorized_keys"
  ];
in
{
  users = {
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
      shell = pkgs.fish;
      # /etc/ssh/authorized_keys.d/${user}
      openssh.authorizedKeys.keyFiles = keyFiles;
      packages = with pkgs; [ fish ];
    };

    users.root = {
      shell = pkgs.bash;
    };
  };
}
