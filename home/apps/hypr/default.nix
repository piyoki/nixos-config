{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-hypr";
    rev = "56c50104b0c771f54c45be1b970170a8490c50c6";
    sha256 = "1jdgnxzq1qzzppwbzpa5mf0cx5svpnzimhk115ajpll2qq3pcxm6";
  };
in
{
  xdg.configFile."hypr".source = (repo + "/");
}
