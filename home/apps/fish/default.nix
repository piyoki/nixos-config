{ inputs, pkgs, ... }:

{
  home.packages = [ pkgs.fish ];

  xdg.configFile."fish/config.fish".source = "${inputs.fish}/config.fish";
  xdg.configFile."fish/config.d".source = "${inputs.fish}/config.d";
  xdg.configFile."fish/functions".source = "${inputs.fish}/functions";
  xdg.configFile."fish/themes".source = "${inputs.fish}/themes";
}
