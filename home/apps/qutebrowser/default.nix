{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-qutebrowser";
    rev = "ecf2f31ddeb9332418aad63bc0a001a8cd7b7679";
    sha256 = "0d4sfm8j81x7wrh034p0bn2i9vwz5b6cibn53r4sqvs4g5gf4lrh";
  };
in
{
  xdg.configFile."qutebrowser/config.py".source = (repo + "/config.py");
}
