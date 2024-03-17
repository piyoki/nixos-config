{ config, lib, inputs, system, ... }:

with lib;

let
  cfg = config.dotfiles.dunst;
in
{
  options.dotfiles.dunst = {
    profile = mkOption {
      type = types.str;
      default = "universal";
      description = "host profile";
    };
  };

  config = {
    xdg.configFile."dunst".source = inputs.dotfiles.packages.${system}."dunst-${cfg.profile}" + "/";
  };
}
