{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fd
    figlet
    fzf
    glow # Render markdown on the CLI
    graphicsmagick
    gzip
    imagemagick
    imv # A command line image viewer for tiling window managers
    jp2a # A small utility that converts JPG images to ASCII
    vivid
    zoxide
    entr # Run arbitrary commands when files change
  ];
}
