# References:

# ffmpeg commands to compress video
# ffmpeg -i input.mp4 -vcodec h264 -b:v 700k -acodec mp3 output.mp4

{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    inputs.waybar.packages.${system}.waybar # (nightly) wayland-based bar/dock
    inputs.nixpkgs-wayland.packages.${system}.swayidle # idle management daemon
    cliphist # clipboard manager
    dunst # notification daemon
    # swaynotificationcenter # notification daemon
    ffmpeg
    kdePackages.ffmpegthumbs
    kdePackages.ark # kde file archiver
    xfce.tumbler # thumbnailer service
    rclone # Command line program to sync files and directories to and from major cloud storage
    fuse3 # Library that allows filesystems to be implemented in user space
    zip
    trash-cli
    unzip
  ];
}
