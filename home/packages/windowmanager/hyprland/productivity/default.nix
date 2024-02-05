{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rofi-wayland # app launcher
    minio-client # minio client
    handbrake # video editor
    lf # terminal file manager
    yubikey-manager
    hyprpicker # color picker
    wl-screenrec # screen recorder
    xfce.thunar # file manager
    xfce.thunar-archive-plugin
  ];
}
