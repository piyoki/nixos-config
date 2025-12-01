{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    # localsend # An open source cross-platform alternative to AirDrop
    alacritty # A cross-platform, GPU-accelerated terminal emulator
    android-file-transfer # Reliable MTP client with minimalistic UI
    hyprpicker # color picker
    inputs.nixpkgs-wayland.packages.${system}.foot # A fast, lightweight and minimalistic Wayland terminal emulator
    inputs.nixpkgs-wayland.packages.${system}.wf-recorder # screen recorder
    asak # A cross-platform audio recording/playback CLI tool with TUI, written in Rust
    kid3 # A simple and powerful audio tag editor
    lf # terminal file manager
    termscp # A feature rich terminal UI file transfer and explorer with support for SCP/SFTP/FTP/S3/SMB
    minio-client # A replacement for ls, cp, mkdir, diff and rsync commands for filesystems and object storage
    pistol # General purpose file previewer designed for Ranger, Lf to make scope.sh redundant
    remmina # Remote desktop client written in GTK
    rofi # Application launcher and dmenu replacement
    tdf # Tui-based PDF viewer
    thunderbird # A full-featured e-mail client
    trayscale # Unofficial GUI wrapper around the Tailscale CLI client
    mountpoint-s3 # A simple, high-throughput file client for mounting an Amazon S3 bucket as a local file system.
    ventoy # bootable usb solution

    # fish plugins
    fishPlugins.fzf-fish

    # tmux addons
    sesh # Smart session manager for the terminal
  ];
}
