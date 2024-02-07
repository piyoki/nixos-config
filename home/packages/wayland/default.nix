{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wdisplays
    wl-clipboard
  ];
}
