{ inputs, pkgs, ... }:

{
  home.packages = [ pkgs.fish ];

  xdg.configFile = {
    "fish/config.fish".source = "${inputs.fish}/config.fish";
    "fish/config.d".source = "${inputs.fish}/config.d";
    "fish/functions".source = "${inputs.fish}/functions";
    "fish/completions".source = "${inputs.fish}/completions";
    "fish/themes".source = "${inputs.fish}/themes";
  };
}
