{ config, lib, inputs, system, ... }:

with lib;

let
  cfg = config.dotfiles.waybar;
in
{
  options.dotfiles.waybar = {
    profile = mkOption {
      type = types.str;
      default = "universal";
      description = "host profile";
    };
  };

  config = {
    xdg.configFile."waybar".source = inputs.dotfiles.packages.${system}."waybar-${cfg.profile}" + "/";
  };
}
