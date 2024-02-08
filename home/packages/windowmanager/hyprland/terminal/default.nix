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
    kitty
    ripgrep
    trash-cli
    unzip
    viu # A command-line application to view images from the terminal written in Rust
    vivid
    yt-dlp # Command-line tool to download videos from YouTube.com and other sites
    zip
    zoxide
  ];
}
