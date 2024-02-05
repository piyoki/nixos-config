{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neofetch
    waybar # wayland-based bar/dock
    swww # wallpaper manager
    polkit # policy daemon
    cliphist # clipboard manager
    ffmpeg
    ffmpegthumbs
    xfce.tumbler  # thumbnailer service
    dunst # notification daemon
    gnome.file-roller # archive manager
    networkmanagerapplet # network manager (gtk GUI)
  ];
}
