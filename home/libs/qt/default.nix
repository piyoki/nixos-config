{ pkgs, ... }:

{
  home.packages = with pkgs; [
    libsForQt5.qt5.qtimageformats
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    kdePackages.kio-extras
    qt6Packages.qt6ct
    qt6.qtimageformats
  ];
}
