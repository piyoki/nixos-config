{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.gwenview # image viewer
    kdePackages.okular # document viewer
    system-config-printer # gtk printer interface
    poppler_utils # pdf utils (CLI), pdfunite included
    qpdf # pdf utils (CLI)
    ghostscript # PostScript interpreter (mainline version)
  ];
}
