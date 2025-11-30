{ pkgs, ... }:

{
  home.packages = with pkgs; [
    libsForQt5.qt5.qtimageformats
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    libsForQt5.kio
    qt6Packages.qt6ct
    qt6.qtimageformats
  ];
}
