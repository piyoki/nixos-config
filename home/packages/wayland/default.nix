{ inputs, system, ... }:

{
  home.packages = with inputs.nixpkgs-wayland.packages.${system}; [
    wdisplays # A graphical application for configuring displays in Wayland compositors
    wl-clipboard # Command-line copy/paste utilities for Wayland
    # xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlroots
    # wlroots # A modular Wayland compositor library
    # new-wayland-protocols # Wayland protocol extensions
    wev # Wayland event viewer
    wlr-randr # A tool to configure outputs for wlroots-based Wayland compositors
  ];
}
