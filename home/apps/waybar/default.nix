{ config, lib, inputs, system, ... }:

with lib;

let
  cfg = config.dotfiles.waybar;
in
{
  options.dotfiles.waybar = {
    profile = mkOption {
      type = types.str;
      default = "desktop";
      description = "host profile";
    };
  };

  config = {
    xdg.configFile."waybar".source = inputs."dotfiles-${cfg.profile}".packages.${system}.waybar + "/";
  };
}
