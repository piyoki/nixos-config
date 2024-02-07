{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    inputs.nixpkgs-wayland.packages.${system}.wdisplays # A graphical application for configuring displays in Wayland compositors
    inputs.nixpkgs-wayland.packages.${system}.wl-clipboard # Command-line copy/paste utilities for Wayland
  ];
}
