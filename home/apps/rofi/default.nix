{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-rofi";
    rev = "c9891dbe2d34e3c4ef541229365fb86355741132";
    sha256 = "16ixjrm01qwvxx9awa47i49s0narjnf6gni6wq9ljd7ps76f3wk6";
  };
in
{
  xdg.configFile."rofi".source = (repo + "/");
}
