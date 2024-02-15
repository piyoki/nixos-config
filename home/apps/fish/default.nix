{ inputs, system, ... }:

{
  xdg.configFile = {
    "fish/config.fish".source = inputs.dotfiles.packages.${system}.fish + "/config.fish";
    "fish/config.d".source = inputs.dotfiles.packages.${system}.fish + "/config.d";
    "fish/functions".source = inputs.dotfiles.packages.${system}.fish + "/functions";
    "fish/completions".source = inputs.dotfiles.packages.${system}.fish + "/completions";
    "fish/themes".source = inputs.dotfiles.packages.${system}.fish + "/themes";
  };
}
