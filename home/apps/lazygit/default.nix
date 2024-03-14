{ config, lib, inputs, system, ... }:

with lib;

let
  cfg = config.dotfiles.lazygit;
in
{
  options.dotfiles.lazygit = {
    profile = mkOption {
      type = types.str;
      default = "desktop";
      description = "host profile";
    };
  };

  config = {
    xdg.configFile."lazygit/config.yml".source = inputs."dotfiles-${cfg.profile}".packages.${system}.lazygit + "/config.yml";
  };
}
