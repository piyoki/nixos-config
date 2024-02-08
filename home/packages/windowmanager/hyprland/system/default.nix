{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    neofetch
    inputs.nixpkgs-wayland.packages.${system}.waybar # wayland-based bar/dock
    inputs.nixpkgs-wayland.packages.${system}.swww # Efficient animated wallpaper daemon for wayland, controlled at runtime
    polkit # policy daemon
    cliphist # clipboard manager
    ffmpeg
    ffmpegthumbs
    xfce.tumbler  # thumbnailer service
    dunst # notification daemon
    gnome.file-roller # archive manager
    networkmanagerapplet # network manager (gtk GUI)
    swayidle # idle management daemon
  ];
}
