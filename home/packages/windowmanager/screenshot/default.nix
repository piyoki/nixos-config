{ inputs, pkgs, system, ... }:

{
  home.packages = with pkgs; [
    inputs.nixpkgs-wayland.packages.${system}.grim
    inputs.nixpkgs-wayland.packages.${system}.slurp
    swappy
  ];
}
