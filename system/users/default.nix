{ inputs, pkgs, user, ... }:

{
  users = {
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keyFiles = [
        "${inputs.home-estate}/authorized_keys"
      ];
      packages = with pkgs; [ ];
    };

    users.root = {
      shell = pkgs.bash;
    };
  };
}

