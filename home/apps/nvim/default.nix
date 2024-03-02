{ config, lib, inputs, system, ... }:

with lib;

let
  cfg = config.dotfiles.nvim;
in
{
  options.dotfiles.nvim = {
    profile = mkOption config.common.profile;
  };

  config = {
    xdg.configFile."nvim".source = inputs."dotfiles-${cfg.profile}".packages.${system}.nvim + "/";
  };
}
