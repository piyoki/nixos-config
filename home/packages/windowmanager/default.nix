{ inputs, pkgs, sharedLib, ... }:

{
  imports = sharedLib.scanPaths ./.;

  home.packages = [
    inputs.hyprland.packages."${pkgs.system}".hyprland
  ];
}
