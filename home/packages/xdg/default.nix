{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xdg-utils # provides cli tools such as `xdg-mime` `xdg-open`
    xdg-user-dirs # A tool to help manage well known user directories like the desktop folder and the music folder
  ];
}
