{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "arch-dotfiles";
    rev = "107b1e8d209abc5342800ae350fe68addf2b426d";
    sha256 = "1m1sgl86ww90a3i7gk1idbcfs296kgp006pz3q52mkwqvhj158dp";
  };
in
{
  home.packages = [ pkgs.neovim ];
  xdg.configFile."nvim".source = (repo + "/.config/nvim");
}
