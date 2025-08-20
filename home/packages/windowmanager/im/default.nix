{ pkgs, ... }:

{
  home.packages = with pkgs; [
    telegram-desktop
    # webcord # A Discord and SpaceBar electron-based client implemented without Discord API
  ];
}
