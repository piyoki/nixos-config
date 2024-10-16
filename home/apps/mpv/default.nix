{ inputs, system, ... }:

# References:
# https://mpv.io/manual/stable/
# https://wiki.archlinux.org/title/mpv
# https://github.com/tomasklaen/uosc
{
  xdg.configFile."mpv".source = inputs.dotfiles.packages.${system}.mpv-universal + "/";
  # home.packages = [ scriptSrc ];

  # xdg.configFile = {
  #   "mpv/mpv.conf".source = ./mpv.conf;
  #   "mpv/fonts".source = scriptSrc + "/share/fonts/";
  #   "mpv/scripts".source = scriptSrc + "/share/mpv/scripts/";
  # };
}
