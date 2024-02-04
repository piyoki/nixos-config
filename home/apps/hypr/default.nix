{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-hypr";
    rev = "c28b373206cf654e62a86595bfb78d300e928fb5";
    sha256 = "0p4vjrb8cgsp3w7rq836b8w138l8wcklnqwqx32jsmp8fninh957";
  };
in
{
  xdg.configFile."hypr".source = (repo + "/");
}
