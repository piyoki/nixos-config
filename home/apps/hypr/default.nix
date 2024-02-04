{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-hypr";
    rev = "5e71f2fd9b0992c73872d34d0bc6a8570724172f";
    sha256 = "0sa4s1gx13lcrlf85jklixgcl7k1plzy6v6xlpy49h673xxivrnl";
  };
in
{
  # xdg.configFile."hypr".source = (repo + "/");
}
