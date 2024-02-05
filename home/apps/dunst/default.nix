{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-dunst";
    rev = "a221179300189a1767bc32050add7a8009350771";
    sha256 = "0phniq0haqd6nbxmw1bzm9xkv01799w4q07z70c0xm7k1lx658mf";
  };
in
{
  xdg.configFile."dunst".source = (repo + "/");
}
