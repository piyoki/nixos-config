{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-qutebrowser";
    rev = "2f71794504417a8a4cfded9939f44e97ad6cab89";
    sha256 = "124914raz6b8nkk5imd62w06i13cyl3bxnq9rq0dz78js1yrky11";
  };
in
{
  xdg.configFile."qutebrowser/config.py".source = (repo + "/config.py");
}
