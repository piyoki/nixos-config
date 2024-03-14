{ config, lib, inputs, system, ... }:

with lib;

let
  cfg = config.dotfiles.dunst;
in
{
  options.dotfiles.dunst = {
    profile = mkOption {
      type = types.str;
      default = "desktop";
      description = "host profile";
    };
  };

  config = {
    xdg.configFile."dunst".source = inputs."dotfiles-${cfg.profile}".packages.${system}.dunst + "/";
  };
}
