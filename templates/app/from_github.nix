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
  xdg.configFile."<path>/<file>".source = (repo + "/file");
  # or
  # xdg.configFile."<path>".source = (repo + "/");
}

