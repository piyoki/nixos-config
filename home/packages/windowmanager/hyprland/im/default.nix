{ inputs, pkgs, system, ... }:

{
  home.packages = with pkgs; [
    inputs.chaotic.packages.${system}.telegram-desktop_git
    cinny-desktop # Yet another matrix client for desktop
    webcord # A Discord and SpaceBar electron-based client implemented without Discord API
  ];
}
