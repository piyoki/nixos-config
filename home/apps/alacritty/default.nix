{ config, lib, inputs, system, ... }:

with lib;

let
  cfg = config.dotfiles.alacritty;
in
{
  options.dotfiles.alacritty = {
    profile = mkOption {
      type = types.str;
      default = "desktop";
      description = "host profile";
    };
  };

  config = {
    xdg.configFile."alacritty/alacritty.toml".source = inputs."dotfiles-${cfg.profile}".packages.${system}.alacritty + "/alacritty.toml";
  };
}
