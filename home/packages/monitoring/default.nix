{ pkgs, ... }:

{
  home.packages = with pkgs; [
    btop
    htop
    nvtop-intel # gpu
    bottom # process
    ncdu # disk utilization
    duf # disk usage analyzer
    powertop # power consumption
  ];
}
