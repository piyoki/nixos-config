{ config, lib, inputs, system, ... }:

with lib;

let
  cfg = config.dotfiles.swappy;
in
{
  options.dotfiles.swappy = {
    profile = mkOption {
      type = types.str;
      default = "desktop";
      description = "host profile";
    };
  };

  config = {
    xdg.configFile."swappy/config".source = inputs."dotfiles-${cfg.profile}".packages.${system}.swappy + "/config";
  };
}
