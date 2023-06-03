{ pkgs, ... }: {

  home.packages = [ pkgs.fish ];
  xdg.configFile."fish/config.fish".text = builtins.readFile ./config.fish;
  xdg.configFile."fish/functions".source = ./functions;
  xdg.configFile."fish/themes".source = ./themes;
}
