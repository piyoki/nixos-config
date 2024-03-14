{ config, lib, inputs, system, ... }:

with lib;

let
  cfg = config.dotfiles.kitty;
in
{
  options.dotfiles.kitty = {
    profile = mkOption {
      type = types.str;
      default = "desktop";
      description = "host profile";
    };
  };

  config = {
    xdg.configFile."kitty/kitty.conf".source = inputs."dotfiles-${cfg.profile}".packages.${system}.kitty + "/kitty.conf";
  };
}
