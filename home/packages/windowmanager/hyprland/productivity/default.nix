{ pkgs, ... }:

{
  home.packages = with pkgs; [
    handbrake # video editor
    hyprpicker # color picker
    lf # terminal file manager
    minio-client # minio client
    rofi-wayland # app launcher
    wl-screenrec # screen recorder
    xfce.thunar # file manager
    xfce.thunar-archive-plugin
  ];
}
