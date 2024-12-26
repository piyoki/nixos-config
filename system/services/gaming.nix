{ pkgs, ... }:

# Reference:
# https://nixos.wiki/wiki/Lutris
# https://lutris.net

{
  environment.systemPackages = [ pkgs.lutris ];
}
