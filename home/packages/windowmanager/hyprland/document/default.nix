{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gwenview # image viewer
    okular # document viewer
    libreoffice-fresh # office softwares
    poppler-utils # pdf utils (CLI), pdfunite included
  ];
}
