{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-waybar";
    rev = "7ee7e41d14c35c052d8ec65b467ac8af9a966bfe";
    sha256 = "18qv6sxjv1d8779pvvmzhny5vvjqjlgpgdcvglhcjwi8sk6qigvr";
  };
in
{
  xdg.configFile."waybar".source = (repo + "/");
}
