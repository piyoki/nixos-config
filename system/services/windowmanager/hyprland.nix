{ inputs, system, pkgs, ... }:

# Reference:
# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
let
  hypr-pkgs = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  # enable hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${system}.hyprland;
  };

  # misc
  hardware.opengl = {
    package = hypr-pkgs.mesa.drivers;

    # if you also want 32-bit support (e.g for Steam)
    driSupport32Bit = true;
    package32 = hypr-pkgs.pkgsi686Linux.mesa.drivers;
  };
}
