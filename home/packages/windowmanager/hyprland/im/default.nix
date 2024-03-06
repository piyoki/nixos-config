{ pkgs, ... }:

{
  home.packages = with pkgs; [
    telegram-desktop
    cinny-desktop # Yet another matrix client for desktop
  ];
}
