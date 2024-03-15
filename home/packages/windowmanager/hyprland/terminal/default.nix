{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cava
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
    tailspin # A log file highlighter
    atuin # Replacement for a shell history which records additional commands context with optional encrypted synchronization between machines
  ];
}
