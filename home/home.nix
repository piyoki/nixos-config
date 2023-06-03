{ config, pkgs, ... }:

let
  user = (import ../vars.nix).user;
  python-pkgs = python-pkgs: with python-pkgs; [
    requests
    black
  ];
in
{
  imports =
    map (d: ./apps + d)
      (map (n: "/" + n)
        (with builtins;attrNames
          (readDir ./apps)));

  programs.home-manager.enable = true;
  programs.go.enable = true;

  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    bat
    btop
    delta
    fd
    ffmpeg
    fish
    fish
    fzf
    gcc
    ghostscript
    gnumake
    gnupg
    gotop
    graphicsmagick
    htop
    httpie
    lazygit
    lf
    luajit
    neovim
    python3
    ripgrep
    shfmt
    stylua
    trash-cli
    tree-sitter
    ueberzugpp
    vivid
    xdg-user-dirs
    zoxide

    # devops-related
    ansible
    terraform
    terragrunt

    # python-related
    black

    # nodejs-related
    nodePackages.prettier
    nodejs_latest
    yarn

    # go-related
    golangci-lint
    gopls
  ];
}
