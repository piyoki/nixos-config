{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    # localsend # An open source cross-platform alternative to AirDrop
    alacritty_git # A cross-platform, GPU-accelerated terminal emulator
    android-file-transfer # Reliable MTP client with minimalistic UI
    goofys # A high-performance, POSIX-ish Amazon S3 file system written in Go
    hyprpicker # color picker
    inputs.nixpkgs-wayland.packages.${system}.foot # A fast, lightweight and minimalistic Wayland terminal emulator
    inputs.nixpkgs-wayland.packages.${system}.wf-recorder # screen recorder
    kid3 # A simple and powerful audio tag editor
    lf # terminal file manager
    minio-client # A replacement for ls, cp, mkdir, diff and rsync commands for filesystems and object storage
    pistol # General purpose file previewer designed for Ranger, Lf to make scope.sh redundant
    remmina # Remote desktop client written in GTK
    rofi-wayland # Window switcher, run dialog and dmenu replacement for Wayland (App Launcher)
    tdf # Tui-based PDF viewer
    thunderbird # A full-featured e-mail client
    ventoy # bootable usb solution

    # fish plugins
    fishPlugins.fzf-fish
  ];
}
