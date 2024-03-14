{ pkgs, config, lib, inputs, system, ... }:

with lib;

let
  cfg = config.dotfiles.qutebrowser;
  theme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "qutebrowser";
    rev = "78bb72b4c60b421c8ea64dd7c960add6add92f83";
    sha256 = "0j47m5swip84c1iwr6nhidadk20jbncqmlarbwrabqc3idcwg7ln";
  };
in
{
  options.dotfiles.qutebrowser = {
    profile = mkOption {
      type = types.str;
      default = "desktop";
      description = "host profile";
    };
  };

  config = {
    xdg.configFile."qutebrowser/config.py".source = inputs."dotfiles-${cfg.profile}".packages.${system}.qutebrowser + "/config.py";
    xdg.configFile."qutebrowser/catppuccin".source = theme + "/";
  };
}
