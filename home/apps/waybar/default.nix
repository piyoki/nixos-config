{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-waybar";
    rev = "6be67d2322119acd1a3208576b848e6033188334";
    sha256 = "0gibgwv0hxcf477wxcpvcj0gjdvrkd3vsvsqj9z2lccdad21hvfq";
  };
in
{
  xdg.configFile."waybar".source = (repo + "/");
}
