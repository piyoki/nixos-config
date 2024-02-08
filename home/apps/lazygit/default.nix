{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-qutebrowser";
    rev = "067cc94d41624e32ea52632d8eaad91be64f1c25";
    sha256 = "1ai7nhbcccip9a242p82ky2iyhn7i0rv6350qmc5bnh81b0hgxdf";
  };
in
{
  xdg.configFile."lazygit/config.yml".source = (repo + "/config.yml");
}
