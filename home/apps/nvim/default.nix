{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-nvim";
    rev = "76fc118d04a0c3e8050a17b2d434489e034d4929";
    sha256 = "1c5d0pr2syxl0mbpm1n09cj5i61lzzsrxd9bp9p9yxw82hxak8m5";
  };
in
{
  xdg.configFile."nvim".source = (repo + "/");
}
