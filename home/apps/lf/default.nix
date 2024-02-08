{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-lf";
    rev = "54992b2cc08dc753a4aebce80c57483fef315f21";
    sha256 = "0w98rq4v304mrllmizqkr1mxbbh7204hj3z61fw7jvql4rc3ldgp";
  };
in
{
  xdg.configFile."lf".source = (repo + "/");
}

