{ pkgs, ... }:

# References:
# https://mpv.io/manual/stable/
# https://wiki.archlinux.org/title/mpv
# https://github.com/tomasklaen/uosc
let
  scriptSrc = pkgs.mpvScripts.uosc;
in
{
  home.packages = [ scriptSrc ];

  xdg.configFile = {
    "mpv/mpv.conf".source = ./mpv.conf;
    "mpv/fonts".source = scriptSrc + "/share/fonts/";
    "mpv/scripts".source = scriptSrc + "/share/mpv/scripts/";
  };
}
