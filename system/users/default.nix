{ pkgs, user, ... }:

let
  user = (import ../../vars.nix).user;
in
{
  users = {
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [];
      packages = with pkgs; [];
    };

    users.root = {
      shell = pkgs.bash;
    };
  };
}

