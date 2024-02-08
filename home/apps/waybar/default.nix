{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-waybar";
    rev = "8b4948965f961077a6a2c5199160293e39671cee";
    sha256 = "1wnbkljd8h1yahmia3vgmw0gsazl5jvd0akb38ahwakiy6fwb7fg";
  };
in
{
  # xdg.configFile."waybar".source = (repo + "/");
}
