{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-waybar";
    rev = "3e42cb71901523d33b3edf81068f767feb188042";
    sha256 = "07w1g4z0l3g0ij63xhkvrvxhdvkzy1h0808yaq9hdmsdxpglm5j8";
  };
in
{
  # xdg.configFile."waybar".source = (repo + "/");
}
