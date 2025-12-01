{ pkgs, ... }:

# -- Advanced PDF utilities Usage --
# convert pdf to single high-resolution image by convert (ImageMagick)
# convert -density 300 input.pdf -quality 100 output.jpg

# convert pdf to image by poppler-utils
# pdftoppm input.pdf output -jpeg

# combine multiple pdfs into one by poppler-utils
# pdfunite input1.pdf input2.pdf output.pdf

# decrypt pdf by qpdf
# qpdf --decrypt --password=PASSWORD input.pdf output.pdf

# generate a thumbnail for a pdf with pdftoppm
# pdftoppm -f 1 -l 1 -scale-to 1024 -png input.pdf thumbnail

# rescale PDFs to a target page size with ghostscript, e.g., letter size
# gs -o output.pdf -sDEVICE=pdfwrite -sPAPERSIZE=letter -dFIXEDMEDIA -dPDFFitPage input.pdf

# compress PDFs with ps2pdf, low-compression (300dpi -dPDFSETTINGS=/printer; 150dpi -dPDFSETTINGS=/ebook; 72dpi -dPDFSETTINGS=/screen)
# ps2pdf -dPDFSETTINGS=/ebook input.pdf output.pdf

{
  home.packages = with pkgs; [
    kdePackages.gwenview # image viewer
    kdePackages.okular # document viewer
    system-config-printer # gtk printer interface
    poppler-utils # pdf utils (CLI), pdfunite included
    qpdf # pdf utils (CLI)
    ghostscript # PostScript interpreter (mainline version)
    pandoc # universal document converter
  ];
}
