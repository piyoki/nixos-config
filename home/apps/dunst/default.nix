{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-dunst";
    rev = "aaa666bcf31b2b4530c0ed3fcdc7c0d88d173e14";
    sha256 = "1009f2y5sf9f078b7wiyr5gxqzndp64xhsjrkapwbjarfv4jhdk8";
  };
in
{
  xdg.configFile."dunst".source = (repo + "/");
}
