{ config, lib, inputs, system, ... }:

with lib;

let
  cfg = config.dotfiles.swaylock;
in
{
  options.dotfiles.swaylock = {
    profile = mkOption config.common.profile;
  };

  config = {
    xdg.configFile."swaylock/config".source = inputs."dotfiles-${cfg.profile}".packages.${system}.swaylock + "/config";
  };
}
