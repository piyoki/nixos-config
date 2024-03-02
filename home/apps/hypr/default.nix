{ config, lib, inputs, system, ... }:

with lib;

let
  cfg = config.dotfiles.hypr;
in
{
  options.dotfiles.hypr = {
    profile = mkOption config.common.profile;
  };

  config = {
    xdg.configFile."hypr".source = inputs."dotfiles-${cfg.profile}".packages.${system}.hypr + "/";
  };
}
