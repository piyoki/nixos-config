{ config, pkgs, ... }:

let
  user = (import ./vars.nix).user;
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
    brightnessctl
    cliphist # clipboard manager
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
    viu # terminal image viewer
    vivid
    xfce.tumbler  # thumbnailer service
    zip
    zoxide

    # libs
    libsForQt5.qt5.qtimageformats
    libsForQt5.ffmpegthumbs
    libsForQt5.kio-extras
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    qt6.qtimageformats
    yt-dlp # youtube video protocol

    # encryption
    ccid
    gnupg
    pcsctools

    # window manager essentials
    dunst
    firefox
    gnome.file-roller
    grim
    gwenview # image viewer
    handbrake # video editor
    hyprpicker
    kitty
    microsoft-edge-dev
    mpv
    networkmanagerapplet
    notepadqq
    okular # document viewer
    playerctl
    rofi-wayland
    slurp
    spotify
    swappy
    swww # wallpaper manager
    telegram-desktop
    waybar
    wl-screenrec # screen recorder
    xdg-user-dirs
    xfce.thunar
    xfce.thunar-archive-plugin
    yubikey-manager
    polkit

    # wayland-specific
    wdisplays
    wl-clipboard

    # peripherals
    projecteur # logitech spotlight app

    # dev-toolings
    bat
    delta
    lazygit
    luajit
    neovim
    shfmt
    stylua
    tree-sitter

    # xdg-related
    xdg-utils
    xdg-user-dirs # run: xdg-user-dirs-update

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
    name = "Bibata-Modern-Ice";
    size = 24;
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

    font = {
      name = "Cantarell Regular";
      size = 12;
    };
  };
}
