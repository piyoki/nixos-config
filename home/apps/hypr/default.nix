{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-hypr";
    rev = "91487fffda5667f613a747fc5bb002e71a5eb4fd";
    sha256 = "0s1p95vsglyskjvd5zxxb31r9ymz366sjhkhfq1kpg52np2fdrx5";
  };
in
{
  xdg.configFile."hypr".source = (repo + "/");
}
