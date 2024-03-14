{ config, lib, inputs, system, ... }:

with lib;

let
  cfg = config.dotfiles.rofi;
in
{
  options.dotfiles.rofi = {
    profile = mkOption {
      type = types.str;
      default = "desktop";
      description = "host profile";
    };
  };

  config = {
    xdg.configFile."rofi".source = inputs."dotfiles-${cfg.profile}".packages.${system}.rofi + "/";
  };
}
