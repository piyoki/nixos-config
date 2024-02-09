{ pkgs, ... }:

{
  home.packages = with pkgs; [
    btop
    htop
    nvtop # gpu
    bottom # process
    ncdu # disk utilization
    duf # dis usage analyzer
  ];
}
