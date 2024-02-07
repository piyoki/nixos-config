{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-dunst";
    rev = "a1576e98dfc2f1563eb9ebfde5a6784d7a7a266d";
    sha256 = "0mzbba06bc59h3ggyxpvdslx4a2da5s9w09wayivcfrfw6h33l3d";
  };
in
{
  xdg.configFile."dunst".source = (repo + "/");
}
