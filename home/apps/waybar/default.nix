{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-waybar";
    rev = "33262ec3dca3ce33b02ba8dc70a7ec37424863bf";
    sha256 = "1dr2g6vrlpcy69zlp9hzk85gyf2fmra6w017ga8bjn7dhybgwbrp";
  };
in
{
  xdg.configFile."waybar".source = (repo + "/");
}
