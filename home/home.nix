{ config, pkgs, ... }:

let
  user = (import ../vars.nix).user;
in
{
  imports =
    map (d: ./apps + d)
      (map (n: "/" + n)
        (with builtins;attrNames
          (readDir ./apps)));

  programs.home-manager.enable = true;

  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    btop
    delta
    fd
    fish
    fzf
    go
    htop
    httpie
    lazygit
    neovim
    ripgrep
    vivid
    xdg-user-dirs
    yadm
  ];
}
