{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-swappy";
    rev = "88ec6525f8ef873320f10a4d4f5e77616f8c86fb";
    sha256 = "02cbppfqni7xk6zw0aaaym3azprlf693619196nyx023qy8qmb19";
  };
in
{
  xdg.configFile."swappy/config".source = (repo + "/config");
}
