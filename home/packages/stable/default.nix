{ pkgs-stable, ... }:

{
  home.packages = with pkgs-stable; [
    # media
    cava # for visualizing audio
    # productivity
    pkgs-stable.ventoy # bootable usb solution
  ];
}
