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
    # essentials
    btop
    cmake
    fd
    ffmpeg
    fish
    fzf
    gcc
    github-cli
    ghostscript
    gnumake
    gotop
    graphicsmagick
    htop
    httpie
    lf
    ripgrep
    trash-cli
    ueberzugpp
    unzip
    vivid
    xdg-user-dirs
    zip
    zoxide

    # encryption
    ccid
    gnupg
    pcsctools

    # dev-toolings
    bat
    delta
    lazygit
    luajit
    neovim
    shfmt
    stylua
    tree-sitter

    # devops-related
    ansible
    terraform
    terragrunt

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

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  };
}
