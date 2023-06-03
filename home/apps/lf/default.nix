{ pkgs, ... }: {

  home.packages = [ pkgs.lf ];
  xdg.configFile."lf/lfrc".text = builtins.readFile ./lfrc;
  xdg.configFile."lf/colors".text = builtins.readFile ./colors;
  xdg.configFile."lf/icons".text = builtins.readFile ./icons;
}
