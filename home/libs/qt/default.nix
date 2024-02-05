{ pkgs, ... }:

{
  home.packages = with pkgs; [
    libsForQt5.qt5.qtimageformats
    libsForQt5.ffmpegthumbs
    libsForQt5.kio-extras
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    qt6.qtimageformats
  ];
}

