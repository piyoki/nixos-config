{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    inputs.nixpkgs-wayland.packages.${system}.waybar # wayland-based bar/dock
    inputs.nixpkgs-wayland.packages.${system}.swww # Efficient animated wallpaper daemon for wayland, controlled at runtime
    cliphist # clipboard manager
    dunst # notification daemon
    # swaynotificationcenter # notification daemon
    ffmpeg
    ffmpegthumbs
    gnome.file-roller # archive manager
    ark # kde file archiver
    mpd # music daemon
    networkmanagerapplet # network manager (gtk GUI)
    inputs.nixpkgs-wayland.packages.${system}.swayidle # idle management daemon
    xfce.tumbler # thumbnailer service
    inputs.nixpkgs-wayland.packages.${system}.swaylock-effects # screenlock daemon
    blueberry # bluetooth configuration tool
    rclone # Command line program to sync files and directories to and from major cloud storage
    fuse3 # Library that allows filesystems to be implemented in user space
  ];
}
