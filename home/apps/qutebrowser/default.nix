{ inputs, pkgs, ... }:

let
  # repo = pkgs.fetchFromGitHub {
  #   owner = "yqlbu";
  #   repo = "dot-qutebrowser";
  #   rev = "42d008ab85c0298529a308aae064e6c6e3dd6256";
  #   sha256 = "15vv3ipas9jwdkd5pi928rcdpk7ki9wkhz48bncpqmjhsn8acpfj";
  # };
  theme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "qutebrowser";
    rev = "78bb72b4c60b421c8ea64dd7c960add6add92f83";
    sha256 = "0j47m5swip84c1iwr6nhidadk20jbncqmlarbwrabqc3idcwg7ln";
  };
in
{
  xdg.configFile."qutebrowser/config.py".source = (inputs.qutebrowser + "/config.py");
  xdg.configFile."qutebrowser/catppuccin".source = (theme + "/");
}
