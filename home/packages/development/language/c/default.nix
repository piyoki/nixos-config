{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cmake # Cross-platform build system
    cmake-format # Source code formatter for cmake listfiles
  ];
}
