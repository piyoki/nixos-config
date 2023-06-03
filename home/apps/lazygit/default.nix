{ pkgs, ... }: {

  home.packages = [ pkgs.lazygit ];
  xdg.configFile."lazygit/config.yml".text = builtins.readFile ./config.yml;
}
