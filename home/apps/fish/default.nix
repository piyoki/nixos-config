{ inputs, system, ... }:

{
  xdg.configFile = {
    "fish/config.fish".source = inputs.dotfiles.packages.${system}.fish-universal + "/config.fish";
    "fish/config.d".source = inputs.dotfiles.packages.${system}.fish-universal + "/config.d";
    "fish/functions".source = inputs.dotfiles.packages.${system}.fish-universal + "/functions";
    "fish/completions".source = inputs.dotfiles.packages.${system}.fish-universal + "/completions";
    "fish/themes".source = inputs.dotfiles.packages.${system}.fish-universal + "/themes";
  };
}
