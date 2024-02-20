{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    inputs.nixpkgs-wayland.packages.${system}.waybar # wayland-based bar/dock
    inputs.nixpkgs-wayland.packages.${system}.swww # Efficient animated wallpaper daemon for wayland, controlled at runtime
    inputs.nixpkgs-wayland.packages.${system}.swayidle # idle management daemon
    inputs.nixpkgs-wayland.packages.${system}.swaylock-effects # screenlock daemon
    cliphist # clipboard manager
    dunst # notification daemon
    # swaynotificationcenter # notification daemon
    ffmpeg
    ffmpegthumbs
    ark # kde file archiver
    mpd # music daemon
    mpdris2 # MPRIS 2 support for mpd
    mpdevil # A simple music browser for MPD
    quodlibet # GTK-based audio player written in Python
    networkmanagerapplet # network manager (gtk GUI)
    xfce.tumbler # thumbnailer service
    blueberry # bluetooth configuration tool
    rclone # Command line program to sync files and directories to and from major cloud storage
    fuse3 # Library that allows filesystems to be implemented in user space
  ];
}
