{ config, lib, inputs, system, ... }:

with lib;

let
  cfg = config.dotfiles.fish;
in
{
  options.dotfiles.fish = {
    profile = mkOption config.common.profile;
  };

  config = {
    xdg.configFile = {
      "fish/config.fish".source = inputs."dotfiles-${cfg.profile}".packages.${system}.fish + "/config.fish";
      "fish/config.d".source = inputs."dotfiles-${cfg.profile}".packages.${system}.fish + "/config.d";
      "fish/functions".source = inputs."dotfiles-${cfg.profile}".packages.${system}.fish + "/functions";
      "fish/completions".source = inputs."dotfiles-${cfg.profile}".packages.${system}.fish + "/completions";
      "fish/themes".source = inputs."dotfiles-${cfg.profile}".packages.${system}.fish + "/themes";
    };
  };
}
