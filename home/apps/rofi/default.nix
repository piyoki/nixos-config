{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-rofi";
    rev = "caf2c90fdd081479692a5bf48d669d5d2d2ec0be";
    sha256 = "030rzigrh33gd4mxydjrj9gl7pnl1d72hj9a5344zmxvcx1y1v0c";
  };
in
{
  xdg.configFile."rofi".source = (repo + "/");
}
