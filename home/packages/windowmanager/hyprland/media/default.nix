{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mpv # media player
    playerctl
    spotify
    cava # for visualizing audio
    mpd # music daemon
    mpdris2 # MPRIS 2 support for mpd
    mpdevil # A simple music browser for MPD
    quodlibet # GTK-based audio player written in Python
    yt-dlp # Command-line tool to download videos from YouTube.com and other sites
  ];

  services = {
    playerctld.enable = true;
  };
}
