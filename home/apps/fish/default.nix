{ pkgs, ... }:

{
  home.packages = [ pkgs.fish ];
  xdg.configFile."fish/config.fish".text = builtins.readFile ./config.fish;
  xdg.configFile."fish/functions/bangbang.fish".source = ./functions/bangbang.fish;
  xdg.configFile."fish/functions/fish_prompt.fish".source = ./functions/fish_prompt.fish;
  xdg.configFile."fish/themes".source = ./themes;
}
