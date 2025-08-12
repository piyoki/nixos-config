{ pkgs, ... }:

# -- Advanced PDF utilities Usage --
# convert pdf to image by poppler-utils
# pdftoppm input.pdf output -jpeg
# combine multiple pdfs into one by poppler-utils
# pdfunite input1.pdf input2.pdf output.pdf
# decrypt pdf by qpdf
# qpdf --decrypt --password=PASSWORD input.pdf output.pdf
# generate a thumbnail for a pdf with pdftoppm
# pdftoppm -f 1 -l 1 -scale-to 1024 -png input.pdf thumbnail

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
