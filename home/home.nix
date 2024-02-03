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
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # monitoring
    btop
    htop

    # networking
    dnsutils

    # essentials
    cmake
    fd
    ffmpeg
    fzf
    gcc
    ghostscript
    git
    github-cli
    gnumake
    graphicsmagick
    httpie
    lf
    minio-client
    neofetch
    ripgrep
    trash-cli
    unzip
    vivid
    yadm
    zip
    zoxide

    # encryption
    ccid
    gnupg
    pcsctools

    # window manager essentials
    xdg-user-dirs
    firefox
    kitty
    waybar

    # dev-toolings
    bat
    delta
    lazygit
    luajit
    neovim
    shfmt
    stylua
    tree-sitter
    waybar

    # devops-related
    ansible

    # rust-related
    rustc
    cargo

    # python-related
    python3
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
