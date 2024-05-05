{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gwenview # image viewer
    okular # document viewer
    libreoffice-fresh # office softwares
    poppler_utils # pdf utils (CLI), pdfunite included
    ghostscript # PostScript interpreter (mainline version)
  ];
}
