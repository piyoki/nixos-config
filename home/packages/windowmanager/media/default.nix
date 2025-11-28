{ inputs, pkgs, system, ... }:

{
  home.packages = with pkgs; [
    mpv # media player
    playerctl
    spotify
    mpd # music daemon
    mpdris2 # MPRIS 2 support for mpd
    mpdevil # A simple music browser for MPD
    # quodlibet # GTK-based audio player written in Python
    inputs.chaotic.packages.${system}.yt-dlp_git # Command-line tool to download videos from YouTube.com and other sites
    gapless # A simple lightweight audio player
    cava # for visualizing audio
  ];

  services = {
    playerctld.enable = true;
  };
}
