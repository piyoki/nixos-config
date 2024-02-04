{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-rofi";
    rev = "b8ded7a4408bb57a0ff1fa14533c9c709e9d2d81";
    sha256 = "0v95nh6znbp7y0xw7vpy36qk4y4fhlclz5jjdi9x03558wq4sz01";
  };
in
{
  xdg.configFile."rofi".source = (repo + "/");
}
