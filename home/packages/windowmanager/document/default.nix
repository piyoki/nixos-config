{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gwenview # image viewer
    okular # document viewer
    system-config-printer # gtk printer interface
    libreoffice-fresh # office softwares
    poppler_utils # pdf utils (CLI), pdfunite included
    ghostscript # PostScript interpreter (mainline version)
  ];
}
