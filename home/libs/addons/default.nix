{ pkgs, ... }:

{
  home.packages = with pkgs; [
    yt-dlp # youtube video protocol
  ];
}
