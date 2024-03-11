{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "";
    repo = "";
    rev = "";
    sha256 = "";
  };
in
{
  # $HOME/.config
  xdg.configFile."<path>/<file>".source = repo + "/file";
  # or
  xdg.configFile."<path>".source = repo + "/";

  # $HOME
  home.file."<path>".source = repo + "/";
}
