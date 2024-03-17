{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty # terminal emulator
    alacritty_git # terminal emulator
    handbrake # video editor
    hyprpicker # color picker
    lf # terminal file manager
    pistol # file previewer
    minio-client # minio client
    rofi-wayland # app launcher
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
