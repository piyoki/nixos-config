{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    handbrake # video editor
    hyprpicker # color picker
    lf # terminal file manager
    minio-client # minio client
    rofi-wayland # app launcher
    inputs.nixpkgs-wayland.packages.${system}.wl-screenrec # screen recorder
    xfce.thunar # file manager
    xfce.thunar-archive-plugin
    libreoffice-fresh # office softwares
    ventoy # bootable usb solution
    kid3 # A simple and powerful audio tag editor
    remmina # Remote desktop client written in GTK
    # localsend # An open source cross-platform alternative to AirDrop
  ];
}
