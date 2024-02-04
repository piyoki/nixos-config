{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-hypr";
    rev = "35cc230c93b9892d8b2b4837e27c8c2751e42a48";
    sha256 = "1bqifdqk2r36hq0x6y540andmvdsgzdlcabfs1v4qhk8qjag6c5h";
  };
in
{
  xdg.configFile."hypr".source = (repo + "/");
}
