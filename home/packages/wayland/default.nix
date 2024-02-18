{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    xwayland
    inputs.nixpkgs-wayland.packages.${system}.wdisplays # A graphical application for configuring displays in Wayland compositors
    inputs.nixpkgs-wayland.packages.${system}.wl-clipboard # Command-line copy/paste utilities for Wayland
    inputs.nixpkgs-wayland.packages.${system}.xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlroots
    inputs.nixpkgs-wayland.packages.${system}.wlroots # A modular Wayland compositor library
    inputs.nixpkgs-wayland.packages.${system}.new-wayland-protocols # Wayland protocol extensions
  ];
}
