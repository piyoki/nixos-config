{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
    viu # terminal image viewer
    vivid
    unzip
    trash-cli
    ripgrep
    zip
    zoxide
    brightnessctl
    fd
    fzf
    glow # cat for markdown
    gzip
    figlet
    graphicsmagick
    imagemagick
  ];
}
