{ config, lib, inputs, system, ... }:

with lib;

let
  cfg = config.dotfiles.lf;
in
{
  options.dotfiles.lf = {
    profile = mkOption {
      type = types.str;
      default = "desktop";
      description = "host profile";
    };
  };

  config = {
    xdg.configFile."lf".source = inputs."dotfiles-${cfg.profile}".packages.${system}.lf + "/";
  };
}
