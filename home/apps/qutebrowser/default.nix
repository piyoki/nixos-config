{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-qutebrowser";
    rev = "5e3eb770f68bb17ee1dcb09dfe8f4d8723b22a6f";
    sha256 = "0w5cj0piqvxb5lb5x7syfr000lmz88warnrycvbpd07lc7f0m13p";
  };
  theme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "qutebrowser";
    rev = "78bb72b4c60b421c8ea64dd7c960add6add92f83";
    sha256 = "0j47m5swip84c1iwr6nhidadk20jbncqmlarbwrabqc3idcwg7ln";
  };
in
{
  xdg.configFile."qutebrowser/config.py".source = (repo + "/config.py");
  xdg.configFile."qutebrowser/catppuccin".source = (theme + "/");
}
