{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar # (stable) wayland-based bar/dock
    # inputs.nixpkgs-wayland.packages.${system}.waybar # (nightly) wayland-based bar/dock
    inputs.nixpkgs-wayland.packages.${system}.swww # Efficient animated wallpaper daemon for wayland, controlled at runtime
    inputs.nixpkgs-wayland.packages.${system}.swayidle # idle management daemon
    inputs.nixpkgs-wayland.packages.${system}.swaylock-effects # screenlock daemon
    cliphist # clipboard manager
    dunst # notification daemon
    # swaynotificationcenter # notification daemon
    ffmpeg
    ffmpegthumbs
    ark # kde file archiver
    xfce.tumbler # thumbnailer service
    rclone # Command line program to sync files and directories to and from major cloud storage
    fuse3 # Library that allows filesystems to be implemented in user space
    zip
    trash-cli
    unzip
  ];
}
