{ inputs, system, ... }:

# Reference:
# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
let
  pkgs-hypr = inputs.hyprland.inputs.nixpkgs.legacyPackages.${system};
in
{
  # enable hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${system}.hyprland;
  };

  # misc
  hardware.opengl = {
    # if you also want 32-bit support (e.g for Steam)
    driSupport32Bit = true;
    package = pkgs-hypr.mesa.drivers;
    package32 = pkgs-hypr.pkgsi686Linux.mesa.drivers;
  };
}
