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
  programs.go.enable = true;

  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.11";

  # fonts
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # fonts
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })

    # monitoring
    btop
    htop
    nvtop # gpu
    bottom # process
    ncdu # disk utilization

    # networking
    dnsutils

    # essentials
    cmake
    fd
    ffmpeg
    ffmpegthumbs
    figlet
    fzf
    gcc
    git
    github-cli
    glow
    gnumake
    graphicsmagick
    httpie
    imagemagick
    jq
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

    # libs
    libsForQt5.qt5.qtimageformats
    qt6.qtimageformats

    # encryption
    ccid
    gnupg
    pcsctools

    # window manager essentials
    dolphin
    dunst
    gnome.file-roller
    firefox
    gwenview
    kitty
    rofi-wayland
    swww
    telegram-desktop
    waybar
    wofi
    xdg-user-dirs
    yubikey-manager

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

  # themes
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };
  
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };
}
