{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brightnessctl
    fd
    figlet
    fzf
    glow # Render markdown on the CLI
    graphicsmagick
    gzip
    imagemagick
    imv # A command line image viewer for tiling window managers
    jp2a # A small utility that converts JPG images to ASCII
    kitty
    ripgrep
    trash-cli
    unzip
    vivid
    yt-dlp # Command-line tool to download videos from YouTube.com and other sites
    zip
    zoxide
  ];
}
