# Reference:
# https://github.com/hyprwm/xdg-desktop-portal-hyprland
# https://nixos.wiki/wiki/Sway
# https://search.nixos.org/options?channel=unstable&show=xdg.portal

# Screensharing issues:
# https://wiki.hyprland.org/Configuring/Monitors/#extra-args
# https://github.com/hyprwm/xdg-desktop-portal-hyprland/issues/99

{ pkgs, inputs, system, ... }:

let
  pkgs-hypr = inputs.hyprland.packages.${system};
in
{
  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.
  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };

  programs.dconf = {
    enable = true;
  };

  # enable hyprland's xdg-desktop-portal
  xdg.portal = {
    enable = true;
    # sets environment variable NIXOS_XDG_OPEN_USE_PORTAL to 1
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs-hypr.xdg-desktop-portal-hyprland
    ];
  };
}
