{ config, lib, inputs, system, ... }:

with lib;

let
  cfg = config.dotfiles.dunst;
in
{
  options.dotfiles.dunst = {
    profile = mkOption config.common.profile;
  };

  config = {
    xdg.configFile."dunst".source = inputs."dotfiles-${cfg.profile}".packages.${system}.dunst + "/";
  };
}
