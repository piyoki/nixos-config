{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    foot # A fast, lightweight and minimalistic Wayland terminal emulator
    alacritty_git # A cross-platform, GPU-accelerated terminal emulator
    handbrake # A tool for converting video files and ripping DVDs
    hyprpicker # color picker
    lf # terminal file manager
    pistol # General purpose file previewer designed for Ranger, Lf to make scope.sh redundant
    minio-client # A replacement for ls, cp, mkdir, diff and rsync commands for filesystems and object storage
    rofi-wayland # Window switcher, run dialog and dmenu replacement for Wayland (App Launcher)
    inputs.nixpkgs-wayland.packages.${system}.wl-screenrec # screen recorder
    ventoy # bootable usb solution
    kid3 # A simple and powerful audio tag editor
    remmina # Remote desktop client written in GTK
    # localsend # An open source cross-platform alternative to AirDrop
    android-file-transfer # Reliable MTP client with minimalistic UI
    goofys # A high-performance, POSIX-ish Amazon S3 file system written in Go

    # fish plugins
    fishPlugins.fzf-fish
  ];
}
