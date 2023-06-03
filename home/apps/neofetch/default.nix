{ pkgs, ... }: {

  home.packages = [ pkgs.neofetch ];
  xdg.configFile."neofetch/config.conf".text = builtins.readFile ./config.conf;
}
