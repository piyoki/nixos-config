{ pkgs, inputs, system, ... }:

let
  theme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "qutebrowser";
    rev = "78bb72b4c60b421c8ea64dd7c960add6add92f83";
    sha256 = "0j47m5swip84c1iwr6nhidadk20jbncqmlarbwrabqc3idcwg7ln";
  };
in
{
  home.packages = with pkgs.python311Packages; [
    adblock # Python wrapper for Brave's adblocking library
  ];

  xdg.configFile = {
    "qutebrowser/config.py".source = inputs.dotfiles.packages.${system}.qutebrowser-universal + "/config.py";
    "qutebrowser/scripts".source = inputs.dotfiles.packages.${system}.qutebrowser-universal + "/scripts";
    "qutebrowser/catppuccin".source = theme + "/";
  };
}
