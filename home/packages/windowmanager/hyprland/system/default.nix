{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    neofetch
    inputs.nixpkgs-wayland.packages.${system}.waybar # wayland-based bar/dock
    inputs.nixpkgs-wayland.packages.${system}.swww # Efficient animated wallpaper daemon for wayland, controlled at runtime
    cliphist # clipboard manager
    dunst # notification daemon
    ffmpeg
    ffmpegthumbs
    gnome.file-roller # archive manager
    mpd # music daemon
    networkmanagerapplet # network manager (gtk GUI)
    swayidle # idle management daemon
    xfce.tumbler  # thumbnailer service
  ];
}
