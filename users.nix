{ pkgs, user, ... }:

let
  user = (import ./vars.nix).user;
in
{
  users = {
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [];
      packages = with pkgs; [
        neovim
        neofetch
        git
        tmux
        ripgrep
        yadm
        dnsutils
   
        fzf
        fd
        delta
        gopass
        minio-client

        firefox
        kitty
        waybar
      ];
    };
    users.root = {
      shell = pkgs.bash;
    };
  };
}
